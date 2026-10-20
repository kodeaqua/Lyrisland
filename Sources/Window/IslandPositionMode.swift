import Foundation

/// Whether the island is attached to the menu bar or freely draggable.
enum IslandPositionMode: String {
    /// Centered in the menu bar region, like an iPhone Dynamic Island.
    case attached
    /// Freely draggable to any screen position.
    case detached
}

// MARK: - UserDefaults Persistence

extension UserDefaults {
    private enum Keys {
        static let positionMode = "islandPositionMode"
        static let detachedX = "islandDetachedX"
        static let detachedY = "islandDetachedY"
        static let hasDetachedPosition = "islandHasDetachedPosition"
        static let dualLineMode = "dualLineMode"
        static let showArtwork = "showArtwork"

        static func width(for state: IslandState) -> String {
            "islandWidth.\(state)"
        }
    }

    /// The appearance settings the island's size depends on, readable before
    /// `AppState` exists — the panel sizes itself while it is being created.
    var islandUsesDualLineLyrics: Bool {
        bool(forKey: Keys.dualLineMode)
    }

    var islandShowsArtwork: Bool {
        object(forKey: Keys.showArtwork) as? Bool ?? true
    }

    /// The width the user dragged the island to for `state`, if any.
    func islandWidth(for state: IslandState) -> CGFloat? {
        let width = double(forKey: Keys.width(for: state))
        return width > 0 ? CGFloat(width) : nil
    }

    func setIslandWidth(_ width: CGFloat?, for state: IslandState) {
        if let width {
            set(Double(width), forKey: Keys.width(for: state))
        } else {
            removeObject(forKey: Keys.width(for: state))
        }
    }

    var islandPositionMode: IslandPositionMode {
        get {
            guard let raw = string(forKey: Keys.positionMode) else { return .attached }
            return IslandPositionMode(rawValue: raw) ?? .attached
        }
        set { set(newValue.rawValue, forKey: Keys.positionMode) }
    }

    var islandDetachedPosition: NSPoint? {
        get {
            guard bool(forKey: Keys.hasDetachedPosition) else { return nil }
            return NSPoint(
                x: double(forKey: Keys.detachedX),
                y: double(forKey: Keys.detachedY)
            )
        }
        set {
            if let point = newValue {
                set(true, forKey: Keys.hasDetachedPosition)
                set(point.x, forKey: Keys.detachedX)
                set(point.y, forKey: Keys.detachedY)
            } else {
                set(false, forKey: Keys.hasDetachedPosition)
            }
        }
    }
}
