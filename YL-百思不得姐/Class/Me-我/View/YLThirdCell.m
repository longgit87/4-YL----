//
//  YLThirdCell.m
//  YL-百思不得姐
//
//  Created by 陈亚龙 on 15/9/8.
//  Copyright (c) 2015年 www.xm.com. All rights reserved.
//

#import "YLThirdCell.h"

@implementation YLThirdCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.accessoryView = [[UISwitch alloc]init];
        
        self.backgroundColor = [UIColor yellowColor];
        
    }

    return self;

}
@end
