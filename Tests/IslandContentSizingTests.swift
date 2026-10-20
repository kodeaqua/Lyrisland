import AppKit
@testable import Lyrisland
import Testing

struct IslandContentSizingTests {
    @Test("Compact island uses Dynamic Island-sized width")
    func compactWidth() {
        #expect(IslandContentView.size(for: .compact).width == 320)
        #expect(IslandContentView.size(for: .compact, attached: true).width == 320)
    }

    @Test("Compact single-line height is not inflated by artwork")
    func compactHeight() {
        #expect(IslandContentView.size(for: .compact, dualLine: false, artwork: true).height == 58)
        #expect(IslandContentView.size(for: .compact, dualLine: false, artwork: false).height == 58)
    }

    @Test("Expanded and full island widths stay unchanged")
    func expandedAndFullWidths() {
        #expect(IslandContentView.size(for: .expanded, artwork: true).width == 450)
        #expect(IslandContentView.size(for: .expanded, artwork: false).width == 380)
        #expect(IslandContentView.size(for: .full, artwork: true).width == 540)
        #expect(IslandContentView.size(for: .full, artwork: false).width == 400)
    }
}

struct IslandCustomWidthTests {
    @Test("A custom width replaces the default and is clamped")
    func customWidth() {
        #expect(IslandContentView.size(for: .compact, customWidth: 400).width == 400)
        #expect(IslandContentView.size(for: .compact, customWidth: 10).width == 224)
        #expect(IslandContentView.size(for: .compact, customWidth: 5000).width == IslandContentView.maximumWidth)
    }

    @Test("No custom width keeps the default")
    func noCustomWidth() {
        #expect(IslandContentView.resolvedWidth(nil, base: 320, minimum: 224) == 320)
    }
}
