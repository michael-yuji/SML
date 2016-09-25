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


func SMLInit(moduleName: String, main: (HTTPRequest) -> HTTPResponse?) {
    SXKernelManager.initializeDefault()
    signal(SIGPIPE, SIG_IGN)
    let domain = "/tmp/spartanX-\(modname)"
    if FileManager.default.fileExists(atPath: domain) {
        unlink(domain)
    }
    
    let server = try! SXServerSocket.unix(service: service, domain: domain, type: .stream)
    SXKernelManager.default!.manage(server, setup: nil)
    while (true) {
        sleep(99999)
    }
}


let service = SXConnectionService { queue, data in
    let httpRequest = try? HTTPRequest(data: data)
    if let raw = SMLMain(request: httpRequest) {
        _ = try? queue.writeAgent.write(data: raw.raw)
    }
    return true
}

