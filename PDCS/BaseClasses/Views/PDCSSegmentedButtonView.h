//
//  PDCSSegmentedButtonView.h
//  PDCS
//
//  Created by iMac on 2017/10/21.
//  Copyright © 2017年 iMac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageBtn.h"

@interface PDCSSegmentedButtonView : UIView

@property(nonatomic,copy)btnClickBlock clickBlock;

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles;
- (void)setTitles:(NSArray *)titles;
@end
