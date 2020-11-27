//
//  TDBridge.h
//  NativeBridge
//
//  Created by 123 on 2020/10/19.
//  Copyright © 2020 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <React/RCTBridgeModule.h>
#import <React/RCTEventEmitter.h>

NS_ASSUME_NONNULL_BEGIN

@interface TDBridge : RCTEventEmitter<RCTBridgeModule>

@end

NS_ASSUME_NONNULL_END
