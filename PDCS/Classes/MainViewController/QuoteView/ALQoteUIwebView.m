//
//  ALQoteUIwebView.m
//  PDCS
//
//  Created by Long on 2018/6/17.
//  Copyright © 2018年 iMac. All rights reserved.
//

#import "ALQoteUIwebView.h"
#import <JavaScriptCore/JavaScriptCore.h>

@protocol JSObjcDelegate <JSExport>
//tianbai对象调用的JavaScript方法，必须声明！！！
- (void)aPPIOS;
- (void)sponsorSelectTime:(NSString *)callString;
- (void)sponsorSelectTime;
@end

@interface ALQoteUIwebView() <UIWebViewDelegate,JSObjcDelegate>
@property(nonatomic,strong)UIWebView * myWebView;
@property (nonatomic, strong) JSContext *jsContext;

@property (nonatomic,copy) NSString  * urlString;
@property (nonatomic,copy) NSString * JSString;
@end
@implementation ALQoteUIwebView


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        _myWebView = [[UIWebView alloc] initWithFrame:self.bounds];
        _myWebView.delegate = self;
        [self addSubview:_myWebView];
    }
    return self;
}


-(void)requestURL:(NSString *)string JSString:(NSString *)jsStr{
    self.JSString = jsStr;
    if ([NSString isStringEmpty:self.urlString]){
        self.urlString = string;
        NSURL * urlStr= [NSURL URLWithString:string];
        NSURLRequest * request = [NSURLRequest requestWithURL:urlStr];
        [self.myWebView loadRequest:request];
        
    }else{
        NSURL * urlStr= [NSURL URLWithString:string];
        NSURLRequest * request = [NSURLRequest requestWithURL:urlStr];
        [self.myWebView loadRequest:request];
    }
}


-(void)requestJSString:(NSString*)jsStr{
    if ([self.JSString isEqualToString:jsStr]){
        return;
    }
    self.JSString = jsStr;
    [_myWebView stringByEvaluatingJavaScriptFromString:jsStr];
}


#pragma mark ----------------------
#pragma mark UIWebViewDelegate

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog(@"request.URL.absoluteString  = %@",request.URL.absoluteString);
    
//    NSString *strM = request.URL.absoluteString;
//    if ([strM containsString:@"yinghang"]) {
//    }
    
//    if ([request.URL.scheme isEqualToString:@"gethtmlstring"]) {
//        NSString *htmlStr = @"321";
//        htmlStr = [htmlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
//        [webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"getHtmlString(\"%@\")",htmlStr]];
//    }
    return YES;
}


//1.开始加载网页的时候调用
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"webViewDidStartLoad");
}


//2.加载完成的时候调用
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"webViewDidFinishLoad");
    // 设置javaScriptContext上下文
    self.jsContext = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];

    //将tianbai对象指向自身
    self.jsContext[@"aPPIOS"] = self;

//    JSContext *context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
//    context[@"aPPIOS"] = self;

}


//3.加载失败的时候调用
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"didFailLoadWithError");
}


//将对象指向自身后，如果调用 tianbai.call() 会响应下面的方法，OC方法中调用js中的Callback方法，并传值
- (void)aPPIOS{
    NSLog(@"call");
    // 之后在回调JavaScript的方法Callback把内容传出去
    JSValue *Callback = self.jsContext[@"sponsorSelectTime"];
    //传值给web端
    [Callback callWithArguments:@[@"唤起本地OC回调完成"]];
}


#pragma mark -JSContext-

//将对象指向自身后，如果调用 tianbai.getCall(callInfo) 会响应下面的方法，OC方法中仅调用JavaScript中的alerCallback方法
- (void)sponsorSelectTime:(NSString *)callString{
    NSLog(@"Get:%@", callString);
    // 成功回调JavaScript的方法Callback
    JSValue *Callback = self.jsContext[@"sponsorSelectTime"];
    [Callback callWithArguments:nil];
}
- (void)sponsorSelectTime{
    NSLog(@"Get_____");
    // 成功回调JavaScript的方法Callback
    JSValue *Callback = self.jsContext[@"sponsorSelectTime"];
    [Callback callWithArguments:nil];
}


//将对象指向自身后，还可以向html注入js
- (void)alert{
    // 直接添加提示框
    NSString *str = @"alert('OC添加JS提示成功')";
    [self.jsContext evaluateScript:str];
}
@end
