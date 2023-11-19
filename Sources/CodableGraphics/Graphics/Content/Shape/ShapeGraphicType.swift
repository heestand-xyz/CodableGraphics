import SwiftUI
import AsyncGraphics

public enum ShapeGraphicType: String, Codable, Equatable, CaseIterable {
    
    case color
    case circle
    case arc
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
        case .arc:
            ArcGraphic()
        }
    }
}
