//
//  ProgressView.m
//  LoopProgressDemo
//
//  Created by 马浩哲 on 16/6/1.
//  Copyright © 2016年 junanxin. All rights reserved.
//

#import "ProgressView.h"

@interface ProgressView ()

@property (strong,nonatomic) UILabel *label;

@end

@implementation ProgressView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.percentage = 0.0;
        self.backgroundColor = [UIColor whiteColor];
        [self loadSubviews];
    }
    return self;
}

-(void)loadSubviews
{
    _label = [[UILabel alloc] initWithFrame:CGRectMake(10, self.frame.size.height/2 - 10, self.frame.size.width - 20, 20)];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.font = [UIFont systemFontOfSize:12];
    _label.textColor = [UIColor blackColor];
    _label.text = [NSString stringWithFormat:@"0.00%%"];
    [self addSubview:_label];
}

-(void)setPercentage:(CGFloat)percentage
{
    _percentage = percentage;
    _label.text = [NSString stringWithFormat:@"%.2f%%",_percentage*100];
    [self setNeedsDisplay];
}

-(void)drawRect:(CGRect)rect
{
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    CGSize viewSize = self.bounds.size;
    CGPoint center = CGPointMake(viewSize.width/2, viewSize.height/2);
    CGFloat radius = viewSize.width/2;
    CGContextBeginPath(contextRef);
    CGContextMoveToPoint(contextRef, center.x, center.y);
    CGContextAddArc(contextRef, center.x, center.y, radius, - M_PI_2, 2*M_PI*_percentage - M_PI_2, 0);
    CGContextSetFillColorWithColor(contextRef, [UIColor redColor].CGColor);
    CGContextFillPath(contextRef);
    
    //填充圆，无边框
    CGContextAddArc(contextRef, center.x, center.y, radius - 10, 0, 2*M_PI, 0); //添加一个圆
    CGContextSetFillColorWithColor(contextRef, [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1].CGColor);
    CGContextClosePath(contextRef);
    CGContextDrawPath(contextRef, kCGPathFill);//绘制填充
    CGContextStrokePath(contextRef);//绘画路径
}

@end
