//
//  SMLMain.swift
//  SMLKit
//
//  Created by yuuji on 9/25/16.
//
//

import spartanX
import SXF97
import Foundation

public enum SMLMode {
    case unix
    case inet(in_port_t)
    case inet6(in_port_t)
}

public final class SML : SXStreamSocketService {
    public var dataHandler: (SXQueue, Data) -> Bool
    public var errHandler: ((SXQueue, Error) -> ())?
    public var acceptedHandler: ((inout SXClientSocket) -> ())?
    
    public init(dataHandler: @escaping (SXQueue, Data) -> Bool) {
        self.dataHandler = dataHandler
    }
}

public func SMLInit(moduleName: String, mode: SMLMode = .unix, main: @escaping (HTTPRequest) -> HTTPResponse?) {
    SXKernelManager.initializeDefault()
    signal(SIGPIPE, SIG_IGN)
    let domain = "/tmp/spartanX-\(moduleName)"
    if FileManager.default.fileExists(atPath: domain) {
        unlink(domain)
    }

    
    let service =  SML { queue, data in
        guard let httpRequest = try? HTTPRequest(data: data) else {
            return false
        }
        
        if let raw = main(httpRequest) {
            _ = try? queue.writeAgent.write(data: raw.raw)
        }
        return true
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
    while (true) {
        sleep(99999)
    }
}


