//
//  UIScrollView_UIPageControl_UIButtonViewController.m
//  UIScrollView_UIPageControl_UIButton
//
//  Created by Pramod Kumar Pranav on 5/2/13.
//  Copyright (c) 2013 AppStudioz. All rights reserved.
//

#import "UIScrollView_UIPageControl_UIButtonViewController.h"

@interface UIScrollView_UIPageControl_UIButtonViewController ()

@end

@implementation UIScrollView_UIPageControl_UIButtonViewController
@synthesize myScrollView;
@synthesize pageControl;
@synthesize btnPrevious,btnNext;
@synthesize myColors;

#pragma mark - View Life Cycle

- (void)viewDidLoad{
    [super viewDidLoad];
    pageControlUsed = NO;
    self.btnPrevious.enabled = FALSE;
    self.btnPrevious.hidden=YES;
    
	self.myColors = [NSArray arrayWithObjects:[UIColor grayColor], [UIColor redColor],[UIColor greenColor], [UIColor blueColor],[UIColor yellowColor], nil];
	for (int i = 0; i < self.myColors.count; i++) {
		CGRect frames;
		frames.origin.x = self.myScrollView.frame.size.width * i;
        frames.origin.y = 0;
		frames.size = self.myScrollView.frame.size;
		
		UIView *subviews = [[UIView alloc] initWithFrame:frames];
		subviews.backgroundColor = [self.myColors objectAtIndex:i];
		[self.myScrollView addSubview:subviews];
		[subviews release];
    }
	self.myScrollView.contentSize = CGSizeMake(self.myScrollView.frame.size.width * myColors.count, self.myScrollView.frame.size.height);
	self.pageControl.currentPage = 0;
	self.pageControl.numberOfPages = self.myColors.count;
    scrollMove=0;
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    [myScrollView release];
    [pageControl release];
    [btnPrevious release];
    [btnNext release];
    [super dealloc];
}
- (void)viewDidUnload {
	self.myScrollView = nil;
	self.pageControl = nil;
    self.myColors=nil;
    self.btnPrevious=nil;
    self.btnNext=nil;
}

#pragma mark - ScrollView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    
	if (!pageControlUsed) {
		// Switch the indicator when more than 50% of the previous/next page is visible
		CGFloat pageWidth = self.myScrollView.frame.size.width;
		int page = floor((self.myScrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
		self.pageControl.currentPage = page;
	}
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
	pageControlUsed = NO;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
	pageControlUsed = NO;
    
    scrollMove = scrollView.contentOffset.x / scrollView.frame.size.width;
    pageControl.currentPage=scrollMove;
    
    if(scrollMove <= 0){
        self.btnPrevious.enabled = FALSE;
        self.btnPrevious.hidden=YES;
        scrollMove = 0;
    }else{
        self.btnPrevious.enabled = TRUE;
        self.btnPrevious.hidden=NO;
    }
    
    if(scrollMove >= self.myColors.count-1){
        self.btnNext.enabled = FALSE;
        self.btnNext.hidden=YES;
        scrollMove = self.myColors.count-1;
    }else{
        self.btnNext.enabled = TRUE;
        self.btnNext.hidden=NO;
    }
}

#pragma mark - IBAction

- (IBAction)pageChange:(id)sender {
    // Update the scroll view to the appropriate page
	CGRect frames;
	frames.origin.x = self.myScrollView.frame.size.width * self.pageControl.currentPage;
	frames.origin.y = 0;
	frames.size = self.myScrollView.frame.size;
	[self.myScrollView scrollRectToVisible:frames animated:YES];
    pageControlUsed = YES;
    
    scrollMove=pageControl.currentPage;
    
    if(scrollMove <= 0){
        self.btnPrevious.enabled = FALSE;
        self.btnPrevious.hidden=YES;
        scrollMove = 0;
    }else{
        self.btnPrevious.enabled = TRUE;
        self.btnPrevious.hidden=NO;
    }
    
    if(scrollMove >= self.myColors.count-1){
        self.btnNext.enabled = FALSE;
        self.btnNext.hidden=YES;
        scrollMove = self.myColors.count-1;
    }else{
        self.btnNext.enabled = TRUE;
        self.btnNext.hidden=NO;
    }
}

- (IBAction)prevMove:(id)sender {
    self.btnNext.enabled = TRUE;
    self.btnNext.hidden=NO;
    scrollMove--;
    [self.myScrollView setContentOffset:CGPointMake(scrollMove*320, 0) animated:YES];
    pageControl.currentPage=scrollMove;
    
    if(scrollMove <= 0){
        self.btnPrevious.enabled = FALSE;
        self.btnPrevious.hidden=YES;
    }
}

- (IBAction)nextMove:(id)sender {
    self.btnPrevious.enabled = TRUE;
    self.btnPrevious.hidden=NO;
    scrollMove++;
    [self.myScrollView setContentOffset:CGPointMake(scrollMove*320, 0) animated:YES];
    pageControl.currentPage=scrollMove;
    
    if(scrollMove >= self.myColors.count-1){
        self.btnNext.enabled = FALSE;
        self.btnNext.hidden=YES;
    }
}

@end
