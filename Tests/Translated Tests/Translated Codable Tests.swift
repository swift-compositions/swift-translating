import Testing

@testable import Language
@testable import Translated

@Suite("Translated Codable wire format")
struct Tests {

    private struct Fixture: Codable {
        var `default`: String
        var dictionary: [Language: String]
    }

    private struct LegacyFixture: Codable {
        var `default`: String
        var dictionary: [Language: String]
        var fallbackCache: [Language: String]
    }

    @Test
    func `Encoded payload matches the default-plus-dictionary wire format`() throws {
        let value = Translated<String>(default: "Hello", dictionary: [.dutch: "Hallo"])
        let encoded = try JSON.encode(value, sortedKeys: true)
        let expected = try JSON.encode(Fixture(default: "Hello", dictionary: [.dutch: "Hallo"]), sortedKeys: true)
        #expect(
            String(decoding: encoded, as: UTF8.self) == String(decoding: expected, as: UTF8.self)
        )
    }

    @Test
    func `Decodes a payload containing only default and dictionary`() throws {
        let fixture = try JSON.encode(
            Fixture(default: "Hello", dictionary: [.dutch: "Hallo"])
        )
        let value = try JSON.decode(Translated<String>.self, from: fixture)
        #expect(value.default == "Hello")
        #expect(value[.dutch] == "Hallo")
    }

    @Test
    func `Tolerates a legacy payload carrying the fallbackCache key`() throws {
        let fixture = try JSON.encode(
            LegacyFixture(default: "Hello", dictionary: [.dutch: "Hallo"], fallbackCache: [:])
        )
        let value = try JSON.decode(Translated<String>.self, from: fixture)
        #expect(value.default == "Hello")
        #expect(value[.dutch] == "Hallo")
    }

    @Test
    func `Round trip preserves default and dictionary`() throws {
        let value = Translated<String>(
            default: "Hello",
            dictionary: [.dutch: "Hallo", .french: "Bonjour"]
        )
        let decoded = try JSON.decode(
            Translated<String>.self,
            from: JSON.encode(value)
        )
        #expect(decoded.default == value.default)
        #expect(decoded.dictionary == value.dictionary)
    }
}
