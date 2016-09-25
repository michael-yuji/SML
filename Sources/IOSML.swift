

import Foundation

public func fileContent(of path: String, encoding: String.Encoding, replacement: String = "") -> String {
    guard let data = FileManager.default.contents(atPath: path) else {
        return replacement
    }
    
    guard let string = String(data: data, encoding: encoding) else {
        return replacement
    }
    
    return string
}
