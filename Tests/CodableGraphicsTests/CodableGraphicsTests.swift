import XCTest
@testable import CodableGraphics

final class GraphicsTests: XCTestCase {
    
    let resolution = CGSize(width: 1000, height: 1000)
    
    func testType() async throws {
        
        for type in CodableGraphicType.allCases {
            let instance: CodableGraphic = type.instance()
            XCTAssertEqual(type, instance.type)
        }
    }
    
    func testRender() async throws {
        
        for type in CodableGraphicType.allCases {
            let instance: CodableGraphic = type.instance()
            if let content = instance as? ContentGraphic {
                _ = try await content.render(at: resolution)
            }
        }
    }
}
