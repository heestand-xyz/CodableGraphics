import AsyncGraphics
import CoreGraphics
import PixelColor

@CodableGraphicMacro
public class SphereGraphic3D: ShapeGraphic3D {
    
    public var type: CodableGraphic3DType {
        .content(.shape(.sphere))
    }
    
    public var position: GraphicMetadata<SIMD3<Double>> = .init()
    
    public var radius: GraphicMetadata<CGFloat> = .init(value: .resolutionMinimum(fraction: 0.5),
                                                        maximum: .resolutionMaximum(fraction: 0.5))

    public var foregroundColor: GraphicMetadata<PixelColor> = .init(value: .fixed(.white))
    public var backgroundColor: GraphicMetadata<PixelColor> = .init(value: .fixed(.clear))
    
    public var surface: GraphicMetadata<Bool> = .init(value: .fixed(false))
    public var surfaceWidth: GraphicMetadata<CGFloat> = .init(value: .fixed(1.0),
                                                              maximum: .fixed(10.0))
    
    public var properties: [AnyGraphicProperty] {
        [
            _radius.erase(),
            _position.erase(),
            _foregroundColor.erase(),
            _backgroundColor.erase(),
            _surface.erase(),
            _surfaceWidth.erase(),
        ]
    }

    public func render(
        at resolution: SIMD3<Int>,
        options: Graphic3D.ContentOptions = []
    ) async throws -> Graphic3D {
        if surface.value.at(resolution: resolution) {
            return try await .surfaceSphere(
                radius: radius.value.at(resolution: resolution),
                center: position.value.at(resolution: resolution),
                surfaceWidth: surfaceWidth.value.at(resolution: resolution),
                color: foregroundColor.value.at(resolution: resolution),
                backgroundColor: backgroundColor.value.at(resolution: resolution),
                resolution: resolution,
                options: options)
        } else {
            return try await .sphere(
                radius: radius.value.at(resolution: resolution),
                center: position.value.at(resolution: resolution),
                color: foregroundColor.value.at(resolution: resolution),
                backgroundColor: backgroundColor.value.at(resolution: resolution),
                resolution: resolution,
                options: options)
        }
    }
}
