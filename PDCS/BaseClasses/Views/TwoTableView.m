//
//  TwoTableView.m
//  PDCS
//
//  Created by iMac on 2017/10/21.
//  Copyright © 2017年 iMac. All rights reserved.
//

#import "TwoTableView.h"

//#define VY kNaviBarH + SegmentedH
#define VY 0

@interface TwoTableView()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV1;
    UITableView *tableV2;
    
    NSInteger tableV2_row;
    
    UIView * bcView;
    
    
}
@property(nonatomic,strong)NSMutableArray * aryOnr;
@property(nonatomic,strong)NSMutableArray * aryTwo;
@property(nonatomic,strong)NSMutableDictionary * infoData;
@property(nonatomic,strong)NSArray * infoAry;
@end

@implementation TwoTableView

- (instancetype)initWithFrame:(CGRect)frame InfoData:(id)info CuurentType:(currentType )type{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView:info AndType:type];
    }
    return self;
}


-(void)updata:(id)infoDict AndType:(currentType)type{
     cType = type;
     [self initWithData:infoDict];
    [UIView animateWithDuration:0.2 animations:^{
        tableV1.width = self.width;
        tableV2.x     = self.width;
        tableV2.width = 0;
    }];
}

-(void)initView:(id)info AndType:(currentType)type{
    cType = type;
    self.backgroundColor = [kViewBgColor colorWithAlphaComponent:0.4];
    if (tableV1 == nil) {
        tableV1 = [[UITableView alloc]initWithFrame:CGRectMake(0,VY, self.width, AdaH(242)) style:UITableViewStylePlain];
        tableV1.delegate = self;
        tableV1.dataSource = self;
        [self addSubview:tableV1];
    }
    
    if (tableV2 == nil) {
        tableV2 = [[UITableView alloc]initWithFrame:CGRectMake(self.width, VY, 0, AdaH(242)) style:UITableViewStylePlain];
        tableV2.delegate = self;
        tableV2.dataSource = self;
        [self addSubview:tableV2];
    }

    [self initWithData:info];
}


-(void)initWithData:(id)infoDict{
    
    if (_aryOnr == nil) {
        _aryOnr = [[NSMutableArray alloc]init];
        _aryTwo = [[NSMutableArray alloc]init];
        _infoData = [[NSMutableDictionary alloc] init];
    }
    
    [self initData:infoDict];
    

}

-(void)initData:(id)info{
    switch (cType) {
            //挂牌利率//
        case selectGPZHtype:
        {
            NSArray * ary = info[@"LIST"];
            if (ary && ary.count > 0) {
                [_infoData setDictionary:info];
                _aryOnr = info[@"LIST"];
            }else{
                 [_aryOnr addObject:info];
            }
            
        }
        break;
        case selectGPZCtype:
        {
            [_aryOnr setArray:info];
        }
            break;
        case selectGPTYtype:
        {
            [_infoData setDictionary:info];
            [_aryOnr setArray:info[@"LIST"]];
        }
            break;
        case selectGPRMBtype:
        {
            [_aryOnr setArray:info[@"LIST"]];
        }
            break;
            //市场利率//
        case selectSCRENBCtype:
        {
            [_aryOnr setArray:info];
        }
            break;
        case selectSCQBFLtype:
        {
            [_aryOnr setArray:info];
        }
            break;
        case selectSCRMBtype:
        {
        }
            break;
            //FTP利率//
        case selectFTPQUFLtype:
        {
            [_aryOnr setArray:info];
        }
            break;
        case selectFTPRMBtype:
        {
            [_aryOnr setArray:info];
        }
            break;

        default:
            break;
    }
    if (_aryOnr.count > 5) {
        tableV1.height = AdaH(242);
        tableV2.height = AdaH(242);
    }else{
        tableV1.height = AdaH(_aryOnr.count * 40);
        tableV2.height = AdaH(_aryOnr.count * 40);
    }
    [tableV1 reloadData];
}


-(void)upView:(BOOL )up{
    CGFloat tabViewLeftWidth = 0.0;
    CGFloat tabViewRightWidth = 0.0;
    if (up) {
        tabViewLeftWidth = self.width/2;
        tabViewRightWidth = self.width/2;
    }else{
        tabViewLeftWidth = self.width;
        tabViewRightWidth = 0;
    }
    [UIView animateWithDuration:0.2 animations:^{
        tableV1.width = tabViewLeftWidth;
        tableV2.x     = self.width/2.0;
        tableV2.width = tabViewRightWidth;
    }];

    
    //选中tableV1的第一行
//    [self tableView:tableV1 didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
//
//    [tableV1 selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
//
//    tableV2.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
}





-(UIWindow *)windowsView{

    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    return window;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == tableV1) {
        
        return _aryOnr.count;
    }else{
        return _aryTwo.count;
    }
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  AdaH(40);
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = indexPath.row;
    //表1
    if (tableView == tableV1) {
        
        static NSString *cellId = @"identify";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        
        if (!cell) {
            
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        cell.textLabel.text = [self stringAndData:row];
        return cell;
    }
    
    //表2
    static NSString *cellId2 = @"cell";
    UITableViewCell *cell2 = [tableView dequeueReusableCellWithIdentifier:cellId2];
    
    if (!cell2) {
        
        cell2 = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId2];
    }
    
    cell2.textLabel.text = [self stringAndDataTwo:row];
    return cell2;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(tableView == tableV1){
        BOOL isCancel = [self isClick];
        if (isCancel == NO) {
            NSDictionary * dict = [self blockDictionary:_aryOnr[indexPath.row]];
            self.endBlack(dict[@"number"], dict[@"name"],indexPath.row);
            [self clickDismissMothe];
        }else{
            [self UILayout:1 and:indexPath.row];
        }

    }
    
    if (tableView == tableV2) {
        NSDictionary * dict = [self blockDictionary:_aryTwo[indexPath.row]];
        self.endBlack(dict[@"number"], dict[@"name"],indexPath.row);
        [self clickDismissMothe];
    }
    
}

-(BOOL )UILayout:(NSInteger )index and:(NSInteger )selIndex{
    if (index == 1) {
        NSDictionary * dict = _aryOnr[selIndex];
        id tempSre = dict[@"LIST"];
        if ([tempSre isKindOfClass:[NSArray class]]) {
            [_aryTwo setArray:tempSre];
            [self upView:YES];
            [tableV2 reloadData];
            return YES;
        }else{
            return NO;
        }
    }
    return NO;
}


-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self clickDismissMothe];
}

- (void)clickDismissMothe
{
    [self cancelBtnclink];
}
- (void)cancelBtnclink {
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 0;
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
        self.cancelBlock();
    }];
}



-(NSString *)stringAndData:(NSInteger)index{
    NSString * tempStr;
    NSDictionary * dict = _aryOnr[index];
    switch (cType) {
        case selectGPZHtype:
        {
            tempStr = dict[@"ORG_NAME"];
        }
            break;
        case selectGPZCtype:
        {
            tempStr = dict[@"PRD_CPLB_MC"];
        }
            break;
        case selectGPTYtype:
        {
            tempStr = dict[@"PRD_CPMC"];
        }
            break;
        case selectGPRMBtype:
        {
            tempStr = dict[@"CURR_ZWM"];
        }
            break;
            //市场利率//
        case selectSCRENBCtype:
        {
             tempStr = dict[@"RATE_LXMC"];
        }
            break;
        case selectSCQBFLtype:
        {
            tempStr = dict[@"RATE_ZLMC"];
        }
            break;
        case selectSCRMBtype:
        {
        }
            break;
            //FTP利率//
        case selectFTPQUFLtype:
        {
           tempStr = dict[@"FSI_QXMC"];
        }
            break;
        case selectFTPRMBtype:
        {
            tempStr = dict[@"CURR_ZWM"];
        }
            break;
        default:
            break;
    }
    return tempStr;
}

-(NSString *)stringAndDataTwo:(NSInteger)index{
    NSString * tempStr;
    NSDictionary * dict = _aryTwo[index];
    switch (cType) {
        case selectGPZHtype:
        {
            
        }
            break;
        case selectGPZCtype:
        {
            
        }
            break;
        case selectGPTYtype:
        {
            tempStr = dict[@"PRD_CPMC"];
        }
            break;
        case selectGPRMBtype:
        {
            
        }
            break;
            //市场利率//
        case selectSCRENBCtype:
        {
        }
            break;
        case selectSCQBFLtype:
        {
        }
            break;
        case selectSCRMBtype:
        {
        }
            break;
            //FTP利率//
        case selectFTPQUFLtype:
        {
            tempStr = dict[@"FSI_QXMC"];
        }
            break;
        case selectFTPRMBtype:
        {
            tempStr = dict[@"CURR_ZWM"];
        }
            break;
        default:
            break;
    }
    return tempStr;
}



-(BOOL)isClick{
    BOOL isClick = false;
    switch (cType) {
        case selectGPZHtype:
        {
            
        }
            break;
        case selectGPZCtype:
        {
            isClick = NO;
        }
            break;
        case selectGPTYtype:
        {
            isClick = YES;
        }
            break;
        case selectGPRMBtype:
        {
            isClick = NO;
        }
            break;
            //市场利率//
        case selectSCRENBCtype:
        {
            isClick = NO;
        }
            break;
        case selectSCQBFLtype:
        {
            isClick = NO;
        }
            break;
        case selectSCRMBtype:
        {
        }
            break;
            //FTP利率//
        case selectFTPQUFLtype:
        {
            isClick = NO;
        }
            break;
        case selectFTPRMBtype:
        {
            isClick = NO;
        }
            break;
        default:
            break;
    }
    return isClick;
}

-(NSDictionary *)blockDictionary:(NSDictionary *)info{
    NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
    switch (cType) {
        case selectGPZHtype:
        {
//            NSString * tempS = info[@""];
            [dict setValue:info[@"ORG_ID"] forKey:@"number"];
            [dict setValue:info[@"ORG_NAME"] forKey:@"name"];
        }
            break;
        case selectGPZCtype:
        {
            [dict setValue:info[@"PRD_CPLB"] forKey:@"number"];
            [dict setValue:info[@"PRD_CPLB_MC"] forKey:@"name"];
        }
            break;
        case selectGPTYtype:
        {
            [dict setValue:info[@"PRD_CPDM"] forKey:@"number"];
            [dict setValue:info[@"PRD_CPMC"] forKey:@"name"];
        }
            break;
        case selectGPRMBtype:
        {
            [dict setValue:info[@"CURR_ISO"] forKey:@"number"];
            [dict setValue:info[@"CURR_ZWM"] forKey:@"name"];
        }
            break;
            //市场利率//
        case selectSCRENBCtype:
        {
            [dict setValue:info[@"RATE_LLLX"] forKey:@"number"];
            [dict setValue:info[@"RATE_LXMC"] forKey:@"name"];
        }
            break;
        case selectSCQBFLtype:
        {
            [dict setValue:info[@"RATE_LLZL"] forKey:@"number"];
            [dict setValue:info[@"RATE_ZLMC"] forKey:@"name"];
        }
            break;
        case selectSCRMBtype:
        {
            
        }
            break;
            //FTP利率//
        case selectFTPQUFLtype:
        {
            [dict setValue:info[@"FSI_QXDM"] forKey:@"number"];
            [dict setValue:info[@"FSI_QXMC"] forKey:@"name"];
        }
            break;
        case selectFTPRMBtype:
        {
            [dict setValue:info[@"CURR_ISO"] forKey:@"number"];
            [dict setValue:info[@"CURR_ZWM"] forKey:@"name"];
        }
            break;
        default:
            break;
    }
    return dict;
}

@end
