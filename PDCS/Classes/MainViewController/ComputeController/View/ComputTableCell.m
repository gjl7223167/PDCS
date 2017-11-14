//
//  ComputTableCell.m
//  PDCS
//
//  Created by iMac on 2017/10/28.
//  Copyright © 2017年 iMac. All rights reserved.
//

#import "ComputTableCell.h"
@interface ComputTableCell()
{
    UILabel * lTLabel;
    UILabel * lDLabel;
    UIImageView * imageView;
}
@end

@implementation ComputTableCell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView setBackgroundColor:[UIColor whiteColor]];
        [self initCellView];
    }
    return self;
}

-(void)initCellView{
    CGFloat height = [ComputTableCell cellHeight];
    lTLabel = [PDUtils createLabel:@"业务模块" with:UIColorFromRGB(0x000000) in:CGPointMake(20,10) with:14.0f];
    [self.contentView addSubview:lTLabel];
    
    lDLabel = [PDUtils createLabel:@"请选择" with:UIColorFromRGB(0x9C9C9C) in:CGPointMake(20,lTLabel.bottom + 2) with:14];
    [self.contentView addSubview:lDLabel];
    
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 12, 12)];
    imageView.image = [UIImage imageNamed:@"dow_feather"];
    imageView.right = SCREEN_WIDTH - 20;
    imageView.centerY = height / 2;
    [self.contentView addSubview:imageView];
    
}


-(void)setTitle:(NSString *)title AndDTitle:(NSString *)dTitle{
    lTLabel.text = title;
    lDLabel.text = title;
}




+(CGFloat )cellHeight{
    return 60.0f;
}

@end
