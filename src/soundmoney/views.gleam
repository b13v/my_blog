//// Shared Lustre views for the Sound Money blog.

import blogatto/post.{type Post}
import gleam/dict
import gleam/int
import gleam/list
import gleam/option
import gleam/string
import gleam/time/calendar
import gleam/time/timestamp
import lustre/attribute
import lustre/element.{type Element}
import lustre/element/html
import soundmoney/i18n.{type Language}

pub fn page(
  lang: Language,
  title: String,
  description: String,
  site_url: String,
  children: List(Element(Nil)),
) -> Element(Nil) {
  let lang_code = i18n.language_code(lang)

  html.html([attribute.lang(lang_code), attribute.class("theme-dark")], [
    html.head([], [
      html.meta([attribute.charset("UTF-8")]),
      html.meta([
        attribute.name("viewport"),
        attribute.content("width=device-width, initial-scale=1"),
      ]),
      html.title([], title <> " — " <> i18n.site_title(lang)),
      html.meta([attribute.name("description"), attribute.content(description)]),
      html.link([
        attribute.rel("stylesheet"),
        attribute.href("/css/style.css"),
      ]),
      html.link([
        attribute.rel("alternate"),
        attribute.attribute("type", "application/rss+xml"),
        attribute.title(i18n.site_title(lang)),
        attribute.href("/" <> lang_code <> "/rss.xml"),
      ]),
    ]),
    html.body([], [
      header(lang),
      html.main([attribute.class("main")], children),
      footer(lang, site_url),
    ]),
  ])
}

fn header(lang: Language) -> Element(Nil) {
  html.header([attribute.class("site-header")], [
    html.div([attribute.class("container header-inner")], [
      html.a([attribute.href("/" <> i18n.language_code(lang) <> "/")], [
        html.div([attribute.class("brand")], [
          html.h1([attribute.class("brand-title")], [
            element.text(i18n.site_title(lang)),
          ]),
          html.p([attribute.class("brand-subtitle")], [
            element.text(i18n.site_subtitle(lang)),
          ]),
        ]),
      ]),
      html.nav([attribute.class("site-nav")], [
        html.a(
          [attribute.href("/" <> i18n.language_code(lang) <> "/")],
          [element.text(i18n.home(lang))],
        ),
        html.a(
          [attribute.href("/" <> i18n.language_code(lang) <> "/about/")],
          [element.text(i18n.about(lang))],
        ),
        language_switcher(lang),
      ]),
    ]),
  ])
}

fn language_switcher(current: Language) -> Element(Nil) {
  let languages = [i18n.Russian, i18n.Kazakh]

  html.div([attribute.class("language-switcher")], [
    html.span([attribute.class("language-label")], [element.text("🌐 ")]),
    html.span(
      [],
      list.map(languages, fn(lang) {
        let code = i18n.language_code(lang)
        case lang == current {
          True ->
            html.span([attribute.class("language-current")], [
              element.text(i18n.language_name(lang)),
            ])
          False ->
            html.a([attribute.href("/" <> code <> "/")], [
              element.text(i18n.language_name(lang)),
            ])
        }
      })
      |> list.intersperse(html.span([], [element.text(" / ")])),
    ),
  ])
}

fn footer(lang: Language, _site_url: String) -> Element(Nil) {
  html.footer([attribute.class("site-footer")], [
    html.div([attribute.class("container footer-inner")], [
      html.p([], [
        element.text("© " <> current_year() <> " " <> i18n.site_title(lang)),
      ]),
      html.p([], [
        element.text(i18n.built_with(lang) <> " "),
        html.a([attribute.href("https://github.com/veeso/blogatto")], [
          element.text("Blogatto"),
        ]),
      ]),
      html.p([], [
        html.a(
          [attribute.href("/" <> i18n.language_code(lang) <> "/rss.xml")],
          [element.text(i18n.rss_feed(lang))],
        ),
      ]),
    ]),
  ])
}

fn current_year() -> String {
  let #(date, _) =
    timestamp.system_time()
    |> timestamp.to_calendar(calendar.utc_offset)
  int.to_string(date.year)
}

pub fn language_selection_page() -> Element(Nil) {
  html.html([attribute.lang("en"), attribute.class("theme-dark")], [
    html.head([], [
      html.meta([attribute.charset("UTF-8")]),
      html.meta([
        attribute.name("viewport"),
        attribute.content("width=device-width, initial-scale=1"),
      ]),
      html.title([], i18n.site_title(i18n.Russian) <> " — Sound Money"),
      html.link([
        attribute.rel("stylesheet"),
        attribute.href("/css/style.css"),
      ]),
    ]),
    html.body([], [
      html.main([attribute.class("main language-selection")], [
        html.div([attribute.class("container")], [
          html.h1([attribute.class("hero-title")], [
            element.text(i18n.site_title(i18n.Russian)),
          ]),
          html.p([attribute.class("hero-subtitle")], [
            element.text(i18n.choose_language(i18n.Russian)),
          ]),
          html.div([attribute.class("language-cards")], [
            language_card(i18n.Russian),
            language_card(i18n.Kazakh),
          ]),
        ]),
      ]),
      html.footer([attribute.class("site-footer")], [
        html.div([attribute.class("container footer-inner")], [
          html.p([], [element.text("© " <> current_year() <> " Sound Money")]),
        ]),
      ]),
    ]),
  ])
}

fn language_card(lang: Language) -> Element(Nil) {
  let code = i18n.language_code(lang)

  html.a([attribute.href("/" <> code <> "/"), attribute.class("language-card")], [
    html.h2([], [element.text(i18n.language_name(lang))]),
  ])
}

pub fn home_page(
  lang: Language,
  site_url: String,
  posts: List(Post(Nil)),
) -> Element(Nil) {
  page(
    lang,
    i18n.home(lang),
    i18n.meta_description(lang),
    site_url,
    [
      html.div([attribute.class("container")], [
        html.section([attribute.class("hero")], [
          html.img([
            attribute.src("/images/btc_dawn.png"),
            attribute.alt("Bitcoin dawn"),
            attribute.class("hero-image"),
          ]),
        ]),
        html.section([attribute.class("articles")], [
          html.h2([attribute.class("section-title")], [
            element.text(i18n.articles(lang)),
          ]),
          post_list(lang, posts),
        ]),
      ]),
    ],
  )
}

pub fn about_page(lang: Language, site_url: String) -> Element(Nil) {
  page(
    lang,
    i18n.about(lang),
    i18n.meta_description(lang),
    site_url,
    [
      html.div([attribute.class("container")], [
        html.article([attribute.class("about-article")], [
          html.h1([attribute.class("page-title")], [
            element.text(i18n.about(lang)),
          ]),
          html.p([], [element.text(i18n.about_text(lang))]),
          html.p([], [element.text(i18n.about_author(lang))]),
        ]),
      ]),
    ],
  )
}

fn post_list(lang: Language, posts: List(Post(Nil))) -> Element(Nil) {
  case posts {
    [] -> html.p([attribute.class("empty-posts")], [element.text("No posts yet.")])
    _ ->
      html.ul(
        [attribute.class("post-list")],
        list.map(posts, fn(post) { post_card(lang, post) }),
      )
  }
}

fn post_card(lang: Language, post: Post(Nil)) -> Element(Nil) {
  let tags = tags_from_post(post)
  let path = post_path(post)

  html.li([attribute.class("post-card")], [
    html.h3([attribute.class("post-title")], [
      html.a([attribute.href(path)], [element.text(post.title)]),
    ]),
    html.p([attribute.class("post-meta")], [
      html.time([], [element.text(format_date(post.date))]),
    ]),
    html.p([attribute.class("post-description")], [
      element.text(post.description),
    ]),
    html.div([attribute.class("post-tags")], tags),
    html.a([attribute.href(path), attribute.class("post-link")], [
      element.text(i18n.read_more(lang)),
    ]),
  ])
}

fn post_path(post: Post(Nil)) -> String {
  let lang = option.unwrap(post.language, "ru")
  "/blog/" <> lang <> "/" <> post.slug <> "/"
}

fn post_hero_image(post: Post(Nil)) -> Element(Nil) {
  case dict.get(post.extras, "image") {
    Ok(src) ->
      html.img([
        attribute.src(src),
        attribute.alt(post.title),
        attribute.class("post-hero-image"),
      ])
    Error(_) -> element.text("")
  }
}

fn tags_from_post(post: Post(Nil)) -> List(Element(Nil)) {
  case dict.get(post.extras, "tags") {
    Ok(tags) ->
      tags
      |> string.split(",")
      |> list.map(string.trim)
      |> list.filter(fn(t) { t != "" })
      |> list.map(fn(tag) {
        html.span([attribute.class("post-tag")], [element.text(tag)])
      })
    Error(_) -> []
  }
}

pub fn post_template(post: Post(Nil)) -> Element(Nil) {
  let lang = option.unwrap(post.language, "ru")
  let language = case lang {
    "kz" -> i18n.Kazakh
    _ -> i18n.Russian
  }
  let tags = tags_from_post(post)

  page(
    language,
    post.title,
    post.description,
    post.url,
    [
      html.div([attribute.class("container")], [
        html.article([attribute.class("post-article")], [
          html.header([attribute.class("post-header")], [
            html.h1([attribute.class("post-title")], [element.text(post.title)]),
            html.p([attribute.class("post-meta")], [
              html.time([], [element.text(format_date(post.date))]),
            ]),
            html.p([attribute.class("post-description")], [
              html.em([], [element.text(post.description)]),
            ]),
            html.div([attribute.class("post-tags")], tags),
            post_hero_image(post),
          ]),
          html.div([attribute.class("post-content")], post.contents),
        ]),
      ]),
    ],
  )
}

fn format_date(date: timestamp.Timestamp) -> String {
  let #(c_date, _) = timestamp.to_calendar(date, calendar.utc_offset)
  let pad = fn(n) {
    case n < 10 {
      True -> "0" <> int.to_string(n)
      False -> int.to_string(n)
    }
  }

  pad(c_date.day) <> "." <> pad(calendar.month_to_int(c_date.month)) <> "." <> int.to_string(c_date.year)
}
