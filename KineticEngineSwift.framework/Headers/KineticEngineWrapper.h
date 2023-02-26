//
//  KineticEngine.h
//  CoreEnigne
//
//  Created by Cyrus Lo on 2017-12-12.
//  Copyright © 2017 Cyrus Lo. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 The Obj-C bridge to C++ AI authentication engine
 */
@interface KineticEngineWrapper : NSObject
+ (NSString *) ALLDATA;
+ (NSString *) NOTOUCH;
+ (NSString *) NOGYRO;
+ (NSString *) NOACCEL;
+ (NSString *) ONLYTOUCH;
+ (NSString *) ONLYGYRO;

- (NSString *) GetCurrentTime;

- (void) SetDataPath: (NSString *)path;

- (NSString *) CreateProfile: (NSString *) pCode;

- (NSString *) CheckSwipe:  (NSString *) pCode
                            accel : (NSString *) accel
                            gyro : (NSString *) gyro
                            gyroAngles: (NSString *) gyroAngles
                            touch: (NSString *) touch
                            secureTraining :(bool) secureTraining
                            model: (NSString *) model;

- (NSString *) TrainSwipe:  (NSString *) pCode
                            accel: (NSString *) accel
                            gyro:  (NSString *) gyro
                            gyroAngles: (NSString *) gyroAngles
                            touch: (NSString *) touch;

- (NSString *) CheckTap:    (NSString *) pCode
                            device_info_str: (NSString *) device_info_str
                            gesture_info_str: (NSString *) gesture_info_str;

- (NSString *) TrainTap:    (NSString *) pCode
                            device_info_str: (NSString *) device_info_str
                            gesture_info_str: (NSString *) gesture_info_str;

@end
