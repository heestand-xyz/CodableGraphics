import AsyncGraphics
import CoreGraphics
import PixelColor

public class CircleGraphic: ShapeGraphic {
    
    public var type: CodableGraphicType {
        .content(.shape(.circle))
    }
    
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
        [_radius.erase()]
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
