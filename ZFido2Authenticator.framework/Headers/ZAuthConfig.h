//
//  ZAuthConfig.h
//  zauthcore
//
//  Created by Lo Cyrus on 8/2/2019.
//  Copyright © 2019 Lo Cyrus. All rights reserved.
//

#ifndef ZAuthConfig_h
#define ZAuthConfig_h


@interface ZAuthConfig : NSObject {
    NSString *_deviceId;
}

@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) NSString * protocol;
@property (nonatomic, retain) NSString * port;
@property (nonatomic, retain) NSString * appCode;
@property (nonatomic, retain) NSString * presetAuthenticator;

-(id) init;

@end

#endif /* ZAuthConfig_h */
