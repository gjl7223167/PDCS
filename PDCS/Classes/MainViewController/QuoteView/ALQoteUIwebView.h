//
//  ALQoteUIwebView.h
//  PDCS
//
//  Created by Long on 2018/6/17.
//  Copyright © 2018年 iMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ALQoteUIwebView : UIView
-(void)requestURL:(NSString*)string JSString:(NSString*)jsStr;

-(void)requestJSString:(NSString*)jsStr;
@end
