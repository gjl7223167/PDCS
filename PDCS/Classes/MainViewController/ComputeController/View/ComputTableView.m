//
//  ComputTableView.m
//  PDCS
//
//  Created by iMac on 2017/10/28.
//  Copyright © 2017年 iMac. All rights reserved.
//

#import "ComputTableView.h"
#import "ComputTableCell.h"
#define  headerHeight 25
@interface ComputTableView()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;

    UIView * bcView;
    
    NSArray * headerAry;
}

@property(nonatomic,strong)NSMutableDictionary * infoData;

@end
@implementation ComputTableView

- (instancetype)initWithFrame:(CGRect)frame InfoData:(id)info{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView:info Frame:frame];
    }
    return self;
}


-(void)setInfoDate:(NSMutableDictionary *)dcit{
    [self.infoData setDictionary:dcit];
    
    [tableV reloadData];
}

-(void)initView:(id)info Frame:(CGRect)frame {
    if (self.infoData == nil) {
        self.infoData = [[NSMutableDictionary alloc] init];
    }else{
        [self.infoData removeAllObjects];
    }
    [self.infoData setDictionary:info];
    
    self.backgroundColor = [kViewBgColor colorWithAlphaComponent:0.4];
    if (tableV == nil) {
        tableV = [[UITableView alloc]initWithFrame:CGRectMake(0,0, frame.size.width, frame.size.height) style:UITableViewStylePlain];
        tableV.delegate = self;
        tableV.dataSource = self;
        [self addSubview:tableV];
        [tableV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(self);
        }];
    }
    
}


-(void)showComputTable{
    
    
}



#pragma mark - Table view data source



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.infoData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        NSDictionary * dic = [self.infoData objectForKey:@"ywxx"];
        NSArray * ary = dic[@"value"];
        return ary.count;
    }else if (section == 1){
         NSDictionary * dic = [self.infoData objectForKey:@"cpxx"];
        NSArray * ary = dic[@"value"];
        return ary.count;
    }else if (section == 2){
         NSDictionary * dic = [self.infoData objectForKey:@"jgxx"];
        NSArray * ary = dic[@"value"];
        return ary.count;
    }
    return 0;
}

-(CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return headerHeight;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSString * titleStirng;
    if (section == 0) {
        NSDictionary * dic = [self.infoData objectForKey:@"ywxx"];
        titleStirng = dic[@"name"];
    }else if (section == 1){
        NSDictionary * dic = [self.infoData objectForKey:@"cpxx"];
        titleStirng = dic[@"name"];
    }else if (section == 2){
        NSDictionary * dic = [self.infoData objectForKey:@"jgxx"];
        titleStirng = dic[@"name"];
    }
    UILabel * headerLabel = [PDUtils createNormalLabel:titleStirng with:UIColorFromRGB(0x000000) frame:CGRectMake(23,0,100,headerHeight) with:12.0f];
    headerLabel.backgroundColor = [UIColor clearColor];
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, headerHeight)];
    view.backgroundColor = kLineColor;
    [view addSubview:headerLabel];
    return view;
}

//-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  [ComputTableCell cellHeight];
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    static NSString * indentifier = @"indentifier";
    
    ComputTableCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (!cell) {
        cell = [[ComputTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
    }
    
    NSString * name;
    NSString * dicName;
    if (section == 0) {
        NSDictionary * dict = _infoData[@"ywxx"];
        NSArray * ary = dict[@"value"];
        NSDictionary * dDry = ary[row];
        name = dDry[@"name"];
        dicName = dDry[@"value"];
    }else if (section == 1){
        NSDictionary * dict = _infoData[@"cpxx"];
        NSArray * ary = dict[@"value"];
        NSDictionary * dDry = ary[row];
        name = dDry[@"name"];
        dicName = dDry[@"value"];
    }else if (section == 2){
        NSDictionary * dict = _infoData[@"jgxx"];
        NSArray * ary = dict[@"value"];
        NSDictionary * dDry = ary[row];
        name = dDry[@"name"];
        dicName = dDry[@"value"];
    }
    
    [cell setTitle:name AndDTitle:dicName];
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.cellDidClickBlock) {
        self.cellDidClickBlock(indexPath);
    }
    NSLog(@"点击");
    
}





@end
