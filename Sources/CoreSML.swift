


public func link(rel: String?, type: String?, href: String) -> String {
    var base = "<link "
    if let rel = rel {
        base.append("rel=\(rel) ")
    }
    
    if let type = type {
        base.append("type=\(type) ")
    }
    
    base.append("href='\(href)' />")
    return base
}

public func script(_ body: @autoclosure ()->String) -> String {
    return "<script>" + body() + "</script>"
}

public func script(type: String?, src: String?, _ body: ()->String = {""}) -> String {
    var base = "<script "
    if let t = type {
        base.append(t + " ")
    }
    
    if let src = src {
        base.append(src + " ")
    }
    
    base.append(">" + body() + "</script>")
    
    return base
}

public func script(type: String? = nil, src: String? = nil, _ body: ()->[String] = {[""]}) -> String {
    var base = "<script "
    if let t = type {
        base.append(t + " ")
    }
    
    if let src = src {
        base.append(src + " ")
    }
    
    base.append(">" + body().reduce(""){"\($0)\($1)"} + "</script>")
    
    return base
}

public func sctag(_ arguments: String...) -> String {
    return "<" + arguments.reduce("") {"\($0) \($1)"} + "/>"
}

/***/

public func head(_ body: () -> String) -> String {
    return "<head>" + body() + "</head>"
}

public func head(_ body: () -> [String]) -> String {
    return "<head>" + body().reduce("") {"\($0)\($1)"} + "</head>"
}

/***/

public func html(_ attributes: String..., _ body: () -> String) -> String {
    
    return "<html\(attributes.reduce(""){"\($0) \($1)"})>\(body())</html>"
    
}

public func html(_ attributes: String..., _ body: () -> [String]) -> String {
    
    return "<html\(attributes.reduce(""){"\($0) \($1)"})>\(body().reduce(""){"\($0)\($1)"})</html>"
    
}

/***/

public func body(_ attributes: String...) -> (String..., ([String]) -> String ) -> String {
    return {
        (arguments: String..., fn: (([String]) -> String)) in
        return "<body\(attributes.reduce(""){"\($0) \($1)"})>\(fn(arguments))</body>"
    }
}

public func body(_ attributes: String..., _ body: () -> String) -> String {
    
    return "<body\(attributes.reduce(""){"\($0) \($1)"})>\(body())</body>"
    
}

public func body(_ attributes: String..., _ body: () -> [String]) -> String {
    
    return "<body\(attributes.reduce(""){"\($0) \($1)"})>\(body().reduce(""){"\($0)\($1)"})</body>"
    
}

public func body(_ attributes: String...) -> String {
    return "<body\(attributes.reduce(""){"\($0) \($1)"})></body>"
}

public func body(_ attributes: [String]) -> (String..., ([String]) -> String ) -> String {
    return {
        (arguments: String..., fn: (([String]) -> String)) in
        return "<body\(attributes.reduce(""){"\($0) \($1)"})>\(fn(arguments))</body>"
    }
}

public func body(_ attributes: [String], _ body: () -> String) -> String {
    
    return "<body\(attributes.reduce(""){"\($0) \($1)"})>\(body())</body>"
    
}

public func body(_ attributes: [String], _ body: () -> [String]) -> String {
    return "<body \(attributes.reduce(""){"\($0) \($1)"})>\(body().reduce(""){"\($0)\($1)"})</body>"
    
}

public func div(_ attributes: String...) -> (String..., ([String]) -> String ) -> String {
    return {
        (arguments: String..., fn: (([String]) -> String)) in
        return "<div\(attributes.reduce(""){"\($0) \($1)"})>\(fn(arguments))</div>"
    }
}

public func div(_ attributes: String..., _ body: () -> String) -> String {
    
    return "<div\(attributes.reduce(""){"\($0) \($1)"})>\(body())</div>"
    
}

public func div(_ attributes: String..., _ body: () -> [String]) -> String {
    
    return "<div\(attributes.reduce(""){"\($0) \($1)"})>\(body().reduce(""){"\($0)\($1)"})</div>"
    
}

public func div(_ attributes: String...) -> String {
    return "<div\(attributes.reduce(""){"\($0) \($1)"})></div>"
}

public func div(_ attributes: [String]) -> (String..., ([String]) -> String ) -> String {
    return {
        (arguments: String..., fn: (([String]) -> String)) in
        return "<div\(attributes.reduce(""){"\($0) \($1)"})>\(fn(arguments))</div>"
    }
}

public func div(_ attributes: [String], _ body: () -> String) -> String {
    
    return "<div\(attributes.reduce(""){"\($0) \($1)"})>\(body())</div>"
    
}

public func div(_ attributes: [String], _ body: () -> [String]) -> String {
    return "<div \(attributes.reduce(""){"\($0) \($1)"})>\(body().reduce(""){"\($0)\($1)"})</div>"
    
}

/***/
public func tag(_ tagname: String, _ attributes: String...) -> (String..., ([String]) -> String ) -> String {
    return {
        (arguments: String..., fn: (([String]) -> String)) in
        return "<\(tagname)\(attributes.reduce(""){"\($0) \($1)"})>\(fn(arguments))</\(tagname)>"
    }
}

public func tag(_ tagname: String, _ attributes: String..., _ body: () -> String) -> String {
    
    return "<\(tagname)\(attributes.reduce(""){"\($0) \($1)"})>\(body())</\(tagname)>"
    
}

public func tag(_ tagname: String, _ attributes: String..., _ body: () -> [String]) -> String {
    
    return "<\(tagname)\(attributes.reduce(""){"\($0) \($1)"})>\(body().reduce(""){"\($0)\($1)"})</\(tagname)>"
    
}

public func tag(_ tagname: String, _ attributes: String...) -> String {
    return "<\(tagname)\(attributes.reduce(""){"\($0) \($1)"})></\(tagname)>"
}

public func tag(_ tagname: String, _ attributes: [String]) -> (String..., ([String]) -> String ) -> String {
    return {
        (arguments: String..., fn: (([String]) -> String)) in
        return "<\(tagname)\(attributes.reduce(""){"\($0) \($1)"})>\(fn(arguments))</\(tagname)>"
    }
}

public func tag(_ tagname: String, _ attributes: [String], _ body: () -> String) -> String {
    
    return "<\(tagname)\(attributes.reduce(""){"\($0) \($1)"})>\(body())</\(tagname)>"
    
}

public func tag(_ tagname: String, _ attributes: [String], _ body: () -> [String]) -> String {
    
    return "<\(tagname)\(attributes.reduce(""){"\($0) \($1)"})>\(body().reduce(""){"\($0)\($1)"})</\(tagname)>"
    
}

public func tag(_ tagname: String, _ attributes: [String]) -> String {
    return "<\(tagname)\(attributes.reduce(""){"\($0) \($1)"})></\(tagname)>"
}

public func class_(_ name: String) -> String {
    return "class='\(name)'"
}

public func id(_ name: String) -> String {
    return "id='\(name)'"
}

public func meta(_ attrs: String...) -> String {
    return "<meta" + attrs.reduce(" ") { "\($0) \($1)" } + "/>"
}

public func charset(_ c: String) -> String {
    return "charset='\(c)'"
}

public func css(_ c: String) -> String {
    return link(rel: "stylesheet", type: "text/css", href: c)
}

private func==(lhs: CustomStringConvertible, rhs: CustomStringConvertible) -> Bool {
    return lhs.description == rhs.description
}

public func style(_ attrs: String...) -> String {
    return attrs.reduce("style=\"") { "\($0);\($1)" } + "\""
}

extension String {
    func color(_ name: String) -> String {
        return "<span style=\"color:\(name)\">\(self)</span>"
    }
    
    func link(url: String, _ attr: String...) -> String {
        var attrs = attr
        attrs.append("href=\"\(url)\"")
        return tag("a", attrs){self}
    }
    
    func span(_ attrs: String...) -> String {
        return "<span" + attrs.reduce(" ") { "\($0) \($1)" } + ">" + self + "</span>"
    }
}

extension Array {
    func ul_li_formatting(_ i: String = "",
                          ulAttribute: @autoclosure (String) -> [String],
                          liAttribute: @autoclosure (String) -> [String],
                          recurive: Bool) -> String {
        return tag("ul", ulAttribute(i)) {
            self.map({
                if recurive {
                    if let aarray = $0 as? Array {
                    return aarray.ul_li_formatting("\($0)", ulAttribute: ulAttribute, liAttribute: liAttribute, recurive: true)
                    }
                    return "\($0)"
                } else {
                    return "\($0)"
                }
            })
        }
    }
    
}
















