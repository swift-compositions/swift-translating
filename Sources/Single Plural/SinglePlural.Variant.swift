import Language
public import Translated
public import Translated_String


extension SinglePlural {
    public enum Variant: String, Codable, Hashable, Sendable {

        case single

        case plural
    }
}
