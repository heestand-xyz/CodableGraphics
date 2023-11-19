import AsyncGraphics
import simd

public protocol ContentGraphic3D: CodableGraphic3D {
    
    func render(at resolution: SIMD3<Int>, options: Graphic3D.ContentOptions) async throws -> Graphic3D
}
