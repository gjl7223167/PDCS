//
//  DLQuoteWebView.h
//  PDCS
//
//  Created by gyc on 2017/11/18.
//  Copyright © 2017年 iMac. All rights reserved.
//

#import <WebKit/WebKit.h>

@interface DLQuoteWebView : UIView

@property (nonatomic,strong) WKWebView * webView;

-(instancetype)initWithFrame:(CGRect)frame configuration:(WKWebViewConfiguration*)con VC:(UIViewController*)vc;

-(void)requestURL:(NSString*)string JSString:(NSString*)jsStr;

-(void)requestJSString:(NSString*)jsStr;

@end
