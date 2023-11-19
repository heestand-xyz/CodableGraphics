import AsyncGraphics
import CoreGraphics

public protocol ContentGraphic: CodableGraphic {
    
    func render(at resolution: CGSize) async throws -> Graphic
}
