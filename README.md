# swift-translating

Use this package when you show text, or any other value, in the user's language and want to keep every translation of it in one value. Start from `Translated<A>`, or `TranslatedString` for text, and read it with a `Language`. For words with a singular and a plural form, use `SinglePlural<A>`. Import Translating Dependencies when the current language should come from the `language` dependency, as it does for `description`, comparison and date formatting. Translations holds ready-made phrases such as language names.

## Laws

- Reading a language returns its own entry if there is one. Otherwise it tries that language's fallback list, such as Afrikaans to Dutch to English, or Basque to Spanish to French to English, and then the default. A language with no list falls back to English and then the default.
- A dictionary literal makes the English entry the default, or the first entry if there is no English. Repeating a language traps. An empty literal traps for `Translated<A>` and gives the empty string for `TranslatedString`.
- A string literal or `Translated.init(_:)` stores only the default, so every language reads that value.
- Two values are equal when their defaults and stored entries are equal. Values that read the same in every language but are stored differently are not equal.
- `Translated` encodes as an object with a `default` and a `dictionary` key. Decoding ignores any other key.
- Adding two `TranslatedString` values joins them per language, using each side's own entry or else its default. Fallback lists are not used. Adding a plain string adds it to the default and every entry.
- `Translated.map(_:)` transforms the default and every stored entry. `SinglePlural.map(_:)` and `SinglePlural.flatMap(_:)` reset the preferred form to singular.
- `TranslatedString.isEmpty` checks only the English and Dutch readings.
- With Translating Dependencies, `description` and `<` read the current `language`, which is English unless overridden. Initializers and formatters that build every language at once use the `languages` set at creation time, which holds every supported language unless overridden. Changing either later doesn't change values already made.
- The named initializer that takes `english` keeps only the languages in `languages` and makes English the default.
- An `Int` count such as `Int.years` is singular only for 1, so 0 is plural. Its words exist in Dutch, English, French, German and Spanish, and other languages fall back.
- The `and`, `or` and `and/or` separators exist only in English, so a list joined with them uses the English word in every language. Three or more items are joined with commas and a comma before the last separator.
- `TranslatedString.init(_:)` from date components lists the nonzero units in English and Dutch only, and gives zero seconds when all are zero.
- `Language.locale` uses the tag itself as the locale identifier. `Language.preferred` takes only the system language code and falls back to English.
