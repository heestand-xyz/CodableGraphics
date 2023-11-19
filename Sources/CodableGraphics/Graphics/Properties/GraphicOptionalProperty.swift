import Foundation

@propertyWrapper
public class GraphicOptionalProperty<T: Codable>: GraphicProperty {
    
    public var valueType: Codable.Type {
        Swift.type(of: wrappedValue)
    }
    
    public let key: String
    public let name: String
    
    public var wrappedValue: T?
    public var minimumValue: T?
    public var maximumValue: T?
    
    public init(
        key: String,
        name: String,
        minimum: T? = nil,
        maximum: T? = nil
    ) {
        self.key = key
        self.name = name
        minimumValue = minimum
        maximumValue = maximum
    }
}

extension GraphicOptionalProperty {

    public func erase() -> AnyGraphicProperty {
        AnyGraphicProperty(
            type: type,
            key: key,
            name: name,
            value: wrappedValue,
            defaultValue: nil,
            minimumValue: minimumValue,
            maximumValue: maximumValue
        ) { [weak self] value in
            self?.wrappedValue = value
        }
    }
}
