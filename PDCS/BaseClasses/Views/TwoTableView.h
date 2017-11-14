//
//  TwoTableView.h
//  PDCS
//
//  Created by iMac on 2017/10/21.
//  Copyright © 2017年 iMac. All rights reserved.
//


#import <UIKit/UIKit.h>

/*
 number 编号
 dicStr 描述
 */
typedef void(^selectEndBlack)(NSString *number,NSString *dicStr,NSInteger selectIndex);

@interface TwoTableView : UIView<UITableViewDelegate,UITableViewDataSource>
{
    currentType cType;
}
@property(nonatomic,copy)selectEndBlack endBlack;
@property(nonatomic,copy)CancelBackBlock cancelBlock;


- (instancetype)initWithFrame:(CGRect)frame InfoData:(id)info CuurentType:(currentType)type;
-(void)updata:(id )infoDict AndType:(currentType)type;

@end
