//
//  Functions.swift
//  YakoSwift
//
//  Created by Yakup Kavak on 4.05.2026.
//

import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros


public struct ContainerNameMacro: ExpressionMacro {
    public static func expansion(
        of node: some FreestandingMacroExpansionSyntax,
        in context: some MacroExpansionContext)
       throws -> ExprSyntax {
           let lexialContext = context.lexicalContext
           if lexialContext.isEmpty {
               fatalError("ClassName macro cannot be used at file scope.")
           }
           var functionName: String?
           for context in lexialContext {
               let name = getName(syntax: context)
               if let name {
                   functionName = name
                   break
               }
           }
           
           guard let functionName else {
               fatalError("ClassName macro cannot be used at file scope.")
           }
           
           return "\(literal: functionName)"
    }
}

private func getName(syntax: Syntax) -> String? {
    switch syntax.kind {
        case .classDecl:
            let synt = Syntax(syntax).as(ClassDeclSyntax.self)
            return synt?.name.text
        case .protocolDecl:
            let synt = Syntax(syntax).as(ProtocolDeclSyntax.self)
            return synt?.name.text
        default:
            return nil
    }
}
