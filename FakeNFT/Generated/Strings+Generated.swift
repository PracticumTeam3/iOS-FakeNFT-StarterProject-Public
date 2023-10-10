// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum L {
  public enum Cart {
    /// Оплатить
    public static let pay = L.tr("Localizable", "cart.pay", fallback: "Оплатить")
    /// Цена
    public static let price = L.tr("Localizable", "cart.price", fallback: "Цена")
    /// Корзина
    public static let title = L.tr("Localizable", "cart.title", fallback: "Корзина")
    /// К оплате
    public static let toBePaid = L.tr("Localizable", "cart.toBePaid", fallback: "К оплате")
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
