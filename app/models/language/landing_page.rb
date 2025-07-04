# == Schema Information
#
# Table name: language_landing_pages
#
#  id                          :bigint           not null, primary key
#  description                 :string
#  footer                      :boolean
#  footer_name                 :string
#  header                      :string
#  listed                      :boolean
#  locale                      :string
#  main                        :boolean
#  meta_description            :string
#  meta_title                  :string
#  name                        :string
#  order                       :string
#  outcomes_description        :string
#  outcomes_header             :string
#  slug                        :string
#  state                       :string
#  used_in_description         :string
#  used_in_header              :string
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#  landing_page_to_redirect_id :bigint
#  language_category_id        :integer
#  language_id                 :integer          not null
#
# Indexes
#
#  index_language_landing_pages_on_landing_page_to_redirect_id  (landing_page_to_redirect_id)
#  index_language_landing_pages_on_language_category_id         (language_category_id)
#  index_language_landing_pages_on_language_id                  (language_id)
#
# Foreign Keys
#
#  fk_rails_...  (landing_page_to_redirect_id => language_landing_pages.id)
#  fk_rails_...  (language_category_id => language_categories.id)
#  fk_rails_...  (language_id => languages.id)
#
class Language::LandingPage < ApplicationRecord
  include Language::LandingPageRepository

  belongs_to :language
  belongs_to :landing_page_to_redirect, optional: true, class_name: "Language::LandingPage"
  # belongs_to :language_category, class_name: "Language::Category"
  has_many :qna_items, foreign_key: "language_landing_page_id"
  validates :meta_title, presence: true
  validates :header, presence: true
  validates :name, presence: true
  # validates :footer_name, presence: true, if: :footer?
  validates :slug, presence: true, uniqueness: { scope: :locale }
  validates :main, uniqueness: { scope: [ :locale, :language_id ] }, if: :main?
  # validates :description, presence: true
  validates :locale, presence: true # , inclusion: I18n.available_locales
  validates :description, presence: true, if: :published?

  has_many :language_category_items, class_name: "Language::Category::Item", foreign_key: "language_landing_page_id"
  has_many :language_categories, through: :language_category_items, source: "language_category"

  has_one_attached :outcomes_image do |attachable|
    attachable.variant :thumb, resize_to_limit: [ 39, 32 ], preprocessed: true
    attachable.variant :main, resize_to_limit: [ 640, 360 ], preprocessed: true
  end

  def self.ransackable_associations(auth_object = nil)
    [ "language" ]
  end

  def self.ransackable_attributes(_auth_object = nil)
    [ "id", "created_at", "language_slug", "state" ]
  end

  enum :state, { draft: "draft", archived: "archived", published: "published" }, default: "draft"

  def to_s
    header
  end
end
