//
//  UINavigationBar+TJ_NavigationShape.m
//  EBTNavigationBarShapeDemo
//
//  Created by MJ on 2016/12/20.
//  Copyright © 2016年 com.csst.www. All rights reserved.
//

#define kNavBackgroundColor [UIColor colorWithRed:0.894 green:0.271 blue:0.278 alpha:1.000]

//主屏宽
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
//主屏高
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#import <objc/runtime.h>
#import "UINavigationBar+TJ_NavigationShape.h"

static const void *waveShapeLayerKey = &waveShapeLayerKey;

static const void *curveShapeLayerKey = &curveShapeLayerKey;

static const void *zigZigShapeLayerKey = &zigZigShapeLayerKey;

static NSString *const KWaveShaperLayer_StrokeEnd = @"WaveShaperLayer_StrokeEnd";

static NSString *const KCurveShapeLayerLayer_StrokeEnd = @"CurveShapeLayerLayer_StrokeEnd";

static NSString *const KZigZigShaperLayer_StrokeEnd = @"ZigZigShaperLayer_StrokeEnd";


@implementation UINavigationBar (TJ_NavigationShape)


- (void)setWaveShapeLayer:(CAShapeLayer *)waveShapeLayer{

    objc_setAssociatedObject(self, waveShapeLayerKey, waveShapeLayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

}
- (CAShapeLayer *)waveShapeLayer{

    return  objc_getAssociatedObject(self, waveShapeLayerKey);

}

- (CAShapeLayer *)curveShapeLayer{

    return objc_getAssociatedObject(self, curveShapeLayerKey);
}
- (void)setCurveShapeLayer:(CAShapeLayer *)curveShapeLayer{
    
    objc_setAssociatedObject(self, curveShapeLayerKey, curveShapeLayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

}
- (CAShapeLayer *)zigZigShapeLayer{

    return  objc_getAssociatedObject(self, zigZigShapeLayerKey);
}

- (void)setZigZigShapeLayer:(CAShapeLayer *)zigZigShapeLayer{

    objc_setAssociatedObject(self, zigZigShapeLayerKey, zigZigShapeLayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)navigationBarBackGroundColor:(UIColor *)backGroundColor titleTextAttribute:(NSDictionary *)attributeDictionary withNavigationBarShapeTypeMode:(TJNavigationBarShapeTypeMode)barShapeTypeMode{
  
  
    if (!attributeDictionary.count) {
        [self setTitleTextAttributes:@{
                                       NSFontAttributeName:[UIFont systemFontOfSize:18.0],
                                       NSForegroundColorAttributeName:[UIColor whiteColor]
                                       }];
    }
    else{
        [self setTitleTextAttributes:attributeDictionary];
    }
    [self setBarTintColor:!backGroundColor?kNavBackgroundColor:backGroundColor];
    
    //去掉黑线
    [self setBackgroundImage:imageWithColor(!backGroundColor?kNavBackgroundColor:backGroundColor)
                                      forBarPosition:UIBarPositionAny
                                          barMetrics:UIBarMetricsDefault];
    
    [self setShadowImage:[[UIImage alloc] init]];
    switch (barShapeTypeMode) {
        case TJNavigationBarShapeTypeMode_Wave:
            [self navigationWaveShapeColor:!backGroundColor?kNavBackgroundColor:backGroundColor];
            break;
        case TJNavigationBarShapeTypeMode_Zigzig:
            [self navigationZigzigShapeColor:!backGroundColor?kNavBackgroundColor:backGroundColor];
            break;
        case TJNavigationBarShapeTypeMode_Curve:
            [self navigationCurveShapeColor:!backGroundColor?kNavBackgroundColor:backGroundColor];
            break;
        default:
            [self navigationCurveShapeColor:!backGroundColor?kNavBackgroundColor:backGroundColor];
            break;
    }
    
    

}
static inline UIImage* imageWithColor(UIColor * color){
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;

}
//- (UIImage *)imageWithColor:(UIColor *)color
//{
//    CGRect rect = CGRectMake(0, 0, 1, 1);
//    UIGraphicsBeginImageContext(rect.size);
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    
//    CGContextSetFillColorWithColor(context, [color CGColor]);
//    CGContextFillRect(context, rect);
//    
//    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    
//    return image;
//}

//水波曲线
- (void)navigationWaveShapeColor:(UIColor *)waveColor{

    UINavigationBar *navBar = self;
    self.waveShapeLayer = [CAShapeLayer layer];
    UIBezierPath *wavePath = [UIBezierPath bezierPath];
    
    CGFloat width = SCREEN_WIDTH;
    CGFloat height = 64;
    
    [wavePath moveToPoint:CGPointMake(0, 0)];
    [wavePath addLineToPoint:CGPointMake(0, height)];
    
    CGFloat cirCleSize = width/5.0;
    
    CGFloat x = 0;
    CGFloat y = height+(10/2);
    for (NSInteger i = 0; i<5; i++) {
        
        if (i%2==0) {
            if ((i+1)==cirCleSize) {
                [wavePath addQuadCurveToPoint:CGPointMake(x+cirCleSize, height) controlPoint:CGPointMake(x+cirCleSize/2, y+5)];
            }
            else{
                [wavePath addQuadCurveToPoint:CGPointMake(x+cirCleSize, y) controlPoint:CGPointMake(x+cirCleSize/2, y+5)];
                
            }
        }else{
            
            if ((i+1)==cirCleSize) {
                [wavePath addQuadCurveToPoint:CGPointMake(x+cirCleSize, height) controlPoint:CGPointMake(x+cirCleSize/2, y-5)];
            }
            else{
                [wavePath addQuadCurveToPoint:CGPointMake(x+cirCleSize, y) controlPoint:CGPointMake(x+cirCleSize/2, y-5)];
                
            }
            
        }
        x += cirCleSize;
        
    }
    
    [wavePath addLineToPoint:CGPointMake(width, 0)];
    self.waveShapeLayer.path = wavePath.CGPath;
     [wavePath closePath];
    self.waveShapeLayer.fillColor = [waveColor colorWithAlphaComponent:1].CGColor;
    self.waveShapeLayer.strokeColor = waveColor.CGColor;
    self.waveShapeLayer.borderWidth = 1;
    
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    basicAnimation.fromValue = @0;
    basicAnimation.toValue = @1.0;
    basicAnimation.repeatCount = MAXFLOAT;
    basicAnimation.duration = 1;
    basicAnimation.removedOnCompletion = NO;
    basicAnimation.fillMode=kCAFillModeRemoved;
    [self.waveShapeLayer addAnimation:basicAnimation forKey:KWaveShaperLayer_StrokeEnd];
    [[navBar.layer.sublayers objectAtIndex:0] insertSublayer:self.waveShapeLayer atIndex:0];
    


}
//锯齿
- (void)navigationZigzigShapeColor:(UIColor *)zigColor{
    UINavigationBar *navBar = self;
    self.zigZigShapeLayer = [CAShapeLayer layer];
    UIBezierPath *zigPath = [UIBezierPath bezierPath];
    CGFloat width = SCREEN_WIDTH;
    CGFloat height = 64;
    
    [zigPath moveToPoint:CGPointMake(0, 0)];
    [zigPath addLineToPoint:CGPointMake(0, height)];
    
    CGFloat cycleSizeHalf = (width/(5*1.0))/2.0;
    CGFloat x = 0;
    for (NSInteger i = 0; i<10; i++) {
        x+=cycleSizeHalf;
        [zigPath addLineToPoint:CGPointMake(x, height+10)];
        x=x+cycleSizeHalf;
         [zigPath addLineToPoint:CGPointMake(x, height)];
        
        
        
    }
     [zigPath addLineToPoint:CGPointMake(width, 0)];
    
    
    self.zigZigShapeLayer.path = zigPath.CGPath;
    [zigPath closePath];
    self.zigZigShapeLayer.fillColor = [zigColor colorWithAlphaComponent:1].CGColor;
    self.zigZigShapeLayer.strokeColor = zigColor.CGColor;
    self.zigZigShapeLayer.borderWidth = 1;

    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    basicAnimation.fromValue = @0;
    basicAnimation.toValue = @1.0;
    basicAnimation.repeatCount = MAXFLOAT;
    basicAnimation.duration = 1;
    basicAnimation.removedOnCompletion = NO;
    basicAnimation.fillMode=kCAFillModeRemoved;
    [self.zigZigShapeLayer addAnimation:basicAnimation forKey:KZigZigShaperLayer_StrokeEnd];
    [[navBar.layer.sublayers objectAtIndex:0] insertSublayer:self.zigZigShapeLayer atIndex:0];
    
    

}
//绘制弧线
- (void)navigationCurveShapeColor:(UIColor *)curveColor{
    UINavigationBar *navBar = self;
    self.curveShapeLayer = [CAShapeLayer layer];
    UIBezierPath *curvePath = [UIBezierPath bezierPath];
    CGFloat width = SCREEN_WIDTH;
    CGFloat height = 64;
    [curvePath moveToPoint:CGPointMake(0, height)];
    [curvePath addQuadCurveToPoint:CGPointMake(width, height) controlPoint:CGPointMake(SCREEN_WIDTH/2.0, 120)];
    self.curveShapeLayer.path = curvePath.CGPath;
    [curvePath closePath];
    self.curveShapeLayer.fillColor = [curveColor colorWithAlphaComponent:1].CGColor;
    self.curveShapeLayer.strokeColor = curveColor.CGColor;
    self.curveShapeLayer.borderWidth = 1;
    
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    basicAnimation.fromValue = @0;
    basicAnimation.toValue = @1;
    basicAnimation.repeatCount = MAXFLOAT;
    basicAnimation.duration = 1;
    basicAnimation.removedOnCompletion = NO;
    basicAnimation.fillMode=kCAFillModeRemoved;
    [self.curveShapeLayer addAnimation:basicAnimation forKey:KCurveShapeLayerLayer_StrokeEnd];
    [[navBar.layer.sublayers objectAtIndex:0] insertSublayer:self.curveShapeLayer atIndex:0];
  
    
}
- (void)stopRemoveShapelayerAnimation{
  
    if (self.waveShapeLayer) {
        [self.waveShapeLayer removeAnimationForKey:KWaveShaperLayer_StrokeEnd];
    }
    if (self.curveShapeLayer) {
        [self.curveShapeLayer removeAnimationForKey:KCurveShapeLayerLayer_StrokeEnd];
    }
    
    if (self.zigZigShapeLayer) {
        [self.zigZigShapeLayer removeAnimationForKey:KZigZigShaperLayer_StrokeEnd];
    }


}
@end
