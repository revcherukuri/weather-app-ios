//
//  ZAuthenticator.h
//  zauthcore
//
//  Created by Lo Cyrus on 22/4/2019.
//  Copyright © 2019 Lo Cyrus. All rights reserved.
//

#ifndef ZAuthenticator_h
#define ZAuthenticator_h
#import <Foundation/Foundation.h>

@interface ZAuthenticator : NSObject {

}

@property (class, readonly, nonatomic, retain) ZAuthenticator* shareInstance;
typedef void (^ZAuthCompleteBlock) (NSError *error, bool result);

#pragma mark - FIDO2 operations
- (NSDictionary *) createAttestationObject:(NSString *)userId rpName:(NSString *)rp origin:(NSString *)origin challenge:(NSString *)challenge ;
- (NSDictionary *) createAssertionObject:(NSString *)userId credId:(NSString *) credId origin:(NSString *)origin  challenge:(NSString *)challenge ;
@end

#endif /* ZAuthenticator_h */
