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
- (void)sponsor:(NSString *)data SelectTime:(NSString *)method;
@end

@interface ALQoteUIwebView() <UIWebViewDelegate,JSObjcDelegate,HooDatePickerDelegate>
@property(nonatomic,strong)UIWebView * myWebView;
@property (nonatomic, strong) JSContext *jsContext;

@property (nonatomic,copy) NSString  * urlString;
@property (nonatomic,copy) NSString * JSString;

@property (nonatomic,strong)HooDatePicker * datePicker;
//js 调用
@property (nonatomic,strong)NSMutableDictionary * webDic;
@property (nonatomic,strong)NSString * methodStr;
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


-(void)webViewDidStartLoad:(UIWebView *)webView
{
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.jsContext = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    self.jsContext[@"aPPIOS"] = self;
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"didFailLoadWithError");
}

#pragma mark -JSContext-

//将对象指向自身后，如果调用 tianbai.getCall(callInfo) 会响应下面的方法，OC方法中仅调用JavaScript中的alerCallback方法

/**
 <#Description#>
 @param data 时间
 @param method 携带方法名
 例  Get:时间__{"RATE_LLZL":"01005","TimeValue":"2016-07-14"} APPOutSponsorSelectTime
 */
- (void)sponsor:(NSString *)data SelectTime:(NSString *)method{
    NSLog(@"Get:时间__%@方法名字__%@",data, method);
    NSData *jsonData = [data dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSMutableDictionary * tempDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    self.methodStr = method;
    self.webDic = tempDic;
    [self performSelectorOnMainThread:@selector(showDateView:) withObject:tempDic waitUntilDone:NO];
}

-(void)showDateView:(NSDictionary *)dic{
    self.datePicker = [[HooDatePicker alloc] initWithSuperView:[PDUtility windowsWithTopVC]];
    self.datePicker.delegate = self;
    NSString * dateStr = [dic objectForKey:@"TimeValue"];
    self.datePicker.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    if (dateStr.length > 8) {
        self.datePicker.datePickerMode = HooDatePickerModeDate;
    }else{
        self.datePicker.datePickerMode = HooDatePickerModeYearAndMonth;
    }
    NSDateFormatter *dateFormatter = [NSDate shareDateFormatter];
    [dateFormatter setDateFormat:kDateFormatYYYYMMDD];
    NSDate *maxDate = [NSDate date];
    NSDate *minDate = [dateFormatter dateFromString:[dic objectForKey:@"TimeValue"]];
    
    [self.datePicker setDate:[NSDate date] animated:YES];
    self.datePicker.minimumDate = minDate;
    self.datePicker.maximumDate = maxDate;
    [self.datePicker show];
}


- (void)datePicker:(HooDatePicker *)datePicker didSelectedDate:(NSDate*)date {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[NSLocale localeWithLocaleIdentifier:@"zh_CN"]];
    
    if (datePicker.datePickerMode == HooDatePickerModeDate) {
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    } else if (datePicker.datePickerMode == HooDatePickerModeTime) {
        [dateFormatter setDateFormat:@"HH:mm:ss"];
    } else if (datePicker.datePickerMode == HooDatePickerModeYearAndMonth){
        [dateFormatter setDateFormat:@"yyyy-MM"];
    } else {
        [dateFormatter setDateFormat:@"dd MMMM yyyy HH:mm:ss"];
    }
    NSString *value = [dateFormatter stringFromDate:date];
    
    [self.webDic setObject:value forKey:@"TimeValue"];
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self.webDic options:NSJSONWritingPrettyPrinted error:nil];
    NSString * str = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    NSString * loadUrl = [NSString stringWithFormat:@"%@(""%@"")",self.methodStr,str];
    [self.myWebView stringByEvaluatingJavaScriptFromString:loadUrl];

}

@end
