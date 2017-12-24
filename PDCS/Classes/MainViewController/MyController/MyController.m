//
//  MyController.m
//  PDCS
//
//  Created by iMac on 2017/9/21.
//  Copyright © 2017年 iMac. All rights reserved.
//

#import "MyController.h"
#import "PDUserHDView.h"
#import "PDUserCell.h"

#import "PDNavigationController.h"
#import "PDLoginViewController.h"

@interface MyController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property(nonatomic,strong)UITableView * myTableView;
@property(nonatomic,strong)PDUserHDView * topHeader;
@property (nonatomic, strong)NSMutableArray*        headerViews;

@property (nonatomic,strong) NSArray * dataArray;

@end

@implementation MyController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

-(void)rightBarUISet{
    UIButton *  rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setFrame:CGRectMake(0, 0, 40,40)];
    [rightBtn addTarget:self action:@selector(rightBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.titleLabel.font = [PDUtils appFontWithSize:14];
 
    [rightBtn setTitleColor:KCurrColor forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
}
-(void)rightBtnClicked:(UIButton*)button{
    
}


- (void)initView
{
    [self initHeaderViews];
    CGSize vSize                = self.view.size;
    _myTableView                = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, vSize.height - kTabbarH) style:UITableViewStylePlain];
    _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _myTableView.dataSource     = self;
    _myTableView.delegate       = self;
    _myTableView.backgroundColor= [UIColor clearColor];
    [self.view addSubview:_myTableView];
    _topHeader                  = [[PDUserHDView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 120)];
    WEAKSELF
    _topHeader.btnClickBlock    = ^(NSInteger cTag){
        [weakSelf dealCtrlClickWith:cTag];
    };
    [_topHeader upLoadViewInfo];
    _topHeader.backgroundColor = [UIColor whiteColor];
    _myTableView.tableHeaderView = _topHeader;
    [self addHeader];
    //    header = [CExpandHeader expandWithScrollView:_myTableView expandView:_topHeader];
    
    UserModel * userModel = [[UserModelTool sharedUserModelTool] readMessageObject];
    NSDictionary * dic = userModel.userDictionary;
    self.dataArray = @[
                       @{@"title":@"用户编号",@"value":dic[@"USER_ID"]},
                       @{@"title":@"用户姓名",@"value":dic[@"NAME_CN"]},
                       @{@"title":@"用户性别",@"value":dic[@"USER_SEX"]},
                       @{@"title":@"所属机构",@"value":dic[@"ORG_NAME"]},
                       @{@"title":@"用户类型",@"value":dic[@"USER_TYP_NAME"]},
                       @{@"title":@"用户职位",@"value":dic[@"USER_PRIVILEGE_NAME"]},
                       @{@"title":@"电子邮箱",@"value":dic[@"USER_EMAIL"]},
                       @{@"title":@"电话号码",@"value":dic[@"USER_TEL"]},
                       @{@"title":@"住址",@"value":dic[@"USER_ADDR"]},
                       @{@"title":@"备注",@"value":dic[@"COMM"]}
                     ];
}
- (void)addHeader
{
    WEAKSELF
    // 添加下拉刷新头部控件
    self.myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (!_isLogin) {
            [weakSelf.myTableView.mj_header endRefreshing];
            return;
        }
        [self getUserInfo];
        [weakSelf.myTableView.mj_header beginRefreshing];
    }];
}

#pragma maek TableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
  
    if (section == 0){
        return 1;
    }
        return KSecHeight;
    
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    UIView * view = nil;
    if (section == 0){
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWIDTH, 1)];
    }else{
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWIDTH, 10)];
    }
    
    view.backgroundColor = kViewBgColor;
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [PDUserCell cellHeight];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString* cellIndentifer = @"indentifier";
    PDUserCell * cell= [tableView dequeueReusableCellWithIdentifier:cellIndentifer];
    if (cell == nil) {
        cell = [[PDUserCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifer];
    }
    NSDictionary * dic = self.dataArray[indexPath.row];
    [cell updateCellInfoWith:dic[@"title"] andText:dic[@"value"]];
    
    return cell;
}

- (void)initHeaderViews
{

    _headerViews = [[NSMutableArray alloc]initWithCapacity:3];
    for (NSInteger i = 0; i < 11; i++) {
        UIView* view = [UIView new];
        view.backgroundColor = [UIColor clearColor];
        [_headerViews addObject:view];
    }
}

- (void)getUserInfo{

    UserModel * userModel = [[UserModelTool sharedUserModelTool] readMessageObject];
    NSDictionary* dic =@{@"USER_ID":userModel.USER_ID};
    MJWeakSelf;
    [NetTool post:PDCR_QueryUserInfo_URL params:dic success:^(id JSON) {
        UserModel * model = [[UserModel alloc] initWithDataModel:JSON];
        [[UserModelTool sharedUserModelTool] storgaeObject:model];
        [weakSelf.myTableView.mj_header endRefreshing];
    } failure:^(NetError *error) {
        [SVProgressHUD showImage:nil status:error.errStr];
         [weakSelf.myTableView.mj_header endRefreshing];
    }];
}

- (void)dealCtrlClickWith:(NSInteger)cTag{

    //选择是打开相机还是打开相册
    UIActionSheet * choose_picture = [[UIActionSheet alloc]initWithTitle:@"请选择图像" delegate:self cancelButtonTitle:nil
                                                  destructiveButtonTitle:@"返回"
                                                       otherButtonTitles:@"拍照", @"从相册里选择",nil];
    [choose_picture showInView:self.view];
    
//    [kUserDefault setBool:NO forKey:KIsFirstUse];
//    PDLoginViewController* aVc = [[PDLoginViewController alloc]init];
//    PDNavigationController *navi=[[PDNavigationController alloc]initWithRootViewController:aVc];
//    UIWindow *window = [UIApplication sharedApplication].keyWindow;
//    window.rootViewController = navi;
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    switch (buttonIndex) {
        case 1:
        {
            //打开相机
            UIImagePickerController *icon_picture = [[UIImagePickerController alloc] init];
            icon_picture.sourceType = UIImagePickerControllerSourceTypeCamera;
            icon_picture.delegate = self;
            [self presentViewController:icon_picture animated:YES completion:nil];
        }
            break;
        case 2:
        {
            //打开图库
            UIImagePickerController *icon_picture = [[UIImagePickerController alloc] init];
            icon_picture.title = @"";
            icon_picture.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            icon_picture.delegate = self;
            [self presentViewController:icon_picture animated:YES completion:nil];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark imagepicker delegate
/**
 *  图库代理方法
 *
 *  @param picker 要销毁picker
 *  @param info   传回的图片
 */
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{
    }];
    UIImage *portraitImg = info[UIImagePickerControllerOriginalImage];
//    PDCEditUserInfoUrl
    NSData * data = UIImageJPEGRepresentation(portraitImg, 0.5);
    NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    UserModel * userModel = [[UserModelTool sharedUserModelTool] readMessageObject];
    
    if (encodedImageStr){
        NSDictionary * par = @{@"USER_ID":userModel.USER_ID,@"HEAD_IMG":encodedImageStr};
        [NetTool post:PDCEditUserInfoUrl params:par success:^(id JSON) {
            NSLog(@"%@",JSON);
            userModel.HEAD_IMG_INFO = encodedImageStr;
            [_topHeader upLoadViewInfo];
        } failure:^(NetError *error) {
            NSLog(@"%@",error);
        }];
    }
}



#pragma mark image scale utility
- (UIImage *)imageByScalingToMaxSize:(UIImage *)sourceImage {
    if (sourceImage.size.width < 640.0f) return sourceImage;
    CGFloat btWidth = 0.0f;
    CGFloat btHeight = 0.0f;
    if (sourceImage.size.width > sourceImage.size.height) {
        btHeight = 640.0f;
        btWidth = sourceImage.size.width * (640.0f / sourceImage.size.height);
    } else {
        btWidth = 640.0f;
        btHeight = sourceImage.size.height * (640.0f / sourceImage.size.width);
    }
    CGSize targetSize = CGSizeMake(btWidth, btHeight);
    return [self imageByScalingAndCroppingForSourceImage:sourceImage targetSize:targetSize];
}

- (UIImage *)imageByScalingAndCroppingForSourceImage:(UIImage *)sourceImage targetSize:(CGSize)targetSize {
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else
            if (widthFactor < heightFactor)
            {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            }
    }
    UIGraphicsBeginImageContext(targetSize); // this will crop
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil) NSLog(@"could not scale image");
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
}



-(void)setIsLogin:(BOOL)isLogin{
    if (_isLogin != isLogin){
        _isLogin = isLogin;
    }
}

@end
