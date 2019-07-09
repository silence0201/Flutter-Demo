//
//  HybridViewController.h
//  FLutterHybridDemo
//
//  Created by lyy on 2019/5/14.
//  Copyright © 2019 lyy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, HybridChannelType) {
    HybridBasicMessageChannelType,
    HybridMethodChannelType,
    HybridEventChannelType,
};

@interface HybridViewController : UIViewController

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)initWithChannelType:(HybridChannelType)channelType;

@end

NS_ASSUME_NONNULL_END
