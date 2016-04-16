//
//  CYMainCell.m
//  Controller Model CYLearnEnglish
//
//  Created by jeader on 16/4/14.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "CYMainCell.h"

#import "Head.pch"

#define DeleteW 50

@interface CYMainCell ()

@property (nonatomic, strong) UIPanGestureRecognizer *panGestureRecognizer;

@end

@implementation CYMainCell

- (void)awakeFromNib {
    // Initialization code
    
    //创建拖拽手势
//    self.panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self
//                                                                        action:@selector(handlePanGestures:)];
//    //无论最大还是最小都只允许一个手指
//    self.panGestureRecognizer.minimumNumberOfTouches = 1;
//    self.panGestureRecognizer.maximumNumberOfTouches = 1;
//    [self addGestureRecognizer:self.panGestureRecognizer];
//
//    self.totalView.layer.zPosition = 2;
//    //创建删除按钮
//    UIButton *delete = [UIButton buttonWithType:UIButtonTypeCustom];
//    [delete setFrame:CGRectMake(Width-DeleteW, 0, DeleteW, self.bounds.size.height)];
//    [delete setBackgroundColor:[UIColor redColor]];
//    [self.contentView addSubview:delete];
    
}

//-(void)handlePanGestures:(UIPanGestureRecognizer *)gesture
//{
//    CGFloat tX = [gesture translationInView:gesture.view].x;
//    
//    
//    if (tX < 0 && self.totalView.x > -DeleteW) {
//        
//        self.totalView.x = tX;
//        // 代理方法
//    }
//    
//    if (gesture.state==UIGestureRecognizerStateEnded) {
//        
//        if (self.totalView.x>-DeleteW && self.totalView.x<0) {
//            
//            [UIView animateWithDuration:0.3 animations:^{
//                
//                self.totalView.x = -DeleteW;
//                
//            } completion:^(BOOL finished) {
//                
//            }];
//        }
//        
//    }
//    
//    if (tX > 0) {
//        
//        [UIView animateWithDuration:0.3 animations:^{
//            
//            self.totalView.x = 0;
//            
//        } completion:^(BOOL finished) {
//            
//        }];
//        
//    }
//    
//    
//}
//
//- (IBAction)clickDelete:(id)sender {
//    
//    UIButton *btn = (UIButton *)sender;
//    
//    CYLog(@"qqqqqqq%ld",(long)btn.tag);
//    
//    
//    
//}
//
//+(void)originalCell
//{
//    CYMainCell *cell = [[NSBundle mainBundle]loadNibNamed:@"CYMainCell" owner:nil options:nil][0];
//    CYLog(@"%@",cell);
//}


@end
