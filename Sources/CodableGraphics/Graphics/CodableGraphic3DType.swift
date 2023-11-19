import AsyncGraphics

public enum CodableGraphic3DType: Codable, Equatable {
    
    case content(ContentGraphic3DType)
    
}

extension CodableGraphic3DType: CaseIterable {
    
    public static var allCases: [CodableGraphic3DType] {
        ContentGraphic3DType.allCases.map { .content($0) }
    }
}

extension CodableGraphic3DType {
    
    public func instance() -> CodableGraphic3D {
        switch self {
        case .content(let type):
            type.instance()
        }
    }
}
