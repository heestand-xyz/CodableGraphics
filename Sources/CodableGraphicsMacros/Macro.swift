//import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

public struct CodableGraphicMacro: MemberAttributeMacro {
    
     public static func expansion<Declaration, MemberDeclaration, Context>(
         of node: SwiftSyntax.AttributeSyntax,
         attachedTo declaration: Declaration,
         providingAttributesFor member: MemberDeclaration,
         in context: Context
     ) throws -> [SwiftSyntax.AttributeSyntax] where Declaration : SwiftSyntax.DeclGroupSyntax, MemberDeclaration : SwiftSyntax.DeclSyntaxProtocol, Context : SwiftSyntaxMacros.MacroExpansionContext {

         if let variable = member.as(VariableDeclSyntax.self)?.bindings.first,
            let typeAnnotation = variable.typeAnnotation,
            let name = variable.pattern.as(IdentifierPatternSyntax.self)?.identifier.text {
             
             let isOptional: Bool = typeAnnotation.type.kind == .optionalType
             
             if name == "type" { return [] }
             if name == "properties" { return [] }
             
             return [SwiftSyntax.AttributeSyntax.init(stringLiteral: "@Graphic\(isOptional ? "Optional" : "Value")Property(key: \"\(name)\", name: String(localized: \"\(name)\"))")]
         }
         return []
    }
}
