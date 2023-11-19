
public enum ContentGraphicType: Codable, Equatable {
    
    case shape(ShapeGraphicType)
}

extension ContentGraphicType: CaseIterable {
    
    public static var allCases: [ContentGraphicType] {
        ShapeGraphicType.allCases.map { .shape($0) }
    }
}

extension ContentGraphicType {
    
    public func instance() -> ShapeGraphic {
        switch self {
        case .shape(let type):
            type.instance()
        }
    }
}
