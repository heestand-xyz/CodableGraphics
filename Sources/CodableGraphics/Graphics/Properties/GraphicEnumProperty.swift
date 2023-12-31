import Foundation
import simd
import AsyncGraphics
import PixelColor

@propertyWrapper
public class GraphicEnumProperty<T: GraphicEnum> where T.RawValue == String {
    
    public let key: String
    public let name: String
    
    public var wrappedValue: GraphicEnumMetadata<T>
    
    public let allCases: [GraphicEnumCase]
    
    public init(
        wrappedValue: GraphicEnumMetadata<T>,
        key: String,
        name: String,
        allCases: [GraphicEnumCase]
    ) {
        self.key = key
        self.name = name
        self.wrappedValue = wrappedValue
        self.allCases = allCases
    }
}

extension GraphicEnumProperty {

    public func erase() -> AnyGraphicEnumProperty {
        AnyGraphicEnumProperty(
            key: key,
            name: name,
            value: wrappedValue.value,
            defaultValue: wrappedValue.defaultValue,
            allCases: allCases
        ) { [weak self] value in
            self?.wrappedValue.value = value
        }
    }
}
