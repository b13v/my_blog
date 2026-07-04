//// Blogatto configuration for the Sound Money blog.

import blogatto/config
import blogatto/config/feed
import blogatto/config/markdown
import blogatto/config/robots
import blogatto/config/sitemap
import blogatto/post.{type Post}
import gleam/list
import gleam/option
import gleam/string
import soundmoney/i18n.{type Language}
import soundmoney/views

const site_url = "https://soundmoney.kz"

pub fn build_config() -> config.Config(Nil) {
  let md =
    markdown.default()
    |> markdown.markdown_path("./blog")
    |> markdown.route_prefix("blog")
    |> markdown.template(views.post_template)

  config.new(site_url)
  |> config.output_dir("./dist")
  |> config.static_dir("./static")
  |> config.markdown(md)
  |> config.route("/", language_selection_view)
  |> config.route("/ru/", home_view_ru)
  |> config.route("/kz/", home_view_kz)
  |> config.route("/ru/about/", about_view_ru)
  |> config.route("/kz/about/", about_view_kz)
  |> config.feed(rss_feed(i18n.Russian))
  |> config.feed(rss_feed(i18n.Kazakh))
  |> config.sitemap(
    sitemap.new("/sitemap.xml")
    |> sitemap.serialize(sitemap_entry),
  )
  |> config.robots(robots_config())
}

fn language_selection_view(_posts: List(Post(Nil))) {
  views.language_selection_page()
}

fn home_view_ru(posts: List(Post(Nil))) {
  views.home_page(i18n.Russian, site_url, posts_by_language(posts, i18n.Russian))
}

fn home_view_kz(posts: List(Post(Nil))) {
  views.home_page(i18n.Kazakh, site_url, posts_by_language(posts, i18n.Kazakh))
}

fn about_view_ru(_posts: List(Post(Nil))) {
  views.about_page(i18n.Russian, site_url)
}

fn about_view_kz(_posts: List(Post(Nil))) {
  views.about_page(i18n.Kazakh, site_url)
}

fn posts_by_language(
  posts: List(Post(Nil)),
  language: Language,
) -> List(Post(Nil)) {
  let code = i18n.language_code(language)
  list.filter(posts, fn(post) {
    option.unwrap(post.language, "ru") == code
  })
}

fn rss_feed(language: Language) -> feed.FeedConfig(Nil) {
  let code = i18n.language_code(language)

  feed.new(
    i18n.site_title(language) <> " — " <> i18n.site_subtitle(language),
    site_url <> "/" <> code <> "/",
    i18n.meta_description(language),
  )
  |> feed.output("/" <> code <> "/rss.xml")
  |> feed.language(code)
  |> feed.generator("Blogatto")
  |> feed.filter(fn(metadata) {
    option.unwrap(metadata.post.language, "ru") == code
  })
}

fn sitemap_entry(route: String) -> sitemap.SitemapEntry {
  let url = case string.ends_with(route, "/") {
    True -> route
    False -> route <> "/"
  }

  let path = case string.split_once(url, "//") {
    Ok(#(_, rest)) -> {
      case string.split_once(rest, "/") {
        Ok(#(_, path_part)) -> "/" <> path_part
        Error(_) -> "/"
      }
    }
    Error(_) -> url
  }

  let priority = case path {
    "/" -> 1.0
    "/ru/" | "/kz/" -> 0.9
    "/ru/about/" | "/kz/about/" -> 0.7
    _ -> 0.8
  }

  sitemap.SitemapEntry(
    url: url,
    priority: option.Some(priority),
    last_modified: option.None,
    change_frequency: option.Some(sitemap.Weekly),
  )
}

fn robots_config() -> robots.RobotsConfig {
  robots.RobotsConfig(
    sitemap_url: site_url <> "/sitemap.xml",
    robots: [
      robots.Robot(
        user_agent: "*",
        allowed_routes: ["/"],
        disallowed_routes: [],
      ),
    ],
  )
}
