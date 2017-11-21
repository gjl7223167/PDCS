//
//  HBSglLabCell.h
//  besttravel
//
//  Created by iOS on 16/4/10.
//  Copyright © 2016年 第一出行. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HBSglLabCell : UITableViewCell

- (void)updateCellWith:(NSString*)tStr isCurr:(BOOL)isCurr;
+ (CGFloat)cellHeight;

@end
