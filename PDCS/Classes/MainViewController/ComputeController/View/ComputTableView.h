//
//  ComputTableView.h
//  PDCS
//
//  Created by iMac on 2017/10/28.
//  Copyright © 2017年 iMac. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^CellDidClickBlock)(NSIndexPath * index);
@interface ComputTableView : UIView
@property(nonatomic,copy)CellDidClickBlock cellDidClickBlock;


- (instancetype)initWithFrame:(CGRect)frame InfoData:(id)info;

-(void)setInfoDate:(NSMutableDictionary *)dcit;

@end
