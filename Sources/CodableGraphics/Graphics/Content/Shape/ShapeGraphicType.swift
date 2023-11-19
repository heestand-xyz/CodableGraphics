import SwiftUI
import AsyncGraphics

public enum ShapeGraphicType: String, Codable, Equatable, CaseIterable {
    
    case color
    case circle
}

extension ShapeGraphicType: Identifiable {
    
    public var id: String {
        rawValue
    }
}

extension ShapeGraphicType {
    
    public func instance() -> ShapeGraphic {
        switch self {
        case .color:
            ColorGraphic()
        case .circle:
            CircleGraphic()
        }
    }
}
