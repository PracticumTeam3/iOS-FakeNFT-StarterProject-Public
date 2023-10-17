// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum L {
  public enum Alert {
    /// Закрыть
    public static let close = L.tr("Localizable", "alert.close", fallback: "Закрыть")
    /// Нет
    public static let no = L.tr("Localizable", "alert.no", fallback: "Нет")
    /// Localizable.strings
    ///   FakeNFT
    public static let ok = L.tr("Localizable", "alert.ok", fallback: "ОК")
    /// Попробовать еще раз
    public static let tryAgain = L.tr("Localizable", "alert.tryAgain", fallback: "Попробовать еще раз")
    /// Да
    public static let yes = L.tr("Localizable", "alert.yes", fallback: "Да")
  }
  public enum Cart {
    /// Оплатить
    public static let pay = L.tr("Localizable", "cart.pay", fallback: "Оплатить")
    /// Корзина
    public static let title = L.tr("Localizable", "cart.title", fallback: "Корзина")
    /// К оплате
    public static let toBePaid = L.tr("Localizable", "cart.toBePaid", fallback: "К оплате")
  }
  public enum Catalog {
    /// Каталог
    public static let title = L.tr("Localizable", "catalog.title", fallback: "Каталог")
  }
  public enum Network {
    public enum Error {
      /// Что-то пошло не так
      public static let httpStatusCode = L.tr("Localizable", "network.error.httpStatusCode", fallback: "Что-то пошло не так")
      /// Слишком много запросов. Попробуйте снова позже.
      public static let httpStatusCode429 = L.tr("Localizable", "network.error.httpStatusCode429", fallback: "Слишком много запросов. Попробуйте снова позже.")
      /// Ошибка клиента
      public static let httpStatusCode4xx = L.tr("Localizable", "network.error.httpStatusCode4xx", fallback: "Ошибка клиента")
      /// Ошибка сервера
      public static let httpStatusCode5xx = L.tr("Localizable", "network.error.httpStatusCode5xx", fallback: "Ошибка сервера")
      /// Не удалось обработать ответ сервера
      public static let parsingError = L.tr("Localizable", "network.error.parsingError", fallback: "Не удалось обработать ответ сервера")
      /// Что-то пошло не так
      public static let urlRequestError = L.tr("Localizable", "network.error.urlRequestError", fallback: "Что-то пошло не так")
      /// Что-то пошло не так
      public static let urlSessionError = L.tr("Localizable", "network.error.urlSessionError", fallback: "Что-то пошло не так")
    }
  }
  public enum Profile {
    /// О разработчике
    public static let about = L.tr("Localizable", "profile.about", fallback: "О разработчике")
    /// Описание
    public static let description = L.tr("Localizable", "profile.description", fallback: "Описание")
    /// Plural format key: "%#@VARIABLE@"
    public static func favouriteNFT(_ p1: Int) -> String {
      return L.tr("Localizable", "profile.favouriteNFT", p1, fallback: "Plural format key: \"%#@VARIABLE@\"")
    }
    /// Plural format key: "%#@VARIABLE@"
    public static func myNFT(_ p1: Int) -> String {
      return L.tr("Localizable", "profile.myNFT", p1, fallback: "Plural format key: \"%#@VARIABLE@\"")
    }
    /// Имя
    public static let name = L.tr("Localizable", "profile.name", fallback: "Имя")
    /// Профиль
    public static let title = L.tr("Localizable", "profile.title", fallback: "Профиль")
    /// Сайт
    public static let website = L.tr("Localizable", "profile.website", fallback: "Сайт")
    public enum Alert {
      /// Произошла ошибка во время изменения данных профиля
      public static let editError = L.tr("Localizable", "profile.alert.editError", fallback: "Произошла ошибка во время изменения данных профиля")
      /// Произошла ошибка во время загрузки профиля
      public static let fetchError = L.tr("Localizable", "profile.alert.fetchError", fallback: "Произошла ошибка во время загрузки профиля")
      /// Вы хотите сохранить изменения?
      public static let saveChanges = L.tr("Localizable", "profile.alert.saveChanges", fallback: "Вы хотите сохранить изменения?")
      /// Произошла ошибка при парсинге ссылки
      public static let urlError = L.tr("Localizable", "profile.alert.urlError", fallback: "Произошла ошибка при парсинге ссылки")
    }
    public enum Avatar {
      /// Сменить
      /// фото
      public static let change = L.tr("Localizable", "profile.avatar.change", fallback: "Сменить\nфото")
    }
    public enum FavouriteNFT {
      /// У Вас еще нет избранных NFT
      public static let empty = L.tr("Localizable", "profile.favouriteNFT.empty", fallback: "У Вас еще нет избранных NFT")
      /// Избранные NFT
      public static let title = L.tr("Localizable", "profile.favouriteNFT.title", fallback: "Избранные NFT")
    }
    public enum MyNFT {
      /// У Вас еще нет NFT
      public static let empty = L.tr("Localizable", "profile.myNFT.empty", fallback: "У Вас еще нет NFT")
      /// Мои NFT
      public static let title = L.tr("Localizable", "profile.myNFT.title", fallback: "Мои NFT")
      public enum Alert {
        /// Произошла ошибка во время загрузки NFT
        public static let fetchError = L.tr("Localizable", "profile.myNFT.alert.fetchError", fallback: "Произошла ошибка во время загрузки NFT")
      }
      public enum Author {
        /// от
        public static let title = L.tr("Localizable", "profile.myNFT.author.title", fallback: "от")
      }
      public enum Price {
        /// Цена
        public static let title = L.tr("Localizable", "profile.myNFT.price.title", fallback: "Цена")
      }
      public enum Sort {
        /// По названию
        public static let name = L.tr("Localizable", "profile.myNFT.sort.name", fallback: "По названию")
        /// По цене
        public static let price = L.tr("Localizable", "profile.myNFT.sort.price", fallback: "По цене")
        /// По рейтингу
        public static let rating = L.tr("Localizable", "profile.myNFT.sort.rating", fallback: "По рейтингу")
        /// Сортировка
        public static let title = L.tr("Localizable", "profile.myNFT.sort.title", fallback: "Сортировка")
      }
    }
  }
  public enum Statistics {
    /// Статистика
    public static let title = L.tr("Localizable", "statistics.title", fallback: "Статистика")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
