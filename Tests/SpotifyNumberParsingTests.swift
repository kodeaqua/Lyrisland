@testable import Lyrisland
import Testing

@Suite("SpotifyAppleScriptService.parseNumber")
struct SpotifyNumberParsingTests {
    @Test("Parses a dot decimal")
    func dotDecimal() {
        #expect(SpotifyAppleScriptService.parseNumber("12.5") == 12.5)
    }

    @Test("Parses a comma decimal from a locale such as Indonesian")
    func commaDecimal() {
        #expect(SpotifyAppleScriptService.parseNumber("12,5") == 12.5)
    }

    @Test("Parses scientific notation with a comma")
    func scientific() {
        #expect(SpotifyAppleScriptService.parseNumber("2,15E+5") == 215_000)
    }

    @Test("Parses integers and rejects garbage")
    func integersAndGarbage() {
        #expect(SpotifyAppleScriptService.parseNumber("215000") == 215_000)
        #expect(SpotifyAppleScriptService.parseNumber("abc") == nil)
    }
}
