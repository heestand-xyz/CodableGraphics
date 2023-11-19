import SwiftUI
import AsyncGraphics

public enum ShapeGraphic3DType: String, Codable, Equatable, CaseIterable {
    
    case color
    case sphere
}

extension ShapeGraphic3DType: Identifiable {
    
    public var id: String {
        rawValue
    }
}

extension ShapeGraphic3DType {
    
    public func instance() -> ShapeGraphic3D {
        switch self {
        case .color:
            ColorGraphic3D()
        case .sphere:
            SphereGraphic3D()
        }
    }
}
