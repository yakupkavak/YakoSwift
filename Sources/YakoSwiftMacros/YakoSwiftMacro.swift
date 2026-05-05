import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

/// Implementation of the `stringify` macro, which takes an expression
/// of any type and produces a tuple containing the value of that expression
/// and the source code that produced the value. For example
///
///     #stringify(x + y)
///
///  will expand to
///
///     (x + y, "x + y")

enum YakupMacroError<Model>: CustomStringConvertible, Error {
    case invalidSyntax
    
    var description: String {
        return switch self {
        case .invalidSyntax:
            "Macro can be apply for \(Model.self)"
        }
    }
}

public struct StringifyMacro: ExpressionMacro {
    public static func expansion(
        of node: some FreestandingMacroExpansionSyntax,
        in context: some MacroExpansionContext
    ) -> ExprSyntax {
        guard let argument = node.arguments.first?.expression else {
            fatalError("compiler bug: the macro does not have any arguments")
        }
        return "(\(argument), \(literal: argument.description))"
    }
}

public struct RaichuMacro: ExpressionMacro {
    public static func expansion(
        of node: some FreestandingMacroExpansionSyntax,
        in context: some MacroExpansionContext
    ) throws -> ExprSyntax {
        guard let expression = node.arguments.first?.expression,
              let value = expression.as(IntegerLiteralExprSyntax.self)?.literal.text,
              let count = Int(value) else {
            throw YakupMacroError<Int>.invalidSyntax
        }
        return ExprSyntax(stringLiteral: "\"Raichu loves you \(count) times\"")
    }
}

@main
struct YakoSwiftPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        StringifyMacro.self,
        RaichuMacro.self,
        DebugNodeContextMacro.self,
        ContainerNameMacro.self
    ]
}
