// Typelizer digest 8f5eb4ab68a704a5e037e2e0d93b632b
//
// DO NOT MODIFY: This file was automatically generated by Typelizer.
import type {User} from '@/types'

type BlogPost = {
  creator: User;
  id: number;
  name: string | null;
  slug: string | null;
  description: string | null;
  body: string | null;
  state: "draft" | "published" | "archived" | null;
  locale: string | null;
  created_at: string;
  cover_thumb_variant: string | null;
  cover_list_variant: string | null;
  cover_main_variant: string | null;
  reading_time: number;
  likes_count: number;
}

export default BlogPost;
