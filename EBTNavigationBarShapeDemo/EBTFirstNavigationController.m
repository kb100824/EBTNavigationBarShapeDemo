//
//  EBTFirstNavigationController.m
//  EBTNavigationBarShapeDemo
//
//  Created by MJ on 2016/12/20.
//  Copyright © 2016年 com.csst.www. All rights reserved.
//
#define kNavBackgroundColor [UIColor colorWithRed:0.894 green:0.271 blue:0.278 alpha:1.000]
#import "EBTFirstNavigationController.h"
#import "UINavigationBar+TJ_NavigationShape.h"
@interface EBTFirstNavigationController ()

@end

@implementation EBTFirstNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    

   

   
    [self.navigationBar navigationBarBackGroundColor:kNavBackgroundColor titleTextAttribute:nil withNavigationBarShapeTypeMode:TJNavigationBarShapeTypeMode_Curve];

//
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        
//        [self.navigationBar stopRemoveShapelayerAnimation];
//    });

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
