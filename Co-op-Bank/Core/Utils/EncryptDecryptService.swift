//
//  EncryptDecryptService.swift
//  Co-op-Bank
//
//  Created by Martin Wainaina on 24/12/2024.
//

import Foundation

import Security
import CryptoKit

class EncryptDecryptService {
    
    static let shared = EncryptDecryptService()

    func encryptString(texts: [String: String], publicKey: SecKey) -> Result<[String: String], Error> {
        var result = [String: String]()
        
        do {
            for (key, text) in texts {
                guard let data = text.data(using: .utf8) else {
                    throw NSError(domain: "Invalid text encoding", code: 1, userInfo: nil)
                }
                
                let algorithm: SecKeyAlgorithm = .rsaEncryptionOAEPSHA256
                
                guard SecKeyIsAlgorithmSupported(publicKey, .encrypt, algorithm) else {
                    throw NSError(domain: "Algorithm not supported", code: 2, userInfo: nil)
                }
                
                var error: Unmanaged<CFError>?
                guard let encryptedData = SecKeyCreateEncryptedData(publicKey, algorithm, data as CFData, &error) else {
                    throw error!.takeRetainedValue() as Error
                }
                
                let base64Encoded = (encryptedData as Data).base64EncodedString()
                result[key] = base64Encoded
                
                //print("ENCRYPT EncryptDecryptService \(key) value: \(base64Encoded)")
            }
            return .success(result)
        } catch {
            return .failure(error)
        }
    }

    func decryptString(texts: [String: String], privateKey: SecKey) -> Result<[String: String], Error> {
        // TODO: Not yet implemented
        return .failure(NSError(domain: "Not yet implemented", code: 3, userInfo: nil))
    }
    
    func addRSAPublicKey(key: String) -> SecKey? {
        let keyString = key
            .replacingOccurrences(of: "-----BEGIN RSA PUBLIC KEY-----", with: "")
            .replacingOccurrences(of: "-----END RSA PUBLIC KEY-----", with: "")
            .replacingOccurrences(of: "\\n", with: "")

        guard let data = Data(base64Encoded: keyString) else {
            return nil
        }

        let options: [String: Any] = [
            kSecAttrKeyType as String: kSecAttrKeyTypeRSA,
            kSecAttrKeyClass as String: kSecAttrKeyClassPublic,
            kSecAttrKeySizeInBits as String: 2048
        ]

        return SecKeyCreateWithData(data as CFData, options as CFDictionary, nil)
    }
    
    func encryptData(publicKey: String, texts: [String: String]) -> Result<[String: String], Error> {
        guard let publicKey: SecKey = addRSAPublicKey(key: publicKey) else {
            return .failure("failed to add publickey" as! Error)
        }
        
        let service = EncryptDecryptService()
        
        let encryptionResult = service.encryptString(texts: texts, publicKey: publicKey)
        
        return encryptionResult
    }
    
    /*
    func example() {
        let public_key = ""
        guard let publicKey: SecKey = addRSAPublicKey(key: public_key) else { return }
        let service = EncryptDecryptService()
        
        let textsToEncrypt = [
            "username": "metole",
            "password": "12345",
            "type": "bas64 string"
        ]
        
        let encryptionResult = service.encryptString(texts: textsToEncrypt, publicKey: publicKey)

        switch encryptionResult {
        case .success(let encryptedTexts):
            print("Encrypted texts: \(encryptedTexts)")
        case .failure(let error):
            print("Encryption error: \(error)")
        }
    }
    */
}
