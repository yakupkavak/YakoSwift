//
//  PrivateFunctions.swift
//  YakoSwift
//
//  Created by Yakup Kavak on 4.05.2026.
//

import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

public struct DebugNodeContextMacro: ExpressionMacro {
    public static func expansion(
        of node: some FreestandingMacroExpansionSyntax,
        in context: some MacroExpansionContext
    ) -> ExprSyntax {
        
        return "\(literal: """
        
        Node: 
        
        \(node.debugDescription)
        
        ***************
        
        Context:
        
        \(context.lexicalContext.isEmpty ? "(No Context Available)" : context.lexicalContext.map(\.debugDescription).joined(separator: "\n-------------\n"))
        
        (Finish)
        
        """)"
    }
}

