//
//  MSVViewController.m
//  UIButtonWithTouchInfo
//
//  Created by sergemoskalenko on 08/02/2017.
//  Copyright (c) 2017 sergemoskalenko. All rights reserved.
//  skype:camopu-ympo, http://camopu.rhorse.ru/ios
//

#import "MSVViewController.h"
#import "UIButtonWithTouchInfo.h"

@interface MSVViewController () <UIButtonWithTouchInfoProtocol>

@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (weak, nonatomic) IBOutlet UILabel *counterLabel;
@property (weak, nonatomic) IBOutlet UIButtonWithTouchInfo *buttonWithInfoView;

@end

@implementation MSVViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.buttonWithInfoView.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonWithInfoAction:(UIButtonWithTouchInfo *)button {
    CGPoint pointPart = button.touchPart;
    NSLog(@"(%f,%f)", pointPart.x, pointPart.y);
    if (pointPart.y < 0.2) {
        self.counterLabel.text= @"1";
    } else if (pointPart.y > 0.8) {
        self.counterLabel.text= @"100";
    } else if (pointPart.x < 0.5) {
        int cnt = (int)[self.counterLabel.text integerValue];
        cnt--;
        if (cnt < 1)
            cnt = 100;
        self.counterLabel.text = [NSString stringWithFormat:@"%d", cnt];
    } else if (pointPart.x > 0.5) {
        int cnt = (int)[self.counterLabel.text integerValue];
        cnt++;
        if (cnt > 100)
            cnt = 1;
        self.counterLabel.text = [NSString stringWithFormat:@"%d", cnt];
    }
}

- (void)UIButtonWithTouchInfo:(UIButtonWithTouchInfo *)uiButtonWithTouchInfo didTouchAction:(UIButtonWithTouchInfoAction)action {
    
    NSLog(@"Action: %d", action);
    CGPoint point = uiButtonWithTouchInfo.touchPointCurrent;
    NSLog(@"(%f,%f)", point.x, point.y);
    CGPoint point2 = uiButtonWithTouchInfo.touchPartCurrent;
    NSLog(@"(%f,%f)", point2.x, point2.y);
    
    self.infoLabel.text = [NSString stringWithFormat:@" XY: (%0.f,%0.f) norm: (%0.2f,%0.2f)", point.x, point.y, point2.x, point2.y];
}

@end
