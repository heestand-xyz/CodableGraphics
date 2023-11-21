import AsyncGraphics
import CoreGraphics
import PixelColor
import SwiftUI

@CodableGraphicMacro
public class ArcGraphic: ShapeGraphic {
    
    public var type: CodableGraphicType {
        .content(.shape(.arc))
    }
    
    public var position: CGPoint?

    public var radius: CGFloat? // minimum: 0.0

    public var angle: Angle = .zero
    public var length: Angle = .degrees(90) // minimum: .zero. maximum: .degrees(360)    
    
    public var color: PixelColor = .white
    public var backgroundColor: PixelColor = .clear
    
    public var isStroked: Bool = false
    public var lineWidth: CGFloat = 1.0 // minimum: 0.0
    
    public var properties: [AnyGraphicProperty] {
        [
            _angle.erase(),
            _length.erase(),
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
            return try await .strokedArc(
                angle: angle,
                length: length,
                radius: radius,
                center: position,
                lineWidth: lineWidth,
                color: color,
                backgroundColor: backgroundColor,
                resolution: resolution,
                options: options)
        } else {
            return try await .arc(
                angle: angle,
                length: length,
                radius: radius,
                center: position,
                color: color,
                backgroundColor: backgroundColor,
                resolution: resolution,
                options: options)
        }
    }
}
