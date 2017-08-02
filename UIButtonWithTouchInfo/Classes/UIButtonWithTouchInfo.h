//
//  UIButtonWithTouchInfo.h
//  simplePdfReaderIOS
//
//  Created by Serge Moskalenko on 25.07.17.
//  Copyright © 2017 Serge Moskalenko. All rights reserved.
//  skype:camopu-ympo, http://camopu.rhorse.ru/ios
//

#import <UIKit/UIKit.h>

typedef enum {
    Began,
    Moved,
    Cancelled,
    Ended
} UIButtonWithTouchInfoAction;

@class UIButtonWithTouchInfo;
@protocol UIButtonWithTouchInfoProtocol <NSObject>
@optional
- (void)UIButtonWithTouchInfo:(UIButtonWithTouchInfo *)uiButtonWithTouchInfo didTouchAction:(UIButtonWithTouchInfoAction)action;
@end

@interface UIButtonWithTouchInfo : UIButton
@property (nonatomic, assign) BOOL isClearForTouch;
@property (nonatomic, readonly) CGPoint touchPoint;
@property (nonatomic, readonly) CGPoint touchPart; // normalized
@property (nonatomic, readonly) CGPoint touchPointCurrent;
@property (nonatomic, readonly) CGPoint touchPartCurrent; // normalized
@property (nonatomic, weak) id <UIButtonWithTouchInfoProtocol> delegate;
@end
