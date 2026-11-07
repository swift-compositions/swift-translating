import Language
import Translated
import Translated_String


extension SinglePlural {
    public enum Variant: String, Codable, Hashable, Sendable {

        case single

        case plural
    }
}
