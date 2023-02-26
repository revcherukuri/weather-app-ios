//
//  KineticCrypto.h
//  ZKineticLib
//
//  Created by Gavin McKenzie on 2017-02-09.
//  Copyright © 2017 Zighra Inc. All rights reserved.
//

#ifndef KineticCrypto_h
#define KineticCrypto_h


@interface KineticCryptoEncryptedData : NSObject
@property (nonatomic, strong) NSData *encryptedData;
@property (nonatomic, strong) NSData *salt;
@end

@interface KineticCrypto : NSObject 
@property (nonatomic, strong, readonly) NSData *clientPublicKey;
@property (nonatomic, strong, readonly) NSData *clientPrivateKey;
@property (nonatomic, strong, readonly) NSString *clientPublicKeyBase64;
@property (nonatomic, strong, readonly) NSString *clientPrivateKeyBase64;
@property (nonatomic, strong, readonly) NSData *serverPublicKey;
@property (nonatomic, strong, readonly) NSData *sharedSecret;
@property (nonatomic, strong, readonly) NSData *salt;

- (instancetype)initWithServerPublicKeyBase64:(NSString *)serverPublicKeyBase64;
- (instancetype)initWithServerPublicKeyBase64:(NSString *)serverPublicKeyBase64 clientPrivateKeyBase64:(NSString *)clientPrivateKeyBase64 clientPublicKeyBase64:(NSString *)clientPublicKeyBase64;
- (void)generateECDHKeyPair;
- (NSData *)generateSharedSecret;
- (KineticCryptoEncryptedData *)encryptedDataForData:(NSData *)data error:(NSError **)error;
- (NSData *)decryptedDataForData:(NSData *)data salt:(NSData *)salt error:(NSError **)error;
@end

#endif /* KineticCrypto_h */
