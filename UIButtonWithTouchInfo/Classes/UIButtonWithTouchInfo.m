//
//  UIButtonWithTouchInfo.m
//  simplePdfReaderIOS
//
//  Created by Serge Moskalenko on 25.07.17.
//  Copyright © 2017 Serge Moskalenko. All rights reserved.
//  skype:camopu-ympo, http://camopu.rhorse.ru/ios
//

#import "UIButtonWithTouchInfo.h"

@interface UIButtonWithTouchInfo()
@property (nonatomic) CGPoint touchPoint;
@property (nonatomic) BOOL isTouched;
@end

@implementation UIButtonWithTouchInfo

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
         [self setUp];
    }
    return self;
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setUp];
    }
    return self;
}

- (void)setUp {
    _isClearForTouch = YES;
}

- (void)callDelegate:(NSSet<UITouch *> *)touches action:(UIButtonWithTouchInfoAction)action {
    _touchPointCurrent = [(UITouch *)[touches anyObject] locationInView:self];
    if (self.frame.size.width > 0 && self.frame.size.height > 0)
        _touchPartCurrent = CGPointMake(_touchPointCurrent.x / self.frame.size.width, _touchPointCurrent.y / self.frame.size.height);
    else
        _touchPartCurrent = CGPointZero;

    if ([self.delegate respondsToSelector:@selector(UIButtonWithTouchInfo:didTouchAction:)])
        [self.delegate UIButtonWithTouchInfo:self didTouchAction:action];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self callDelegate:touches action:Began];
    _isTouched = YES;
     [super touchesBegan:touches withEvent:event];
    if (_isClearForTouch)
        [self.nextResponder touchesBegan:touches withEvent:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [self callDelegate:touches action:Moved];
    [super touchesMoved:touches withEvent:event];
    if (_isClearForTouch)
        [self.nextResponder touchesMoved:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self callDelegate:touches action:Cancelled];
    _isTouched = NO;
    _touchPoint = _touchPart = CGPointZero;
    [super touchesCancelled:touches withEvent:event];
    if (_isClearForTouch)
        [self.nextResponder touchesCancelled:touches withEvent:event];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self callDelegate:touches action:Ended];
    if (_isTouched) {
        _touchPoint = [(UITouch *)[touches anyObject] locationInView:self];
        if (self.frame.size.width > 0 && self.frame.size.height > 0)
            _touchPart = CGPointMake(_touchPoint.x / self.frame.size.width, _touchPoint.y / self.frame.size.height);
        else
            _touchPart = CGPointZero;
    }
   _isTouched = NO;
    [super touchesEnded:touches withEvent:event];
    if (_isClearForTouch)
        [self.nextResponder touchesEnded:touches withEvent:event];
}

@end
