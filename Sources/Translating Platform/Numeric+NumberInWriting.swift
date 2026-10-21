import Foundation
public import Language

extension Numeric {
    public func numberInWriting(language: Language) -> String {
        Self.numberInWriting(self, language: language)
    }

    public static func numberInWriting(_ value: Self, language: Language) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .spellOut
        formatter.locale = language.locale
        guard let string = formatter.string(for: value) else {
            fatalError("NumberFormatter produced no spell-out string")
        }
        return string
    }
}
