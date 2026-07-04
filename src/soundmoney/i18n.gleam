//// Internationalization strings for the Sound Money blog.

pub type Language {
  Russian
  Kazakh
}

pub fn language_code(lang: Language) -> String {
  case lang {
    Russian -> "ru"
    Kazakh -> "kz"
  }
}

pub fn language_name(lang: Language) -> String {
  case lang {
    Russian -> "Русский"
    Kazakh -> "Қазақша"
  }
}

pub fn site_title(_lang: Language) -> String {
  "Sound Money"
}

pub fn site_subtitle(lang: Language) -> String {
  case lang {
    Russian -> "О Биткоине и Австрийской школе экономики"
    Kazakh -> "Биткоин және Австрия экономикалық мектебі туралы"
  }
}

pub fn meta_description(lang: Language) -> String {
  case lang {
    Russian ->
      "Блог " <> author_name_genitive(lang) <> " о Биткоине, австрийской экономической школе и личных финансах."
    Kazakh ->
      author_name_nominative(lang) <> "тың Биткоин, Австрия экономикалық мектебі және жеке қаржы туралы блогы."
  }
}

pub fn home(lang: Language) -> String {
  case lang {
    Russian -> "Главная"
    Kazakh -> "Басты бет"
  }
}

pub fn about(lang: Language) -> String {
  case lang {
    Russian -> "О блоге"
    Kazakh -> "Блог туралы"
  }
}

pub fn articles(lang: Language) -> String {
  case lang {
    Russian -> "Статьи"
    Kazakh -> "Мақалалар"
  }
}

pub fn read_more(lang: Language) -> String {
  case lang {
    Russian -> "Читать далее"
    Kazakh -> "Толығырақ оқыңыз"
  }
}

pub fn author(lang: Language) -> String {
  case lang {
    Russian -> "Автор"
    Kazakh -> "Автор"
  }
}

pub fn choose_language(_lang: Language) -> String {
  "Choose language / Выберите язык / Тілді таңдаңыз"
}

pub fn about_text(lang: Language) -> String {
  case lang {
    Russian -> "Этот блог посвящен Биткоину, принципам австрийской школы экономики и личной финансовой свободе. Здесь вы найдете аналитические статьи, практические руководства и размышления о будущем денег."
    Kazakh -> "Бұл блог Биткоинге, Австрия экономикалық мектебінің принциптеріне және жеке қаржы еркіндігіне арналған. Мұнда сіз аналитикалық мақалалар, практикалық нұсқаулықтар және ақшаның болашағы туралы ойлар таба аласыз."
  }
}

pub fn about_author(lang: Language) -> String {
  case lang {
    Russian -> "Автор блога — " <> author_name_nominative(lang) <> "."
    Kazakh -> "Блог авторы — " <> author_name_nominative(lang) <> "."
  }
}

pub fn author_name_nominative(lang: Language) -> String {
  case lang {
    Russian -> "Бейбут Ержанов"
    Kazakh -> "Бейбит Ержанов"
  }
}

fn author_name_genitive(lang: Language) -> String {
  case lang {
    Russian -> "Бейбута Ержанова"
    Kazakh -> "Бейбит Ержанов"
  }
}

pub fn built_with(lang: Language) -> String {
  case lang {
    Russian -> "Создано с помощью"
    Kazakh -> "Құрастырылған"
  }
}

pub fn rss_feed(lang: Language) -> String {
  case lang {
    Russian -> "RSS-лента"
    Kazakh -> "RSS-таспа"
  }
}

pub fn tag(lang: Language) -> String {
  case lang {
    Russian -> "Тег"
    Kazakh -> "Тег"
  }
}
