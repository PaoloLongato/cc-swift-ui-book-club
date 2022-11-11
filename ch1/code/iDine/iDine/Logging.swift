//
//  Logging.swift
//  iDine
//
//  Created by Paolo Longato on 11/11/2022.
//

import SwiftUI

extension View {
    
    /// Use this to print out the type returned by a view builder or modifier
    /// Using this you can determine that the view tree in SwiftUI is constant.  All possible states of the UI are a tree branch, known at compile time.
    /// Attacching this to the "body" of a view, you can inspect when body is called.
    /// Working assumption 0: body is called when the view identifier changes.
    func debugPrint(_ title: String? = nil) -> some View {
        let mirror = Mirror(reflecting: self)
        let title = title.flatMap { "[\($0)] " } ?? ""
        print(title + mirror.description)
        
        return self
    }
    
    /// Use this to print introspect the type returned by a view builder or modifier
    /// By using this on simple SwiftUI views, I could determine that SwiftUI views do not have an identifier
    /// Working assumption 1.  Identifiers (set by View.id()) are stored somewhere else in the "engine"
    /// Working assumption 2.  Identifiers trigger a view update (body is called)
    /// Working assumption 3.  init() of views are called all the time and probably used, together with other state sorages, to the termine the ID of a view
    func debugPrintChildren(_ title: String? = nil) -> some View {
        let mirror = Mirror(reflecting: self)
        let title = title.flatMap { "[\($0)] " } ?? ""
        let childrenDescription = mirror.children.map {
            [$0.label?.description, "\($0.value)"].compactMap({ $0 }).joined(separator: " = ")
        }.joined(separator: "; ")
        print(title + childrenDescription)
        
        return self
    }
}
