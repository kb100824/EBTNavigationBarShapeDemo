
#给导航栏添加自定义(水波 锯齿 弧线)的形状支持动画效果

#需要项目中的文件夹名称为"UINavigationBarShape"里面的类别文件添加到项目中并引用一下。

#导航栏样式目前只有三种如枚举中所示:

typedef NS_ENUM(NSInteger,TJNavigationBarShapeTypeMode){
  
    TJNavigationBarShapeTypeMode_Wave = 1<<0,//水波曲线

    TJNavigationBarShapeTypeMode_Curve = 1<<1,//弧线

    TJNavigationBarShapeTypeMode_Zigzig = 1<<2 //锯齿形

};

#具体操作方法请设置下面对应两个方法来达到实现效果

/**

 * backGroundColor 导航栏背景颜色

 * attributeDictionary 导航栏字体设置

 * barShapeTypeMode  //导航栏形状样式
 */


- (void)navigationBarBackGroundColor:(UIColor *)backGroundColor 
titleTextAttribute:(NSDictionary *)attributeDictionary 
withNavigationBarShapeTypeMode:(TJNavigationBarShapeTypeMode)barShapeTypeMode;


/**

   移除动画

 */


- (void)stopRemoveShapelayerAnimation;



#水波形状导航栏效果图 barShapeTypeMode = TJNavigationBarShapeTypeMode_Wave
![Image](https://github.com/KBvsMJ/EBTNavigationBarShapeDemo/blob/master/demoGif/1.gif)

#锯齿形状导航栏效果图 barShapeTypeMode = TJNavigationBarShapeTypeMode_Zigzig
![Image](https://github.com/KBvsMJ/EBTNavigationBarShapeDemo/blob/master/demoGif/2.gif)

#弧线形状导航栏效果图 barShapeTypeMode = TJNavigationBarShapeTypeMode_Curve
![Image](https://github.com/KBvsMJ/EBTNavigationBarShapeDemo/blob/master/demoGif/3.gif)
