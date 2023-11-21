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
        var erasedVariables: [String] = variables.map { variable in
            "_\(variable).erase()"
        }
        return [
            DeclSyntax(stringLiteral: """
            public var properties: [AnyGraphicProperty] {
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
            let name = variable.pattern.as(IdentifierPatternSyntax.self)?.identifier.text {
             
             let isOptional: Bool = typeAnnotation.type.kind == .optionalType
             
             if blackList.contains(name) {
                 return []
             }
             
             return [
                AttributeSyntax(stringLiteral: "@GraphicProperty(key: \"\(name)\", name: String(localized: \"graphic.property.\(name)\"))")
             ]
         }
         return []
    }
}
