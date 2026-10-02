import Foundation

enum Locales {
    static var isoLanguageCodes: [String] { Locale.isoLanguageCodes.sorted(by: <) }
    static var availableIdentifiers: [String] { Locale.availableIdentifiers.sorted() }
}
