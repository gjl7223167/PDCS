//
//  ComputTableCell.h
//  PDCS
//
//  Created by iMac on 2017/10/28.
//  Copyright © 2017年 iMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ComputTableCell : UITableViewCell

-(void)setTitle:(NSString *)title AndDTitle:(NSString *)dTitle;
+(CGFloat )cellHeight;
@end
