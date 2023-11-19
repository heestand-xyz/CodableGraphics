import Foundation

@propertyWrapper
public class GraphicOptionalProperty<T: Codable>: GraphicProperty {
    
    public var valueType: Codable.Type {
        Swift.type(of: wrappedValue)
    }
    
    public let key: String
    public let name: String
    public var wrappedValue: T?
    
    public init(key: String, name: String) {
        self.key = key
        self.name = name
    }
}

extension GraphicOptionalProperty {

    public func erase() -> AnyGraphicProperty {
        AnyGraphicProperty(type: type, key: key, name: name, value: wrappedValue) { [weak self] value in
            self?.wrappedValue = value
        }
    }
}
