import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

public struct CodableGraphicMacro: MemberAttributeMacro, MemberMacro {
    
    public static func expansion(
        of node: AttributeSyntax,
        providingMembersOf declaration: some DeclGroupSyntax,
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {
        [
            DeclSyntax(stringLiteral: "//// test")
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
             
             if name == "type" { return [] }
             if name == "properties" { return [] }
             
             return [
                AttributeSyntax(stringLiteral: "@Graphic\(isOptional ? "Optional" : "Value")Property(key: \"\(name)\", name: String(localized: \"\(name)\"))")
             ]
         }
         return []
    }
}
