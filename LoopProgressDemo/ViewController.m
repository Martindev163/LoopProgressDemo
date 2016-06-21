//
//  ViewController.m
//  LoopProgressDemo
//
//  Created by 马浩哲 on 16/6/1.
//  Copyright © 2016年 junanxin. All rights reserved.
//

#import "ViewController.h"
#import "ProgressView.h"
#import "CirCleProgressView.h"

@interface ViewController ()

@property (strong, nonatomic) UISlider *progressSlider;

@property (strong, nonatomic) ProgressView *progressView;

@property (strong, nonatomic) CirCleProgressView *SecondeProView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _progressView = [[ProgressView alloc] initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width/2 - 80, 100, 160, 160)];
    [self.view addSubview:_progressView];
    
    _SecondeProView = [[CirCleProgressView alloc] initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width/2 - 80, 280, 160, 160)];
    _SecondeProView.percentage = 0.8;
    [self.view addSubview:_SecondeProView];
    
    _progressSlider = [[UISlider alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-80, 500, 160, 10)];
    [_progressSlider addTarget:self action:@selector(sliderChange) forControlEvents:UIControlEventValueChanged];
    _progressSlider.maximumValue = 1.0;
    _progressSlider.minimumValue = 0.0;
    [self.view addSubview:_progressSlider];
    
}

-(void)sliderChange
{
    _progressView.percentage = _progressSlider.value;
}

@end
