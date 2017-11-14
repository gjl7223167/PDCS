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

-(void)initView:(id)info Frame:(CGRect)frame {
    if (headerAry == nil) {
        headerAry = [[NSArray alloc] initWithObjects:@"业务信息",@"产品信息",@"机构信息",nil];
    }
    
    self.backgroundColor = [kViewBgColor colorWithAlphaComponent:0.4];
    if (tableV == nil) {
        tableV = [[UITableView alloc]initWithFrame:CGRectMake(0,0, frame.size.width, frame.size.height) style:UITableViewStylePlain];
        tableV.delegate = self;
        tableV.dataSource = self;
        [self addSubview:tableV];
    }
}


-(void)showComputTable{
    
    
}



#pragma mark - Table view data source



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    

    return 3;
}

-(CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return headerHeight;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UILabel * headerLabel = [PDUtils createNormalLabel:headerAry[section] with:UIColorFromRGB(0x000000) frame:CGRectMake(23,0,100,headerHeight) with:12.0f];
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
    NSInteger row = indexPath.row;
    static NSString * indentifier = @"indentifier";
    
    ComputTableCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (!cell) {
        cell = [[ComputTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
    }
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"点击");
    
}





@end
