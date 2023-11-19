import Foundation
import SwiftUI

public class AnyGraphicProperty {
    
    static let nullKey: String = "null"
    
    let type: GraphicPropertyType
    
    let key: String
    let name: String
    
    let value: String
    
    private var updateValue: (String) -> ()
    
    init<T: Codable>(type: GraphicPropertyType,
                     key: String,
                     name: String,
                     value: T?,
                     update: @escaping (T?) -> ()) {
        self.type = type
        self.key = key
        self.name = name
        if let value = value {
            do {
                let encoder = JSONEncoder()
                let data = try encoder.encode(value)
                self.value = String(data: data, encoding: .utf8)!
            } catch {
                fatalError("CodableGraphics - Encode of Property \"\(key)\"  Failed: \(error.localizedDescription)")
            }
        } else {
            self.value = Self.nullKey
        }
        updateValue = { string in
            if string == Self.nullKey {
                update(nil)
            } else {
                let decoder = JSONDecoder()
                let data: Data = string.data(using: .utf8)!
                do {
                    let value: T = try decoder.decode(T.self, from: data)
                    update(value)
                } catch {
                    fatalError("CodableGraphics - Decode of Property \"\(key)\"  Failed: \(error.localizedDescription)")
                }
            }
        }
    }
}

extension AnyGraphicProperty {
    
    func update<T: Codable>(value: T?) {
        guard T.self == type.rawType.self else {
            fatalError("Type Missmatch (\(T.self) != \(type.rawType.self))")
        }
        if value == nil {
            updateValue(Self.nullKey)
        } else {
            do {
                let encoder = JSONEncoder()
                let data = try encoder.encode(value)
                let string = String(data: data, encoding: .utf8)!
                updateValue(string)
            } catch {
                fatalError("CodableGraphics - Encode of Property \"\(key)\"  Failed: \(error.localizedDescription)")
            }
        }
    }
}
