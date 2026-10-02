import Foundation

enum JSON {
    static func encode<Value: Encodable>(_ value: Value, sortedKeys: Bool = false) throws -> [UInt8] {
        let encoder = JSONEncoder()
        encoder.outputFormatting = sortedKeys ? [.sortedKeys] : []
        return Array(try encoder.encode(value))
    }

    static func decode<Value: Decodable>(_ type: Value.Type, from bytes: [UInt8]) throws -> Value {
        try JSONDecoder().decode(type, from: Data(bytes))
    }
}
