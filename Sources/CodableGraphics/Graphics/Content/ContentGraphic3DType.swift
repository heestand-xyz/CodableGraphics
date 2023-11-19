
public enum ContentGraphic3DType: Codable, Equatable {
    
    case shape(ShapeGraphic3DType)
}

extension ContentGraphic3DType: CaseIterable {
    
    public static var allCases: [ContentGraphic3DType] {
        ShapeGraphic3DType.allCases.map { .shape($0) }
    }
}

extension ContentGraphic3DType {
    
    public func instance() -> ShapeGraphic3D {
        switch self {
        case .shape(let type):
            type.instance()
        }
    }
}
