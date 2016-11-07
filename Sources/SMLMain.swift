//
//  SMLMain.swift
//  SMLKit
//
//  Created by yuuji on 9/25/16.
//
//

import spartanX
import SXF97
import CoreCache
import Foundation

public enum SMLMode {
    case unix
    case inet(in_port_t)
    case inet6(in_port_t)
}

public extension SXRouter {
    mutating func addFileSystemSource(root dir: String, as uri: String) {
        CacheContainer.shared.cacheFile(at: dir, as: dir, using: .lazyUp2Date, lifetime: .idleInterval(CCTimeInterval(sec: 10 * 60)), errHandle: nil)
    }
}

public class SMLService : SXService {
    var dict = [String: (HTTPRequest) -> HTTPResponse?]()
    var furis = [String: String]()
    public var supportingMethods: SendMethods = [.write, .send, .sendfile]
    var container = CacheContainer(refreshResulotion: CCTimeInterval(milisec: 500))
    
    public subscript(uri: String) -> ((HTTPRequest) -> HTTPResponse?)? {
        get {
            return dict[uri]
        } set {
            dict[uri] = newValue
        }
    }
    
    public func setRoute(uri: String, handler: @escaping (HTTPRequest) -> HTTPResponse) {
        self[uri] = handler
    }
    
    public init() {
        self.set404(text: html {[
            tag("h1") {"SML - 404 not found"},
            tag("p") { "The page you trying to reach is not available" }
            ]})
    }
    
    public func addStaticFileSource(root: String, as uri: String) {
        self.furis[uri] = root
    }
    
    public func addStaticContent(uri: String, content: Data) {
        self.container.cacheDynamicContent(as: uri, using: .once, lifetime: .forever) {
            HTTPResponse(status: 200, with: content).raw
        }
    }
    
    public func set404(text: String) {
        self.container.cacheDynamicContent(as: "404", using: .once, lifetime: .forever) {
            HTTPResponse(status: 404, text: text).raw
        }
    }
    
    public func received(data: Data, from connection: SXConnection) throws -> ShouldProceed {
        let req = try HTTPRequest(data: data)
        if let res_fn = self[req.uri.path] {
            if let res = res_fn(req) {
                do {
                    try res.send(with: self.supportingMethods, using: connection.writeAgent)
                    return true
                } catch {
                    throw error
                }
            }
        }
        
        if let d = self.container[req.uri.path] {
            try connection.write(data: d)
            return true
        }
        
        for (furi, real) in furis {
            if req.uri.path.hasPrefix(furi) {
                if let d = self.container[req.uri.path] {
                    try connection.write(data: d)
                    return true
                } else {
                    
                    var xruri = req.uri.path
                    xruri.removeSubrange(xruri.startIndex..<xruri.index(xruri.startIndex, offsetBy: furi.characters.count))
                    
                    self.container.cacheFile(at: real + xruri, as: "file:" + req.uri.path, using: .lazyUp2Date, lifetime: .idleInterval(CCTimeInterval(sec: 600)), errHandle: nil)
                    self.container.cacheDynamicContent(as: req.uri.path, using: .lazyUp2Date, lifetime: .strictInterval(CCTimeInterval(sec: 10)), generator: { () -> Data in
                        if let filed = self.container["file:" + req.uri.path] {
                            return HTTPResponse(status: 200, with: filed).raw
                        }
                        return self.container["404"]!
                    })
                    
                    try connection.write(data: container[req.uri.path]!)
                    return true
                }
            }
        }
        
        if let resd = self.container["404"] {
            try connection.write(data: resd)
            return true
        }
        
        return false
        
    }
    
    public func exceptionRaised(_ exception: Error, on connection: SXConnection) -> ShouldProceed {
        return false
    }
}

public func SMLInit(moduleName: String, mode: SMLMode = .unix, router service: SMLService) {
    
    SXKernelManager.initializeDefault()
    signal(SIGPIPE, SIG_IGN)
    
    let domain = "/tmp/spartanX-\(moduleName)"
    if FileManager.default.fileExists(atPath: domain) {
        unlink(domain)
    }
    
    var server: SXServerSocket!
    
    switch mode {
    case .unix:
        server = try! SXServerSocket.unix(service: service,
                                          domain: domain,
                                          type: .stream)
        
    case let .inet(port):
        server = try! SXServerSocket.tcpIpv4(service: service,
                                             port: port)
    case let .inet6(port):
        server = try! SXServerSocket.tcpIpv6(service: service,
                                             port: port)
    }
    
    SXKernelManager.default!.manage(server, setup: nil)
    dispatchMain()
}


