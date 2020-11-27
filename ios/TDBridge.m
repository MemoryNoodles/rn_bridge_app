//
//  TDBridge.m
//  NativeBridge
//
//  Created by 123 on 2020/10/19.
//  Copyright © 2020 Facebook. All rights reserved.
//

#import "TDBridge.h"

static TDBridge * _bridge = nil;
static NSString * const bridgeObserver =  @"BridgeObserver";
@implementation TDBridge {
  BOOL _isStartObserving;
}

RCT_EXPORT_MODULE(jsClassName)

+ (instancetype)shared {
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    _bridge = [[TDBridge alloc] init];
  });
  return _bridge;
}

- (instancetype)init {
  if (_bridge) {
    return _bridge;
  }else {
    return [super init];
  }
}

// send
- (NSArray<NSString *>*)supportedEvents {
  return @[bridgeObserver];
}

- (void)startObserving {
  _isStartObserving = true;
}

- (void)stopObserving {
  _isStartObserving = false;
}


- (void)sendEventWithName:(NSString *)name body:(id)body {
  if (!_isStartObserving) {
    return;
  }
  [super sendEventWithName:name body:body];
}




// receive

RCT_EXPORT_METHOD(send) {
  NSLog(@"send");
}

RCT_EXPORT_METHOD(sendAndCallback: (RCTResponseSenderBlock)cb) {
  
  cb(@[@"iOS sendAndCallback"]);
}

RCT_EXPORT_METHOD(sendAndWait) {
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(6.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    [self sendEventWithName:bridgeObserver body:@"iOS sendAndWait"];
  });
}


// 初始化赋值 修改无效 注意不会要和方法名重名
- (NSDictionary *)constantsToExport {
  return @{@"sendKey": @"发送",
           @"sendAndCallbackKey": @"发送带回调",
           @"sendAndWaitKey": @"发送后等待app主动调用"
  };
}
@end
