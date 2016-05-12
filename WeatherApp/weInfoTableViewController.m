//
//  weInfoTableViewController.m
//  WeatherApp
//
//  Created by GMH on 5/7/16.
//  Copyright © 2016 com.zy.weather. All rights reserved.
//

#import "weInfoTableViewController.h"
#import "UIImageView+WebCache.h"
@interface weInfoTableViewController ()

@end

@implementation weInfoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor=[UIColor clearColor];
     self.clearsSelectionOnViewWillAppear = NO;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"resue"];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuse"];
    }
    cell.backgroundColor=[UIColor clearColor];
    cell.userInteractionEnabled=NO;
    NSDictionary *weInfoDic=self.WE_INFO_ARR[0];
    if (indexPath.row==0) {
        NSString *weCategory=[NSString stringWithFormat:@"%@°",[[weInfoDic objectForKey:@"now"] objectForKey:@"tmp"]];
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(40, 90, self.view.frame.size.width, 150)];
        label.text=weCategory;
        label.font=[UIFont fontWithName:@"HelveticaNeue-Light" size:160];
        label.textColor=[UIColor whiteColor];
        [cell.contentView addSubview:label];
    }else if (indexPath.row==1){
        UIImageView *cellImageView=[[UIImageView alloc]initWithFrame:CGRectMake(30, 10, 60, 60)];
        NSString *categoryCode=[[[weInfoDic objectForKey:@"now"] objectForKey:@"cond"] objectForKey:@"code"];
        NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) objectAtIndex:0]stringByAppendingPathComponent:@"weatherCategoryInfo.plist"];
        NSArray *plistArray=[NSArray arrayWithContentsOfFile:path];
        for (NSDictionary *dict in plistArray) {
            if ([[dict objectForKey:@"code"] isEqualToString:categoryCode]) {
                [cellImageView sd_setImageWithURL:[dict objectForKey:@"icon"]];
                [cell.contentView addSubview:cellImageView];
            }
        }
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(100, 10, self.view.frame.size.width-100, 60)];
        NSString *min=[[[weInfoDic objectForKey:@"daily_forecast"][0] objectForKey:@"tmp"] objectForKey:@"min"];
        NSString *max=[[[weInfoDic objectForKey:@"daily_forecast"][0] objectForKey:@"tmp"] objectForKey:@"max"];
        NSString *tmpStr=[NSString stringWithFormat:@"%@~%@℃",min,max];
        NSString *weCategory=[[[weInfoDic objectForKey:@"now"] objectForKey:@"cond"] objectForKey:@"txt"];
        label.text=[NSString stringWithFormat:@"%@  %@",weCategory,tmpStr];
        label.font=[UIFont fontWithName:@"HelveticaNeue-Light" size:20];
        label.textColor=[UIColor whiteColor];
        [cell.contentView addSubview:label];
        
        UILabel *labelFl=[[UILabel alloc]initWithFrame:CGRectMake(40, 75, 150, 40)];
        NSString *flTmp=[[weInfoDic objectForKey:@"now"] objectForKey:@"fl"];
        NSString *hum=[[weInfoDic objectForKey:@"now"] objectForKey:@"hum"];
        labelFl.text=[NSString stringWithFormat:@"体感 %@℃  湿度 %@％",flTmp,hum];
        labelFl.textColor=[UIColor whiteColor];
        labelFl.font=[UIFont fontWithName:@"HelveticaNeue-Light" size:15];
        [cell.contentView addSubview:labelFl];
        
        UILabel *labelTime=[[UILabel alloc]initWithFrame:CGRectMake(40, 120, 150, 20)];
        NSString *loc=[[[weInfoDic objectForKey:@"basic"] objectForKey:@"update"] objectForKey:@"loc"];
        labelTime.text=[NSString stringWithFormat:@"于 %@ 发布",loc];
        labelTime.textColor=[UIColor whiteColor];
        labelTime.font=[UIFont fontWithName:@"HelveticaNeue-Light" size:10];
        [cell.contentView addSubview:labelTime];
    }else if (indexPath.row==2){
        
    }else{
        cell.textLabel.text=@"ssss";
    }
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        return 250;
    }else if (indexPath.row==1){
        return self.view.frame.size.height-400;
    }else if (indexPath.row==2){
        return 150;
    }else{
        return 40;
    }
}

@end
