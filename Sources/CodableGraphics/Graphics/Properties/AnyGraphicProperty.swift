import Foundation
import SwiftUI

public class AnyGraphicProperty {
    
    static let nullKey: String = "null"
    
    public let type: GraphicValueType
    
    public let key: String
    public let name: String
    
    private let value: String
    private let defaultValue: String
    private let minimumValue: String
    private let maximumValue: String
    
    private var updateValue: (String) -> ()
    
    init<T: GraphicValue>(type: GraphicValueType,
                     key: String,
                     name: String,
                     value: T?,
                     defaultValue: T?,
                     minimumValue: T?,
                     maximumValue: T?,
                     update: @escaping (T?) -> ()) {
        
        self.type = type
        
        self.key = key
        self.name = name
        
        self.value = Self.encode(value)
        self.defaultValue = Self.encode(defaultValue)
        self.minimumValue = Self.encode(minimumValue)
        self.maximumValue = Self.encode(maximumValue)
        
        updateValue = { string in
            update(Self.decode(string))
        }
    }
}

extension AnyGraphicProperty {
    
    func get<T: GraphicValue>() -> T? {
        Self.decode(value)
    }
    
    func getDefault<T: GraphicValue>() -> T? {
        Self.decode(defaultValue)
    }
    
    func getMinium<T: GraphicValue>() -> T? {
        Self.decode(minimumValue)
    }
    
    func getMaximum<T: GraphicValue>() -> T? {
        Self.decode(maximumValue)
    }
    
    func set<T: GraphicValue>(value: T?) {
        updateValue(Self.encode(value))
    }
}

extension AnyGraphicProperty {
    
    static func encode<T: GraphicValue>(_ value: T?) -> String {
        if let value {
            do {
                let encoder = JSONEncoder()
                let data = try encoder.encode(value)
                return String(data: data, encoding: .utf8)!
            } catch {
                fatalError("CodableGraphics - Encode in Property Failed: \(error.localizedDescription)")
            }
        } else {
            return nullKey
        }
    }
    
    static func decode<T: GraphicValue>(_ string: String) -> T? {
        if string == nullKey {
            return nil
        }
        do {
            let decoder = JSONDecoder()
            let data: Data = string.data(using: .utf8)!
            return try decoder.decode(T.self, from: data)
        } catch {
            fatalError("CodableGraphics - Decode in Property Failed: \(error.localizedDescription)")
        }
    }
}
