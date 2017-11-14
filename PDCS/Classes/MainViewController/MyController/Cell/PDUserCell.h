//
//  PDUserCell.h
//  PDCS
//
//  Created by iMac on 2017/9/24.
//  Copyright © 2017年 iMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PDUserCell : UITableViewCell

- (void)updateCellInfoWith:(NSString*)textName andText:(NSString*)tText;
+(CGFloat)cellHeight;
@end
