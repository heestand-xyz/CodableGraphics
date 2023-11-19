import AsyncGraphics
import CoreGraphics
import PixelColor

public class SphereGraphic3D: ShapeGraphic3D {
    
    public var type: CodableGraphic3DType {
        .content(.shape(.sphere))
    }
    
    @GraphicOptionalProperty(
        key: "radius",
        name: String(localized: "Radius"),
        minimum: 0.0)
    public var radius: Double?
    
    @GraphicOptionalProperty(
        key: "position",
        name: String(localized: "Position"))
    public var position: SIMD3<Double>?
    
    @GraphicValueProperty(
        key: "color",
        name: String(localized: "Color"))
    public var color: PixelColor = .white
    
    @GraphicValueProperty(
        key: "backgroundColor",
        name: String(localized: "Background Color"))
    public var backgroundColor: PixelColor = .clear
    
    @GraphicValueProperty(
        key: "surface",
        name: String(localized: "Surface"))
    public var surface: Bool = false
    
    @GraphicValueProperty(
        key: "surfaceWidth",
        name: String(localized: "Surface Width"),
        minimum: 0.0)
    public var surfaceWidth: CGFloat = 1.0
    
    public var properties: [AnyGraphicProperty] {
        [_radius.erase()]
    }

    public func render(
        at resolution: SIMD3<Int>,
        options: Graphic3D.ContentOptions = []
    ) async throws -> Graphic3D {
        if surface {
            return try await .surfaceSphere(
                radius: radius,
                center: position,
                surfaceWidth: surfaceWidth,
                color: color,
                backgroundColor: backgroundColor,
                resolution: resolution,
                options: options)
        } else {
            return try await .sphere(
                radius: radius,
                center: position,
                color: color,
                backgroundColor: backgroundColor,
                resolution: resolution,
                options: options)
        }
    }
}
