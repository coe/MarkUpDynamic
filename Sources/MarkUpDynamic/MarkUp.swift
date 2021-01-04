//
//  MarkUp.swift
//
//
//  Created by 日向 強 on 2020/12/15.
//

import Foundation

@dynamicMemberLookup
public class MarkUp {
    let tag: String
    var attributes: [String: String?]?
    var addEndTag = true
    var inside: Inside
    var queue:[MarkUp]
    
    public subscript(_ inside: MarkUp) -> MarkUp {
        self.inside = .markUp(inside)
        return self
    }
    
    public subscript(attributes attributes: [String: String?]) -> MarkUp {
        self.attributes = attributes
        return self
    }
    
    public subscript(character character: String) -> MarkUp {
        self.inside = .character(character)
        return self
    }
    
    public func doNotSpecifyEndTag() -> MarkUp {
        self.addEndTag = false
        return self
    }
    
    public subscript(dynamicMember member: String) -> MarkUp {
        queue.append(self)
        return MarkUp(tag: member,queue: queue)
    }
    
    public init(doctype:String) {
        self.tag = ""
        self.inside = .root(doctype)
        self.queue = []
    }
    
    public init() {
        self.tag = ""
        self.inside = .root("")
        self.queue = []
    }
    
    private init(tag: String, queue:[MarkUp]) {
        self.tag = tag
        self.inside = .character("")
        self.queue = queue
    }
    
    public func generate() -> String {
        queue.append(self)
        return queue.reduce("") { (result, markUp) -> String in
            switch markUp.inside {
            case .root(let docType):
                return result + docType
            case .markUp,.character:
                if addEndTag {
                    return result + String(format: "<%@%@>%@</%@>", markUp.tag, markUp.attributes?.attributeString ?? "", markUp.inside.generate(), markUp.tag)
                } else {
                    return result +  String(format: "<%@%@>", markUp.tag, markUp.attributes?.attributeString ?? "")
                }
            }
        }
    }
}

private extension Dictionary where Key == String, Value == String? {
    var attributeString: String {
        reduce("", { (result, arg1) -> String in
            let (key, value) = arg1
            if let value = value {
                return result + String(format: #" %@="%@""#, key, value)
            } else {
                return result + String(format: #" %@"#, key)
            }
        })
    }
}

enum Inside: CustomDebugStringConvertible {
    var debugDescription: String {
        switch self {
        case .markUp(let markUp):
            return "markUp:\(markUp.tag)"
        case .character(let character):
            return "character:\(character)"
        case .root(let doctype):
            return "root:\(doctype)"
        }
    }
    case root(String)
    case markUp(MarkUp)
    case character(String)
    
    func generate() -> String {
        switch self {
        case .markUp(let markUp):
            return markUp.generate()
        case .character(let character):
            return character
        case .root:
            return ""
        }
    }
}
