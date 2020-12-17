//
//  MarkUpDynamic.swift
//
//
//  Created by 日向 強 on 2020/12/15.
//

import Foundation

@dynamicMemberLookup
public class MarkUpDynamic {
    let tag: String
    var attributes: String?
    var addEndTag = true
    var inside: Inside
    var queue:[MarkUpDynamic]
    
    public subscript(_ inside: MarkUpDynamic) -> MarkUpDynamic {
        self.inside = .markUp(inside)
        return self
    }
    
    public subscript(attributes attributes: [String: String?]) -> MarkUpDynamic {
        self.attributes = attributes.reduce("", { (result, arg1) -> String in
            let (key, value) = arg1
            if let value = value {
                return result + String(format: #" %@="%@""#, key, value)
            } else {
                return result + String(format: #" %@"#, key)
            }
        })
        
        return self
    }
    
    public subscript(character character: String) -> MarkUpDynamic {
        self.inside = .character(character)
        return self
    }
    
    public subscript(addEndTag addEndTag: Bool) -> MarkUpDynamic {
        self.addEndTag = addEndTag
        return self
    }
    
    public subscript(dynamicMember member: String) -> MarkUpDynamic {
        queue.append(self)
        return MarkUpDynamic(tag: member,queue: queue)
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
    
    private init(tag: String, queue:[MarkUpDynamic]) {
        self.tag = tag
        self.queue = queue
        self.inside = .character("")
    }
    
    public func generate() -> String {
        queue.append(self)
        var str = ""
        queue.forEach { (html) in
            switch html.inside {
            case .root(let docType):
                str += docType
            case .markUp,.character:
                if addEndTag {
                    str += String(format: "<%@%@>%@</%@>", html.tag, html.attributes ?? "", html.inside.generate(), html.tag)
                } else {
                    str += String(format: "<%@%@>", html.tag, html.attributes ?? "")
                }
                
            }
            
        }
        return str
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
    case markUp(MarkUpDynamic)
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
