//
//  MarkUp.swift
//
//
//  Created by 日向 強 on 2020/12/15.
//

import Foundation

/// Content that can be included in the element.
public protocol Content {
    /// Get marked up text.
    /// - Returns: marked up text.
    func toString() -> String
}

extension String: Content {
    public func toString() -> String {
        self
    }
}

/// Element that support attributes added by dynamic callable
@dynamicCallable
public struct Element: Content {
    internal init(tagName: String? = nil, addEndTag: Bool = true, elements: [Content] = [], attributes: KeyValuePairs<String, String?>? = nil, instead: String = "") {
        self.tagName = tagName
        self.addEndTag = addEndTag
        self.elements = elements
        self.attributes = attributes
        self.instead = instead
    }
    
    private let tagName: String?
    private let addEndTag: Bool
    private let elements: [Content]
    private let attributes: KeyValuePairs<String, String?>?
    private let instead: String
    
    public func toString() -> String {
        let attributesString = attributes?.reduce("", { (result, arg1) -> String in
            let (key, value) = arg1
            if let value = value {
                return result + " \(key)=\"\(value)\""
            } else {
                return result + " \(key)"
            }
        }) ?? ""
        let content = elements.map { $0.toString() }.joined(separator: "")
        if let tagName = tagName {
            var drawString: String = ""
            drawString += "<\(tagName)\(attributesString)\(instead)>\(content)"
            if addEndTag {
                drawString += "</\(tagName)>"
            }
            return drawString
        } else {
            return content
        }
    }
    
    /// Add children content
    /// - Parameter content: children content
    /// - Returns: Result that added content
    public func children( @MarkUpBuilderBuilder content: () -> Content) -> Element {
        Element(tagName: tagName, addEndTag: addEndTag, elements: [content()], attributes: attributes, instead: instead)
    }
    
    public func dynamicallyCall(withKeywordArguments pairs: KeyValuePairs<String, String?>) -> Element {
        Element(tagName: tagName, addEndTag: addEndTag, elements: elements, attributes: pairs, instead: instead)
    }
    
    /// Remove end tag
    /// - Parameter instead: Put a string in front of '>'
    /// - Returns: Result that removed end tag
    public func doNotSpecifyEndTag(instead: String = "") -> Element {
        Element(tagName: tagName, addEndTag: false, elements: elements, attributes: attributes, instead: instead)
    }
}

/// Mark up that support dynamic member.
@dynamicMemberLookup
public struct MarkUp {
    public init() {}
    
    public subscript(dynamicMember member: String) -> Element {
        Element(tagName: member)
    }
}


@resultBuilder
public struct MarkUpBuilderBuilder {
    public static func buildBlock(_ components: Content...) -> Content {
        Element(tagName: nil, elements: components)
    }
}
