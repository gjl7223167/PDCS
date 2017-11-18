//
//  HBSglLabCell.m
//  besttravel
//
//  Created by iOS on 16/4/10.
//  Copyright © 2016年 第一出行. All rights reserved.
//

#import "HBSglLabCell.h"

@interface HBSglLabCell()

@property (nonatomic, strong)UILabel*   lab;

@end

@implementation HBSglLabCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self initCellView];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView setBackgroundColor:[UIColor clearColor]];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)initCellView
{
    CGFloat cHeight = [HBSglLabCell cellHeight];
    _lab = [PDUtils createLabel:@"nihao" with:KTMainTClr frame: CGRectMake(0, 0, SCREEN_WIDTH - KEdgeGap*4, cHeight) with:14];
    _lab.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_lab];
    
    UIView* btmLine = [[UIView alloc]initWithFrame:CGRectMake(0, cHeight - KDfltBdWidth, SCREEN_WIDTH - KEdgeGap * 4, KDfltBdWidth)];
    btmLine.backgroundColor = kDefaultLineColor;
    [self.contentView addSubview:btmLine];
}

- (void)updateCellWith:(NSString*)tStr isCurr:(BOOL)isCurr
{
    _lab.text = tStr;
    if (isCurr) {
        _lab.backgroundColor    = KCurrColor;
        _lab.textColor          = [UIColor whiteColor];
    }else{
        _lab.backgroundColor    = [UIColor clearColor];
        _lab.textColor          = KTMainTClr;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

+ (CGFloat)cellHeight
{
    return 35.0f;
}

@end
