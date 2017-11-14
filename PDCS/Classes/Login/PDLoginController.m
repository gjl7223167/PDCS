//
//  PDLoginController.m
//  PDCS
//
//  Created by iMac on 2017/9/21.
//  Copyright © 2017年 iMac. All rights reserved.
//

#import "PDLoginController.h"
#import "LCMD5Tool.h"
#import "MyTabbar.h"


#import "AppDelegate.h"

@interface PDLoginController ()<UITextFieldDelegate>
{
    NSString * nameStr,*passWordStr,*validationStr;
}
@property (weak, nonatomic) IBOutlet UIImageView *backImage;

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;

@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@property (weak, nonatomic) IBOutlet UITextField *validationTextField;

@property (weak, nonatomic) IBOutlet UIButton *logBtn;




@end

@implementation PDLoginController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _logBtn.layer.masksToBounds = YES;
    _logBtn.layer.cornerRadius = 5.0;
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self initImgView];
}

- (void)initImgView
{
    CGSize vSize = self.contentView.size;
    CGRect iFrame = CGRectMake(0, 0, vSize.width, vSize.height);
    if ([PDUtils getIOSVersion] < 7.0) {
        iFrame.origin.y = -20;
        iFrame.size.height += 20;
    }
    
    NSString* imgName = @"750-1334.png";
    if (IS_IPHONE_4_OR_LESS) {
        imgName = @"640-960";
    }else if(IS_IPHONE_5){
        imgName = @"640-1136";
    }else if (IS_IPHONE_6P){
        imgName = @"1242-2208";
    }
    
    UIImage* image = [UIImage imageNamed:imgName];
    _backImage.image = image;
    _backImage.contentMode = UIViewContentModeScaleAspectFill;
    [self.view sendSubviewToBack:self.contentView];
    
}


-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{

    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{

}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == _nameTextField) {
        nameStr = textField.text;
    }else if (textField == _passwordTextField){
        passWordStr = textField.text;
    }else if (textField == _validationTextField){
        validationStr = textField.text;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clickLogBtn:(id)sender {
    

   NSString * pormpt = [LoginModel logWithInfoName:nameStr PassWord:passWordStr Validation:validationStr];
    if (pormpt) {
         [PXAlertView showAlertWithTitle:pormpt];
    }else{
        //        [dic setValue:nameStr forKey:@"DEVICE_ID"];
        //        [dic setValue:passWordStr forKey:@"USER_PSW"];
        
        //        NSString * stringMD = [LCMD5Tool MD5ForUpper32Bate:@"123123123"];
        //        [dic setValue:stringMD forKey:@"USER_PSW"];
        
        //        NSString* uuid = [PDUtils uidStringForDevice];
        //        [dic setValue:uuid forKey:@"DEVICE_ID"];
        
        NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
        [dic setValue:DEV_TYPE forKey:@"DEV_TYPE"];
        [dic setValue:@"heyi001" forKey:@"USER_ID"];
        [dic setValue:@"123123123" forKey:@"DEVICE_ID"];
        [dic setValue:@"E10ADC3949BA59ABBE56E057F20F883E" forKey:@"USER_PSW"];
        
        [NetTool post:PDLoginUrl params:dic success:^(id JSON) {
            
            [kUserDefault setBool:YES forKey:KIsFirstUse];
            UserModel * model = [[UserModel alloc] initWithDataModel:JSON];
            [[UserModelTool sharedUserModelTool] storgaeObject:model];
            
            MyTabbar* tabar = [MyTabbar sharedMyTabbar];
            [self curtainRevealViewController:tabar.tabbarController];
        } failure:^(NetError *error) {
            
            [SVProgressHUD showImage:nil status:error.errStr];
            
        }];
        
    }
 
}

- (void)curtainRevealViewController:(UIViewController *)viewControllerToReveal
{
    AppDelegate *appDelegate = [AppDelegate getAppDelegate];
    appDelegate.window.rootViewController = viewControllerToReveal;
}


- (IBAction)forgetPassBtn:(id)sender {
    
}



@end
