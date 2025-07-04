Sentry.init do |config|
  config.release = configus.hexlet_basics_release_version

  config.breadcrumbs_logger = %i[active_support_logger http_logger]
  config.traces_sample_rate = 0.1
  config.profiles_sample_rate = 0.1

  config.send_default_pii = true
  config.send_modules = false
  config.rails.report_rescued_exceptions = true

  config.excluded_exceptions += [
    "ActionController::RoutingError",
    "ActionController::UnknownFormat",
    "ActiveRecord::RecordNotFound",
    "Faraday::ConnectionFailed",
    "Pundit::NotAuthorizedError",
    "Mime::Type::InvalidMimeType",
    "ActionDispatch::RemoteIp::IpSpoofAttackError"
  ]
end
