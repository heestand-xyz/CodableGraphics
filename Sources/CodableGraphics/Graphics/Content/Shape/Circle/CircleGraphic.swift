import AsyncGraphics
import CoreGraphics
import PixelColor

public struct CircleGraphic: ShapeGraphic {
    
    public var type: CodableGraphicType {
        .content(.shape(.circle))
    }
    
    @GraphicOptionalProperty(
        key: "radius",
        name: String(localized: "Radius"),
        minimum: 0.0)
    public var radius: CGFloat?
    
    public var properties: [AnyGraphicProperty] {
        [_radius.erase()]
    }

    public func render(at resolution: CGSize) async throws -> Graphic {
        try await .circle(radius: radius, resolution: resolution)
    }
}
