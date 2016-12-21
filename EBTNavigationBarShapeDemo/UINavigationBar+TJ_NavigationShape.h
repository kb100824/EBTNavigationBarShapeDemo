//
//  UINavigationBar+TJ_NavigationShape.h
//  EBTNavigationBarShapeDemo
//
//  Created by MJ on 2016/12/20.
//  Copyright © 2016年 com.csst.www. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,TJNavigationBarShapeTypeMode){
  
    TJNavigationBarShapeTypeMode_Wave = 1<<0,//水波曲线
    TJNavigationBarShapeTypeMode_Curve = 1<<1,//弧线
    TJNavigationBarShapeTypeMode_Zigzig = 1<<2 //锯齿形

};

@interface UINavigationBar (TJ_NavigationShape)
//水波
@property(nonatomic,strong,readonly) CAShapeLayer *waveShapeLayer;
//弧线
@property(nonatomic,strong,readonly) CAShapeLayer *curveShapeLayer;
//锯齿形
@property(nonatomic,strong,readonly) CAShapeLayer *zigZigShapeLayer;

/**
 * backGroundColor 导航栏背景颜色
 * attributeDictionary 导航栏字体设置
 * barShapeTypeMode  //导航栏形状样式
 */
- (void)navigationBarBackGroundColor:(UIColor *)backGroundColor titleTextAttribute:(NSDictionary *)attributeDictionary withNavigationBarShapeTypeMode:(TJNavigationBarShapeTypeMode)barShapeTypeMode;

/**
   移除动画
 */
- (void)stopRemoveShapelayerAnimation;
@end
