import AsyncGraphics
import CoreGraphics
import PixelColor

@CodableGraphicMacro
public class ColorGraphic3D: ShapeGraphic3D {
    
    public var type: CodableGraphic3DType {
        .content(.shape(.color))
    }
    
    public var color: PixelColor = .white
    
    public var properties: [AnyGraphicProperty] {
        [
            _color.erase()
        ]
    }

    public func render(
        at resolution: SIMD3<Int>,
        options: AsyncGraphics.Graphic3D.ContentOptions = []
    ) async throws -> Graphic3D {
        try await .color(
            color,
            resolution: resolution,
            options: options)
    }
}
