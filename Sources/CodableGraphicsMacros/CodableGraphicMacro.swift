import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

public struct CodableGraphicMacro: MemberMacro, MemberAttributeMacro {
    
    static let blackList: [String] = [
        "type",
        "properties"
    ]
    
    public static func expansion(
        of node: AttributeSyntax,
        providingMembersOf declaration: some DeclGroupSyntax,
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {
        guard let classDecl = declaration.as(ClassDeclSyntax.self) else { return [] }
        let block: MemberBlockSyntax  = classDecl.memberBlock
        let className: String = classDecl.name.text
        var variables: [String] = []
        for member in block.members {
            if let item = member.as(MemberBlockItemSyntax.self)?.decl,
               let variable = item.as(VariableDeclSyntax.self)?.bindings.first,
               let typeAnnotation = variable.typeAnnotation,
               let name = variable.pattern.as(IdentifierPatternSyntax.self)?.identifier.text {
                if blackList.contains(name) {
                    continue
                }
                variables.append(name)
            }
        }
        let erasedVariables: [String] = variables.map { variable in
            "_\(variable).erase()"
        }
        return [
            DeclSyntax(stringLiteral: """
            public var properties: [any AnyGraphicProperty] {
                [
                    \(erasedVariables.joined(separator: ",\n"))
                ]
            }
            """)
        ]
    }
    
    public static func expansion<Declaration, MemberDeclaration, Context>(
        of node: AttributeSyntax,
        attachedTo declaration: Declaration,
        providingAttributesFor member: MemberDeclaration,
        in context: Context
    ) throws -> [AttributeSyntax] where Declaration : DeclGroupSyntax, MemberDeclaration : DeclSyntaxProtocol, Context : MacroExpansionContext {
        
        if let variable = member.as(VariableDeclSyntax.self)?.bindings.first,
           let typeAnnotation = variable.typeAnnotation,
           let name = variable.pattern.as(IdentifierPatternSyntax.self)?.identifier.text,
           let identifier = typeAnnotation.type.as(IdentifierTypeSyntax.self) {
            
            let typeName: String = identifier.name.text
            let isMetadata: Bool = typeName == "GraphicMetadata"
            let isEnumMetadata: Bool = typeName == "GraphicEnumMetadata"
            
            var genericTypeName: String?
            if let genericIdentifier =  identifier.genericArgumentClause?.arguments.first?.argument.as(MemberTypeSyntax.self) {
                if let genericBaseIdentifier = genericIdentifier.baseType.as(IdentifierTypeSyntax.self) {
                    genericTypeName = "\(genericBaseIdentifier.name.text).\(genericIdentifier.name.text)"
                } else {
                    genericTypeName = genericIdentifier.name.text
                }
            }
            
            if blackList.contains(name) {
                return []
            }
            
            
            if isMetadata {
                return [
                    AttributeSyntax(stringLiteral: "@GraphicValueProperty(key: \"\(name)\", name: String(localized: \"graphic.property.\(name)\"))")
                ]
            } else if isEnumMetadata, let genericTypeName {
                return [
                    AttributeSyntax(stringLiteral: "@GraphicEnumProperty(key: \"\(name)\", name: String(localized: \"graphic.property.\(name)\"), allCases: \(genericTypeName).allCases.map({ GraphicEnumCase(rawValue: $0.rawValue, name: \"Enum Case Placeholder\") }))")
                ]
            }
        }
        return []
    }
}
