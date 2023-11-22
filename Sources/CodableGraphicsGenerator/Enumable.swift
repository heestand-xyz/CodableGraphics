
struct Enumable<T: RawRepresentable & CaseIterable> where T.RawValue == String {
    var allCases: [String] {
        T.allCases.map(\.rawValue)
    }
    init(_ type: T.Type) {}
    
    func erase() -> ErasedEnumable {
        ErasedEnumable(allCases: allCases)
    }
}

struct ErasedEnumable {
    
    let allCases: [String]
    
    init(allCases: [String]) {
        self.allCases = allCases
    }
}
