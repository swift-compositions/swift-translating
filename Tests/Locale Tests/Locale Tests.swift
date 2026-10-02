import Testing

@Test func `locale Language Identifiers`() {

    Locales.isoLanguageCodes.forEach { code in
        print(code)
    }

    Locales.availableIdentifiers.forEach { identifier in
        print(identifier)
    }
    print("Locale.availableIdentifiers: ", Locales.availableIdentifiers.count)
}
