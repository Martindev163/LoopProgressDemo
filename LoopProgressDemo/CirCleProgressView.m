//
//  CirCleProgressView.m
//  CircleProgressDemo
//
//  Created by 马浩哲 on 16/6/18.
//  Copyright © 2016年 junanxin. All rights reserved.
//

#import "CirCleProgressView.h"

@interface CirCleProgressView()

{
    CGSize _viewSize;
    CGPoint _center;
    CGFloat _radius;
    CGFloat _tempPersentage;
}

@property (nonatomic, strong) CAShapeLayer *myLayer;
@end
@implementation CirCleProgressView


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.percentage = 0.0;
        self.backgroundColor = [UIColor whiteColor];
        _viewSize = self.bounds.size;
        _center = CGPointMake(_viewSize.width/2.0, _viewSize.height/2.0);
        _radius = _viewSize.width/2.0;
//        [self setNeedsDisplay];
        [self setMyProView];
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    //最外圈灰色圆圈
    CGContextAddArc(contextRef, _center.x,_center.y , _radius, 0, 2*M_PI, 0);
    CGContextSetFillColorWithColor(contextRef, [UIColor colorWithRed:249/255.0 green:249/255.0 blue:249/255.0 alpha:1].CGColor);
    CGContextDrawPath(contextRef, kCGPathFill);
    CGContextStrokePath(contextRef);
    
    //中间白色圆圈
    CGContextAddArc(contextRef, _center.x, _center.y, _radius-8, 0, 2*M_PI, 0);
    CGContextSetFillColorWithColor(contextRef, [UIColor whiteColor].CGColor);
    CGContextDrawPath(contextRef, kCGPathFill);
    CGContextStrokePath(contextRef);
    //中间进度条圆圈
//    CGContextBeginPath(contextRef);
//    CGContextMoveToPoint(contextRef, center.x, center.y);
//    CGContextAddArc(contextRef, center.x, center.y, radius-8, -M_PI_2, 2*M_PI*_percentage-M_PI_2, 0);
//    CGContextSetFillColorWithColor(contextRef, [UIColor colorWithRed:213/255.0 green:69/255.0 blue:66/255.0 alpha:1].CGColor);
//    CGContextFillPath(contextRef);
    //内侧蛋黄色圆圈
    CGContextAddArc(contextRef, _center.x, _center.y, _radius-12, 0, 2*M_PI, 0);
    CGContextSetFillColorWithColor(contextRef, [UIColor colorWithRed:255/255.0 green:244/255.0 blue:225/255.0 alpha:1].CGColor);
    CGContextDrawPath(contextRef, kCGPathFill);
    CGContextStrokePath(contextRef);
    CGContextClosePath(contextRef);
    //进度起始位置的圆圈
    CGContextAddArc(contextRef, _center.x, 10, 3, 0, 2*M_PI, 0);
    CGContextSetFillColorWithColor(contextRef, [UIColor colorWithRed:213/255.0 green:69/255.0 blue:66/255.0 alpha:1].CGColor);
    CGContextDrawPath(contextRef, kCGPathFill);
    CGContextStrokePath(contextRef);
    CGContextClosePath(contextRef);
}
//设置当前进度
-(void)setPercentage:(CGFloat)percentage
{
    _percentage = percentage;
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 1.5;
    pathAnimation.fromValue = [NSNumber numberWithFloat:_tempPersentage];
    pathAnimation.toValue = [NSNumber numberWithFloat:percentage];
    [_myLayer addAnimation:pathAnimation forKey:nil];
    self.myLayer.strokeEnd = percentage;
    _tempPersentage = percentage;
}
//设置环形进度条
-(void)setMyProView
{
    NSLog(@"%f",(_radius-8));
    // 贝塞尔曲线(创建一个圆)
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(_center.x, _center.y)
                                                        radius:(_radius-10)
                                                    startAngle:-M_PI_2
                                                      endAngle:M_PI_2 * 3
                                                     clockwise:YES];
    
    // 创建一个shapeLayer
    _myLayer = [CAShapeLayer layer];
    _myLayer.frame         = self.bounds;
    _myLayer.strokeColor   = [UIColor colorWithRed:213/255.0 green:69/255.0 blue:66/255.0 alpha:1].CGColor;   // 边缘线的颜色
    _myLayer.fillColor     = [UIColor clearColor].CGColor;   // 闭环填充的颜色
    _myLayer.lineCap       = kCALineCapSquare;               // 边缘线的类型
    _myLayer.path          = path.CGPath;                    // 从贝塞尔曲线获取到形状
    _myLayer.lineWidth     = 4.0f;                           // 线条宽度
    _myLayer.strokeStart   = 0.0f;
    _myLayer.strokeEnd     = 0.0f;
    _myLayer.lineCap = kCALineCapRound;
    // 将layer添加进图层
    [self.layer addSublayer:_myLayer];
}

@end
