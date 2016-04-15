//
//  CYMainCell.h
//  Controller Model CYLearnEnglish
//
//  Created by jeader on 16/4/14.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CYMainCell : UITableViewCell

/**
 *  单词名称
 */
@property (weak, nonatomic) IBOutlet UILabel *letterName;
/**
 *  单词释义
 */
@property (weak, nonatomic) IBOutlet UILabel *letterMean;


@end
