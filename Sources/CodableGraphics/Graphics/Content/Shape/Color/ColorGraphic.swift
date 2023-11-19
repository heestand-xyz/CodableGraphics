import AsyncGraphics
import CoreGraphics
import PixelColor

public struct ColorGraphic: ShapeGraphic {
    
    public var type: CodableGraphicType {
        .content(.shape(.color))
    }
    
    @GraphicValueProperty(
        key: "color",
        name: String(localized: "Color"))
    public var color: PixelColor = .white
    
    public var properties: [AnyGraphicProperty] {
        [_color.erase()]
    }

    public func render(at resolution: CGSize) async throws -> Graphic {
        try await .color(color, resolution: resolution)
    }
}
