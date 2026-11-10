import Language
import Translated
import Translated_String

extension SinglePlural {
    public enum Variant: String, Codable, Hashable, Sendable {

        case single

        case plural
    }
}

extension SinglePlural.Variant {
    /// The same form for a `SinglePlural` of another element type.
    func carried<B>() -> SinglePlural<B>.Variant {
        switch self {
        case .single: .single
        case .plural: .plural
        }
    }
}
