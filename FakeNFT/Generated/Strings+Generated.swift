// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum L {
  public enum Cart {
    /// Вернуться в каталог
    public static let backCataloge = L.tr("Localizable", "cart.backCataloge", fallback: "Вернуться в каталог")
    /// Отмена
    public static let cansel = L.tr("Localizable", "cart.cansel", fallback: "Отмена")
    /// Корзина пуста
    public static let cartEmpty = L.tr("Localizable", "cart.cartEmpty", fallback: "Корзина пуста")
    /// Выберите способ оплаты
    public static let choosePay = L.tr("Localizable", "cart.choosePay", fallback: "Выберите способ оплаты")
    /// Удалить
    public static let delete = L.tr("Localizable", "cart.delete", fallback: "Удалить")
    /// Вы уверены, что хотите
    /// удалить объект из корзины?
    public static let deleteQuestion = L.tr("Localizable", "cart.deleteQuestion", fallback: "Вы уверены, что хотите\nудалить объект из корзины?")
    /// Не удалось произвести
    /// оплату
    public static let failurePay = L.tr("Localizable", "cart.failurePay", fallback: "Не удалось произвести\nоплату")
    /// Оплатить
    public static let pay = L.tr("Localizable", "cart.pay", fallback: "Оплатить")
    /// Цена
    public static let price = L.tr("Localizable", "cart.price", fallback: "Цена")
    /// Повторить
    public static let `repeat` = L.tr("Localizable", "cart.repeat", fallback: "Повторить")
    /// Вернуться
    public static let `return` = L.tr("Localizable", "cart.return", fallback: "Вернуться")
    /// Сортировка
    public static let sorted = L.tr("Localizable", "cart.sorted", fallback: "Сортировка")
    /// По названию
    public static let sortedByName = L.tr("Localizable", "cart.sortedByName", fallback: "По названию")
    /// По цене
    public static let sortedByPrice = L.tr("Localizable", "cart.sortedByPrice", fallback: "По цене")
    /// По рейтингу
    public static let sortedByRating = L.tr("Localizable", "cart.sortedByRating", fallback: "По рейтингу")
    /// Закрыть
    public static let sortedClose = L.tr("Localizable", "cart.sortedClose", fallback: "Закрыть")
    /// Успех! Оплата прошла,
    /// поздравляем с покупкой!
    public static let successPay = L.tr("Localizable", "cart.successPay", fallback: "Успех! Оплата прошла,\nпоздравляем с покупкой!")
    /// Корзина
    public static let title = L.tr("Localizable", "cart.title", fallback: "Корзина")
    /// К оплате
    public static let toBePaid = L.tr("Localizable", "cart.toBePaid", fallback: "К оплате")
    /// Пользовательского соглашения
    public static let userAgreementEnd = L.tr("Localizable", "cart.userAgreementEnd", fallback: "Пользовательского соглашения")
    /// Совершая покупку, вы соглашаетесь с условиями
    public static let userAgreementStart = L.tr("Localizable", "cart.userAgreementStart", fallback: "Совершая покупку, вы соглашаетесь с условиями")
  }
  public enum Catalog {
    /// Каталог
    public static let title = L.tr("Localizable", "catalog.title", fallback: "Каталог")
  }
  public enum Profile {
    /// Описание
    public static let description = L.tr("Localizable", "profile.description", fallback: "Описание")
    /// Plural format key: "%#@VARIABLE@"
    public static func mynft(_ p1: Int) -> String {
      return L.tr("Localizable", "profile.mynft", p1, fallback: "Plural format key: \"%#@VARIABLE@\"")
    }
    /// Имя
    public static let name = L.tr("Localizable", "profile.name", fallback: "Имя")
    /// Localizable.strings
    ///   FakeNFT
    public static let title = L.tr("Localizable", "profile.title", fallback: "Профиль")
    /// Сайт
    public static let website = L.tr("Localizable", "profile.website", fallback: "Сайт")
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
