//
//  HHCrypto.swift
//  HHFoundationKit
//
//  Created by whh on 2023/7/31.
//

import Foundation
import CommonCrypto

/// 加密类
public struct HHCrypto {
    
    public enum HMACAlogorithm {
        case MD5, SHA1, SHA224, SHA256, SHA384, SHA512
        
        public var algorithm: CCHmacAlgorithm {
            let value: Int
            switch self {
            case .MD5:
                value = kCCHmacAlgMD5
            case .SHA1:
                value = kCCHmacAlgSHA1
            case .SHA224:
                value = kCCHmacAlgSHA224
            case .SHA256:
                value = kCCHmacAlgSHA256
            case .SHA384:
                value = kCCHmacAlgSHA384
            case .SHA512:
                value = kCCHmacAlgSHA512
            }
            return CCHmacAlgorithm(value)
        }
        
        public var digestLength: Int {
            var value: Int32 = 0
            switch self {
            case .MD5:
                value = CC_MD5_DIGEST_LENGTH
            case .SHA1:
                value = CC_SHA1_DIGEST_LENGTH
            case .SHA224:
                value = CC_SHA224_DIGEST_LENGTH
            case .SHA256:
                value = CC_SHA256_DIGEST_LENGTH
            case .SHA384:
                value = CC_SHA384_DIGEST_LENGTH
            case .SHA512:
                value = CC_SHA512_DIGEST_LENGTH
            }
            return Int(value)
        }
        
    }
    
}

extension HHCrypto {
    
    public func hamc(_ content: String, alg: HMACAlogorithm, key: String) -> String {
        let str = content.cString(using: .utf8)
        let strLen = Int(content.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = alg.digestLength
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        let keyStr = key.cString(using: .ascii)
        let keyLen = Int(key.lengthOfBytes(using: String.Encoding.utf8))
        CCHmac(alg.algorithm, keyStr!, keyLen, str!, strLen, result)
        let digest = stringFromResult(result: result, length: digestLen)
        result.deallocate()
        return digest
    }
    
    public func hmacBase64(_ content: String, alg: HMACAlogorithm, key: String) -> String {
        let cKey = key.cString(using: .utf8) ?? []
        let cData = content.cString(using: .utf8) ?? []
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: alg.digestLength)
        CCHmac(alg.algorithm, cKey, strlen(cKey), cData, strlen(cData), result)
        let hmacData: NSData = .init(bytes: result, length: Int(alg.digestLength))
        var hmacBase64: String = hmacData.base64EncodedString(options: .init(rawValue: 0))
        if let value = hmacBase64.addingPercentEncoding(withAllowedCharacters: .alphanumerics) {
            hmacBase64 = value
        }
        return hmacBase64
    }
    
    private func stringFromResult(result: UnsafeMutablePointer<CUnsignedChar>, length: Int) -> String {
        let hash = NSMutableString()
        for i in 0..<length {
            hash.appendFormat("%02x", result[i])
        }
        return String(hash)
    }
    
}
