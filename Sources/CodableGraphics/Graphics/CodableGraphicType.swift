import AsyncGraphics

public enum CodableGraphicType: Codable, Equatable {
    
    case content(ContentGraphicType)
    
}

extension CodableGraphicType: CaseIterable {
    
    public static var allCases: [CodableGraphicType] {
        ContentGraphicType.allCases.map { .content($0) }
    }
}

extension CodableGraphicType {
    
    public func instance() -> CodableGraphic {
        switch self {
        case .content(let type):
            type.instance()
        }
    }
}
