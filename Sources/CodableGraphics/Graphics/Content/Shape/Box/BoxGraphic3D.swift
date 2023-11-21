import AsyncGraphics
import CoreGraphics
import PixelColor

@CodableGraphicMacro
public class BoxGraphic3D: ShapeGraphic3D {
    
    public var type: CodableGraphic3DType {
        .content(.shape(.box))
    }
    
    public var size: SIMD3<Double>?
    public var position: SIMD3<Double>?
    
    public var cornerRadius: Double = 0.0 // minimum: 0.0
    
    public var color: PixelColor = .white
    public var backgroundColor: PixelColor = .clear
    
    public var surface: Bool = false
    public var surfaceWidth: CGFloat = 1.0 // minimum: 0.0
    
    public var properties: [AnyGraphicProperty] {
        [
            _size.erase(),
            _position.erase(),
            _color.erase(),
            _backgroundColor.erase(),
            _surface.erase(),
            _surfaceWidth.erase(),
        ]
    }

    public func render(
        at resolution: SIMD3<Int>,
        options: Graphic3D.ContentOptions = []
    ) async throws -> Graphic3D {
        if surface {
            return try await .surfaceBox(
                size: size,
                center: position,
                cornerRadius: cornerRadius,
                surfaceWidth: surfaceWidth,
                color: color,
                backgroundColor: backgroundColor,
                resolution: resolution,
                options: options)
        } else {
            return try await .box(
                size: size,
                center: position,
                cornerRadius: cornerRadius,
                color: color,
                backgroundColor: backgroundColor,
                resolution: resolution,
                options: options)
        }
    }
}
