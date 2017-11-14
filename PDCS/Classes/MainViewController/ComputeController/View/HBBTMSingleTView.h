//
//  HBBTMSingleTView.h
//  besttravel
//
//  Created by iOS on 16/4/8.
//  Copyright © 2016年 第一出行. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^itemSlctBlock)(NSInteger iIndex);

@interface HBBTMSingleTView : UIView

@property (nonatomic, strong)NSArray*       dataArray;
@property (nonatomic, assign)NSInteger      slctIndex;
@property (nonatomic, copy  )itemSlctBlock  iBlock;

- (void)show;

@end
