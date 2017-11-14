//
//  PDViewController.h
//  PDCS
//
//  Created by iMac on 2017/9/19.
//  Copyright © 2017年 iMac. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface PDViewController : UIViewController

@property (nonatomic, strong)UIView*            contentView;

- (void)leftBtnClicked:(id)sender;
- (void)rightBtnClicked:(id)sender;
- (void)rightBtnTitleWith:(NSString*)tStr;
- (void)showRightBtn;
- (void)hiddenRightBtn;

- (void)rightBtnImgWith:(NSString*)imgName;

@end
