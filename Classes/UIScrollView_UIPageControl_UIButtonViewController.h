//
//  UIScrollView_UIPageControl_UIButtonViewController.h
//  UIScrollView_UIPageControl_UIButton
//
//  Created by Pramod Kumar Pranav on 5/2/13.
//  Copyright (c) 2013 AppStudioz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView_UIPageControl_UIButtonViewController : UIViewController<UIScrollViewDelegate>{
    BOOL pageControlUsed;
    int scrollMove;
}
@property (retain, nonatomic) IBOutlet UIScrollView *myScrollView;
@property (retain, nonatomic) IBOutlet UIPageControl *pageControl;
@property (retain, nonatomic) IBOutlet UIButton *btnPrevious;
@property (retain, nonatomic) IBOutlet UIButton *btnNext;
@property (nonatomic, retain)  NSArray *myColors;

- (IBAction)pageChange:(id)sender;
- (IBAction)prevMove:(id)sender;
- (IBAction)nextMove:(id)sender;

@end
