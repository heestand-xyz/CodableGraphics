import AsyncGraphics
import CoreGraphics
import PixelColor
import SwiftUI

public class ArcGraphic: ShapeGraphic {
    
    public var type: CodableGraphicType {
        .content(.shape(.arc))
    }
    
    @GraphicValueProperty(
        key: "angle",
        name: String(localized: "Angle"))
    public var angle: Angle = .zero
    
    @GraphicValueProperty(
        key: "length",
        name: String(localized: "Length"))
    public var length: Angle = .degrees(90)
    
    @GraphicOptionalProperty(
        key: "radius",
        name: String(localized: "Radius"),
        minimum: 0.0)
    public var radius: CGFloat?
    
    @GraphicOptionalProperty(
        key: "position",
        name: String(localized: "Position"))
    public var position: CGPoint?
    
    @GraphicValueProperty(
        key: "color",
        name: String(localized: "Color"))
    public var color: PixelColor = .white
    
    @GraphicValueProperty(
        key: "backgroundColor",
        name: String(localized: "Background Color"))
    public var backgroundColor: PixelColor = .clear
    
    @GraphicValueProperty(
        key: "isStroked",
        name: String(localized: "Stroked"))
    public var isStroked: Bool = false
    
    @GraphicValueProperty(
        key: "lineWidth",
        name: String(localized: "Line Width"),
        minimum: 0.0)
    public var lineWidth: CGFloat = 1.0
    
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
