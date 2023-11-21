import AsyncGraphics
import CoreGraphics
import PixelColor

@CodableGraphicMacro
public class CircleGraphic: ShapeGraphic {
    
    public var type: CodableGraphicType {
        .content(.shape(.circle))
    }
    
    public var position: CGPoint?

    public var radius: CGFloat? // minimum: 0.0
    
    public var color: PixelColor = .white
    public var backgroundColor: PixelColor = .clear
    
    public var isStroked: Bool = false
    public var lineWidth: CGFloat = 1.0 // minimum: 0.0
    
    public var properties: [AnyGraphicProperty] {
        [
            _radius.erase(),
            _position.erase(),
            _color.erase(),
            _backgroundColor.erase(),
            _isStroked.erase(),
            _lineWidth.erase(),
        ]
    }

    public func render(
        at resolution: CGSize,
        options: Graphic.ContentOptions = []
    ) async throws -> Graphic {
        if isStroked {
            return try await .strokedCircle(
                radius: radius,
                center: position,
                lineWidth: lineWidth,
                color: color,
                backgroundColor: backgroundColor,
                resolution: resolution, 
                options: options)
        } else {
            return try await .circle(
                radius: radius,
                center: position,
                color: color, 
                backgroundColor: backgroundColor,
                resolution: resolution,
                options: options)
        }
    }
}
