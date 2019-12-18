//
//  KeyFetcher.swift
//  BitSense
//
//  Created by Peter on 03/12/19.
//  Copyright © 2019 Fontaine. All rights reserved.
//

import Foundation

class KeyFetcher {
    
    func privKey(index: Int, completion: @escaping ((privKey: String, error: Bool)) -> Void) {
        
        let cd = CoreDataService()
        cd.retrieveSeed { (encSeed, error) in
            
            if !error {
                
                let enc = Encryption()
                enc.decrypt(data: encSeed!) { (words, error) in
                    
                    if !error {
                        
                        let wordArray = words.split(separator: " ")
                        
                        if let mnemonic = BTCMnemonic.init(words: wordArray, password: "", wordListType: .english) {
                            
                            // MARK: Change the derivation path to m/84'/0'/0'/0 for mainnet
                            
                            if let keychain = mnemonic.keychain.derivedKeychain(withPath: "m/84'/1'/0'/0") {
                                
                                keychain.key.isPublicKeyCompressed = true
                                
                                let int = UInt32(index)
                                
                                if let keyToReturn = (keychain.key(at: int)?.wifTestnet) {
                                                                        
                                    completion((keyToReturn,false))
                                    
                                } else {
                                    
                                    completion(("",true))
                                    
                                }
                                
                            } else {
                                
                                completion(("",true))
                                
                            }
                            
                        }
                        
                    }
                    
                }
                
            }
            
        }
        
    }
    
    func bip32Xpub(completion: @escaping ((xpub: String, error: Bool)) -> Void) {
        
        let cd = CoreDataService()
        cd.retrieveSeed { (encSeed, error) in
            
            if !error {
                
                let enc = Encryption()
                enc.decrypt(data: encSeed!) { (words, error) in
                    
                    if !error {
                        
                        let wordArray = words.split(separator: " ")
                        
                        if let mnemonic = BTCMnemonic.init(words: wordArray, password: "", wordListType: .english) {
                            
                            if let keychain = mnemonic.keychain.derivedKeychain(withPath: "m/84'/0'/0'/0") {
                                
                                if let xpub = keychain.extendedPublicKey {
                                    
                                    // MARK: To revert to mainnet comment out the tpub and replace the tpub with the xpub in completion
                                    // have to hardcode a tpub for now as this libary does not produce them...
                                    // using these words: decide insect sign cover bicycle other chief what industry bomb lobster lonely piece toss practice
                                    // to get this BIP32 tpub (not account, to simplify the derivation path and importmulti command): tpubDFDmUKGUCgamEmJ79BfaZsobK3pCYpTU9uBPLr1QF8kszgQj3WkWh2u6LEVxg3URRqNSoGHMk2KVwguKkcwyu5JYQM1TM1EbNAYMsGFpN6Q
                                    
                                    let tpub = "tpubDFDmUKGUCgamEmJ79BfaZsobK3pCYpTU9uBPLr1QF8kszgQj3WkWh2u6LEVxg3URRqNSoGHMk2KVwguKkcwyu5JYQM1TM1EbNAYMsGFpN6Q"
                                    completion((tpub,false))
                                    
                                } else {
                                    
                                    completion(("",true))
                                    
                                }
                                
                            } else {
                                
                                completion(("",true))
                                
                            }
                            
                        }
                        
                    } else {
                        
                        completion(("",true))
                        
                    }
                    
                }
                
            } else {
                
                completion(("",true))
                
            }
            
        }
        
    }
    
    func bip32Xprv(completion: @escaping ((xprv: String, error: Bool)) -> Void) {
        
        let cd = CoreDataService()
        cd.retrieveSeed { (encSeed, error) in
            
            if !error {
                
                let enc = Encryption()
                enc.decrypt(data: encSeed!) { (words, error) in
                    
                    if !error {
                        
                        let wordArray = words.split(separator: " ")
                        
                        if let mnemonic = BTCMnemonic.init(words: wordArray, password: "", wordListType: .english) {
                            
                            if let keychain = mnemonic.keychain.derivedKeychain(withPath: "m/84'/0'/0'/0") {
                                
                                if let xprv = keychain.extendedPrivateKey {
                                    
                                    // have to hardcode a tpub for now as this libary does not produce them...
                                    // using these words: decide insect sign cover bicycle other chief what industry bomb lobster lonely piece toss practice
                                    // to get this BIP32 tpub (not account, to simplify the derivation path and importmulti command): tpubDFDmUKGUCgamEmJ79BfaZsobK3pCYpTU9uBPLr1QF8kszgQj3WkWh2u6LEVxg3URRqNSoGHMk2KVwguKkcwyu5JYQM1TM1EbNAYMsGFpN6Q
                                    
                                    //let tpub = "tpubDFDmUKGUCgamEmJ79BfaZsobK3pCYpTU9uBPLr1QF8kszgQj3WkWh2u6LEVxg3URRqNSoGHMk2KVwguKkcwyu5JYQM1TM1EbNAYMsGFpN6Q"
                                    completion((xprv,false))
                                    
                                } else {
                                    
                                    completion(("",true))
                                    
                                }
                                
                            } else {
                                
                                completion(("",true))
                                
                            }
                            
                        }
                        
                    } else {
                        
                        completion(("",true))
                        
                    }
                    
                }
                
            } else {
                
                completion(("",true))
                
            }
            
        }
        
    }
    
}
