//
//  PDCSSegmentedButtonView.m
//  PDCS
//
//  Created by iMac on 2017/10/21.
//  Copyright © 2017年 iMac. All rights reserved.
//

#import "PDCSSegmentedButtonView.h"

@interface PDCSSegmentedButtonView()
{
    CGFloat labelWidht;
    CGFloat labelHeight;
    NSInteger titleNumber;
    NSInteger lastSelectNumber;
}
//标题数组
@property (nonatomic, copy) NSArray *titles;
@property (nonatomic,strong)NSMutableArray * btnArray;
@property (nonatomic, strong) UIView *shadeView;

@end

@implementation PDCSSegmentedButtonView

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles{
    if (self = [super initWithFrame:frame]) {
        
        [self initView];
        [self setTitles:titles];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self initView];
    }
    
    return self;
}

- (void)setTitles:(NSArray *)titles{
    _titles = titles;
    
    [self setSubViewWithTitles:titles];
}

- (void)initView{
    
    self.backgroundColor = kViewBgColor;
    self.clipsToBounds = YES;
    
    self.btnArray = [NSMutableArray arrayWithCapacity:5];
    
    [self setSubViewWithTitles:_titles];
}

-(void)setSubViewWithTitles:(NSArray *)titles{
    for(UIView *view in [self subviews])
    {
        [view removeFromSuperview];
    }
    
    [self.btnArray removeAllObjects];
    
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.height - 1, self.width,1)];
    lineView.backgroundColor = UIColorFromRGB(0xD4D4D4);
    [self addSubview:lineView];
    
    titleNumber = self.titles.count;
    labelWidht = (self.frame.size.width - (titleNumber - 1)) / titleNumber;
    labelHeight = self.frame.size.height;
    
    for (int i = 0; i < titleNumber; i ++) {
        ImageBtn * btnImage = [[ImageBtn alloc] initWithFrame:CGRectMake(i * (labelWidht + 1), 0, labelWidht, labelHeight - 1) Title:titles[i] Image:@"tab_down_bg"];
        btnImage.tag = 1000 + i;
        [btnImage addTarget:self action:@selector(clickBtnMethod:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnImage];
        UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(btnImage.right, 10, 1, labelHeight - 10*2)];
        lineView.backgroundColor = UIColorFromRGB(0xD4D4D4);
        [self addSubview:lineView];
        
        [self.btnArray addObject:btnImage];
    }
    
}

- (UILabel *)labelWithFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)textColor {
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:frame];
    titleLabel.text = text;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = textColor;
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont fontWithName:@"Helvetica" size:13];
    
    return titleLabel;
}

-(void)clickBtnMethod:(UIButton *)but{
    
    NSInteger tag = but.tag;
    if (self.clickBlock) {
        self.clickBlock(tag - 1000);
    }
    
    
    for (int i = 0; i < _btnArray.count; i++) {
        UIButton * button = _btnArray[i];
        if (button.tag == tag) {
            [button setSelected:YES];
        }else{
             [button setSelected:NO];
        }
    }

    
}

@end
