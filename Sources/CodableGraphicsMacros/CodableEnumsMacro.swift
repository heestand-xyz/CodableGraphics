import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

public struct CodableEnumsMacro: MemberMacro {
    
    public static func expansion(
        of node: AttributeSyntax,
        providingMembersOf declaration: some DeclGroupSyntax,
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {
        guard let structDecl = declaration.as(StructDeclSyntax.self) else { return [] }
        let block: MemberBlockSyntax  = structDecl.memberBlock
        var enumTypeNames: [String] = []
        for member in block.members {
            if let item = member.as(MemberBlockItemSyntax.self)?.decl,
               let variable = item.as(VariableDeclSyntax.self)?.bindings.first,
               let name = variable.pattern.as(IdentifierPatternSyntax.self)?.identifier.text {
                if name == "enumables" {
                    if let array = variable.initializer?.value.as(ArrayExprSyntax.self) {
                        for element in array.elements {
                            if let arrayElement = element.as(ArrayElementSyntax.self) {
                                if let call = arrayElement.expression.as(FunctionCallExprSyntax.self),
                                   let labeled = call.arguments.as(LabeledExprListSyntax.self),
                                   let access = labeled.first?.expression.as(MemberAccessExprSyntax.self)?.base?.as(MemberAccessExprSyntax.self) {
                                    let name = access.declName.baseName.text
                                    if let preName = access.base?.as(DeclReferenceExprSyntax.self)?.baseName.text {
                                        enumTypeNames.append("\(preName).\(name)")
                                    } else {
                                        enumTypeNames.append(name)
                                    }
                                }
                            }
                        }
                    }
                    break
                }
            }
        }
        return [
            DeclSyntax(stringLiteral: """
            ... //// \(enumTypeNames.map({ "\"\($0)\"" }).joined(separator: ", "))
            """)
        ]
    }
}
