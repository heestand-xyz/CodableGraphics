import AsyncGraphics
import CoreGraphics

public protocol ContentGraphic: CodableGraphic {
    
    func render(at resolution: CGSize, options: Graphic.ContentOptions) async throws -> Graphic
}
