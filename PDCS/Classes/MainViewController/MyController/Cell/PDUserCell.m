//
//  PDUserCell.m
//  PDCS
//
//  Created by iMac on 2017/9/24.
//  Copyright © 2017年 iMac. All rights reserved.
//

#import "PDUserCell.h"
@interface PDUserCell()
@property (nonatomic, strong)UIView*            topLineV;
@property (nonatomic, strong)UILabel*           fTextLab;
@property (nonatomic, strong)UILabel*           rTextLab;

@end

@implementation PDUserCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style  reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initCellwView];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView setBackgroundColor:[UIColor whiteColor]];
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}



-(void)initCellwView{
    CGFloat cellHeight = [PDUserCell cellHeight];
    
    _fTextLab           = [PDUtils createLabel:@"无聊的PDCS" with:KTMainTClr in:CGPointMake(KEdgeGap, 0) with:14];
    _fTextLab.x      = KEdgeGap;
    _fTextLab.centerY   = cellHeight / 2.0f;
    [self.contentView addSubview:_fTextLab];

    _rTextLab           = [PDUtils createNormalLabel:@"PDCS描述" with:KTContTClr frame:CGRectMake(_fTextLab.right + KEdgeGap, 0, SCREEN_WIDTH - _fTextLab.right - KEdgeGap * 2, cellHeight) with:13];
    _rTextLab.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_rTextLab];

    _topLineV = [[UIView alloc] initWithFrame:CGRectMake(KEdgeGap, cellHeight - kLineHeight, SCREEN_WIDTH - KEdgeGap * 2, kLineHeight)];
    _topLineV.backgroundColor = kLineColor;
    [self.contentView addSubview:_topLineV];
    
}

- (void)updateCellInfoWith:(NSString*)textName andText:(NSString*)tText{
    _fTextLab.text = textName;
    _rTextLab.text = tText;
}

+(CGFloat)cellHeight{
    return 54.0f;
}
@end
