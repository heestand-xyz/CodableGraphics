import AsyncGraphics
import CoreGraphics
import PixelColor

@CodableGraphicMacro
public class ColorGraphic: ShapeGraphic {
    
    public var type: CodableGraphicType {
        .content(.shape(.color))
    }
    
    public var color: PixelColor = .white
    
    public var properties: [AnyGraphicProperty] {
        [
            _color.erase()
        ]
    }

    public func render(
        at resolution: CGSize,
        options: AsyncGraphics.Graphic.ContentOptions = []
    ) async throws -> Graphic {
        try await .color(
            color,
            resolution: resolution,
            options: options)
    }
}
