//
//  Data+.swift
//  HHFoundationKit
//
//  Created by whh on 2023/7/31.
//

import Foundation
import CommonCrypto

// MARK: - 通用扩展
extension Data {
    
    
}

// MARK: - 兼容协议
extension Data: HHCompatible { }

// MARK: - 兼容协议 - 加密（crypto）
public extension HHElement where Element == Data {
    
    @available(macOS, introduced: 10.4, deprecated: 10.15, message: "This function is cryptographically broken and should not be used in security contexts. Clients should migrate to SHA256 (or stronger).")
    func md5() -> String {
        var digest = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
        _ = element.withUnsafeBytes { (bytes: UnsafeRawBufferPointer) in
            CC_MD5(bytes.baseAddress, CC_LONG(element.count), &digest)
        }
        return digest.map { String(format: "%02x", $0) }.joined()
    }
    
    /// SHA1加密（生成的结果是40位）
    func sha1() -> String {
        var hash = [UInt8](repeating: 0, count: Int(CC_SHA1_DIGEST_LENGTH))
        _ = element.withUnsafeBytes {
            CC_SHA1($0.baseAddress, CC_LONG(element.count), &hash)
        }
        return hash.map { String(format: "%02x", $0) }.joined()
    }
    
    /// SHA256加密（生成的结果是64位）
    func sha256() -> String {
        var hash = [UInt8](repeating: 0, count: Int(CC_SHA256_DIGEST_LENGTH))
        _ = element.withUnsafeBytes {
            CC_SHA256($0.baseAddress, CC_LONG(element.count), &hash)
        }
        return hash.map { String(format: "%02x", $0) }.joined()
    }
    
    /// SHA512加密（生成的结果是128位）
    func sha512() -> String {
        var hash = [UInt8](repeating: 0, count: Int(CC_SHA512_DIGEST_LENGTH))
        _ = element.withUnsafeBytes {
            CC_SHA512($0.baseAddress, CC_LONG(element.count), &hash)
        }
        return hash.map { String(format: "%02x", $0) }.joined()
    }
    
}
