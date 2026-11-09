import Testing

@testable import Single_Plural

@Suite
struct `SinglePlural Tests` {

    @Test
    func `Map keeps the preferred form`() {
        let counts = SinglePlural(single: 1, plural: 2, preferred: .plural)

        let mapped = counts.map { "\($0)" }

        #expect(mapped.preferred == .plural)
        #expect(mapped.preferredA == "2")
    }

    @Test
    func `FlatMap keeps the preferred form`() {
        let counts = SinglePlural(single: 1, plural: 2, preferred: .plural)

        let mapped = counts.flatMap { SinglePlural("\($0)") }

        #expect(mapped.preferred == .plural)
        #expect(mapped.single == "1")
        #expect(mapped.plural == "2")
    }
}
