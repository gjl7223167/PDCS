//
//  DLQuoteWebView.m
//  PDCS
//
//  Created by gyc on 2017/11/18.
//  Copyright © 2017年 iMac. All rights reserved.
//

#import "DLQuoteWebView.h"


@interface DLQuoteWebView()<WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler>{
 
}

@property (nonatomic,copy) NSString  * urlString;

@property (nonatomic,copy) NSString * JSString;

@property (nonatomic,weak) UIViewController * weakVC;

@end

@implementation DLQuoteWebView

-(instancetype)initWithFrame:(CGRect)frame configuration:(WKWebViewConfiguration *)con VC:(UIViewController *)vc{
    self = [super initWithFrame:frame];
    if (self){
    
        self.weakVC = vc;
        [self viewUISet:con];
    }
    return self;
}

-(void)viewUISet:(WKWebViewConfiguration*)con{
    if (con){
        self.webView = [[WKWebView alloc] initWithFrame:self.bounds configuration:con];
    }else{
        self.webView = [[WKWebView alloc] initWithFrame:self.bounds];
    }
    
    self.webView.UIDelegate = self;
    self.webView.navigationDelegate = self;
    [self addSubview:self.webView];
}

-(void)requestURL:(NSString *)string JSString:(NSString *)jsStr{
    self.JSString = jsStr;
    if ([NSString isStringEmpty:self.urlString]){
        self.urlString = string;
        NSURL * urlStr= [NSURL URLWithString:string];
        NSURLRequest * request = [NSURLRequest requestWithURL:urlStr];
        [self.webView loadRequest:request];
        
    }else{
        NSURL * urlStr= [NSURL URLWithString:string];
        NSURLRequest * request = [NSURLRequest requestWithURL:urlStr];
        [self.webView loadRequest:request];
      
    }
}

-(void)requestJSString:(NSString *)jsStr{
    if ([self.JSString isEqualToString:jsStr]){
        return;
    }
    self.JSString = jsStr;
    [self.webView evaluateJavaScript:jsStr completionHandler:^(id obj, NSError * _Nullable error) {
        //                        NSLog(@"reuslt : %@",obj);
        //                        NSLog(@"reuslt error : %@",error);
    }];
}

/*WKNavigationDelegate 代理方法*/

/* 1.在发送请求之前，决定是否跳转  */
-(void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    decisionHandler(WKNavigationActionPolicyAllow);
}

/* 2.页面开始加载 */
-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
//    NSLog(@"开始加载");
}

/* 3.在收到服务器的响应头，根据response相关信息，决定是否跳转。 */
-(void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(nonnull WKNavigationResponse *)navigationResponse decisionHandler:(nonnull void (^)(WKNavigationResponsePolicy))decisionHandler{
    
    decisionHandler(WKNavigationResponsePolicyAllow);
    //    NSLog(@"在收到服务器的响应头，根据response相关信息，决定是否跳转");
}

/* 4.开始获取到网页内容时返回，需要注入JS，在这里添加 */
-(void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation{
//    NSLog(@"开始获取到网页内容时返回，需要注入JS，在这里添加");
}

/* 5.页面加载完成之后调用 */
-(void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation{

        UserModel * model = [[UserModelTool sharedUserModelTool] readMessageObject];
        NSString * stirn = [NSString stringWithFormat:@"APPSetLoginUser('%@','%@')",model.ROLE_ID,model.USER_ID];
        [self.webView evaluateJavaScript:stirn completionHandler:^(id obje, NSError * _Nullable error) {
                                    NSLog(@"%@",obje);
                                    NSLog(@"error : %@",error);
        }];
       
        [self.webView evaluateJavaScript:self.JSString completionHandler:^(id obj, NSError * _Nullable error) {
                        NSLog(@"reuslt : %@",obj);
                        NSLog(@"reuslt error : %@",error);
        }];
}

/* error - 页面加载失败时调用 */
-(void)webView:(WKWebView *)webView didFailLoadWithError:(nonnull NSError *)error{
//    NSLog(@"失败");
}

/* 其他 - 处理服务器重定向Redirect */
-(void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation{
    
}

/*WKUIDelegate 代理方法*/

/* 输入框，页面中有调用JS的 prompt 方法就会调用该方法 */
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString *result))completionHandler{
    
}

/* 确认框，页面中有调用JS的 confirm 方法就会调用该方法 */
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler{
    UIAlertController * vc = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(true);
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(false);
    }];
    
    [vc addAction:okAction];           // A
    [vc addAction:cancelAction];
    
    [self.weakVC presentViewController:vc animated:YES completion:nil];
}

/* 警告框，页面中有调用JS的 alert 方法就会调用该方法 */
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
//    UIAlertController * vc = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleActionSheet];
//
//    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
//    }];
//
//    [vc addAction:okAction];
//    [self.weakVC presentViewController:vc animated:YES completion:nil];
    
}

-(void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    
    
    
    if ([message.name isEqualToString:@"aPPIOS.sponsorSelectTime"]) {
        NSLog(@"时间时间时间");
    }
    
    
}



@end
