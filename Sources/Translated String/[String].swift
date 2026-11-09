import Language

extension [String] {

    public static let alphabet: Self = [
        "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r",
        "s",
        "t", "u", "v", "w", "x", "y", "z",
    ]

    public enum Separator: Sendable {
        case and
        case or
        case andOr
    }
}

extension [String].Separator {
    public static let orSeparator: Self = .or
}

extension TranslatedString {
    public init(_ separator: [String].Separator) {
        switch separator {
        case .and:
            self = [
                .dutch: "en",
                .english: "and",
                .french: "et",
                .german: "und",
                .spanish: "y",
            ]

        case .or:
            self = [
                .dutch: "of",
                .english: "or",
                .french: "ou",
                .german: "oder",
                .spanish: "o",
            ]

        case .andOr:
            self = [
                .dutch: "en/of",
                .english: "and/or",
                .french: "et/ou",
                .german: "und/oder",
                .spanish: "y/o",
            ]
        }
    }
}
