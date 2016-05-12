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
    
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
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
    return 5;
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
        UILabel *lineLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0.5)];
        lineLabel.backgroundColor=[UIColor whiteColor];
        [cell.contentView addSubview:lineLabel];
        
        UILabel *labeTomo=[[UILabel alloc]initWithFrame:CGRectMake(0, 5, self.view.frame.size.width/3, 30)];
        labeTomo.textAlignment=NSTextAlignmentCenter;
        labeTomo.textColor=[UIColor whiteColor];
        labeTomo.text=@"明天";
        [cell.contentView addSubview:labeTomo];
        
        UILabel *labeTomoo=[[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/3, 5, self.view.frame.size.width/3, 30)];
        labeTomoo.textAlignment=NSTextAlignmentCenter;
        labeTomoo.textColor=[UIColor whiteColor];
        labeTomoo.text=@"后天";
        [cell.contentView addSubview:labeTomoo];
        
        UILabel *labeTomooo=[[UILabel alloc]initWithFrame:CGRectMake((self.view.frame.size.width/3)*2, 5, self.view.frame.size.width/3, 30)];
        labeTomooo.textAlignment=NSTextAlignmentCenter;
        labeTomooo.textColor=[UIColor whiteColor];
        labeTomooo.text=@"大后天";
        [cell.contentView addSubview:labeTomooo];
        
        UILabel *labelTeTomo=[[UILabel alloc]initWithFrame:CGRectMake(0, 35, self.view.frame.size.width/3, 30)];
        labelTeTomo.textAlignment=NSTextAlignmentCenter;
        labelTeTomo.textColor=[UIColor whiteColor];
        NSString *maxTmp=[[[weInfoDic objectForKey:@"daily_forecast"][1] objectForKey:@"tmp"] objectForKey:@"max"];
        NSString *minTmp=[[[weInfoDic objectForKey:@"daily_forecast"][1] objectForKey:@"tmp"] objectForKey:@"min"];
        NSString *tmpRange=[NSString stringWithFormat:@"%@/%@℃",minTmp,maxTmp];
        labelTeTomo.text=tmpRange;
        [cell.contentView addSubview:labelTeTomo];
        
        UILabel *labelTeTomoo=[[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/3, 35, self.view.frame.size.width/3, 30)];
        labelTeTomoo.textAlignment=NSTextAlignmentCenter;
        labelTeTomoo.textColor=[UIColor whiteColor];
        NSString *maxTmpp=[[[weInfoDic objectForKey:@"daily_forecast"][2] objectForKey:@"tmp"] objectForKey:@"max"];
        NSString *minTmpp=[[[weInfoDic objectForKey:@"daily_forecast"][2] objectForKey:@"tmp"] objectForKey:@"min"];
        NSString *tmpRangee=[NSString stringWithFormat:@"%@/%@℃",minTmpp,maxTmpp];
        labelTeTomoo.text=tmpRangee;
        [cell.contentView addSubview:labelTeTomoo];
        
        UILabel *labelTeTomooo=[[UILabel alloc]initWithFrame:CGRectMake((self.view.frame.size.width/3)*2, 35, self.view.frame.size.width/3, 30)];
        labelTeTomooo.textAlignment=NSTextAlignmentCenter;
        labelTeTomooo.textColor=[UIColor whiteColor];
        NSString *maxTmppp=[[[weInfoDic objectForKey:@"daily_forecast"][3] objectForKey:@"tmp"] objectForKey:@"max"];
        NSString *minTmppp=[[[weInfoDic objectForKey:@"daily_forecast"][3] objectForKey:@"tmp"] objectForKey:@"min"];
        NSString *tmpRangeee=[NSString stringWithFormat:@"%@/%@℃",minTmppp,maxTmppp];
        labelTeTomooo.text=tmpRangeee;
        [cell.contentView addSubview:labelTeTomooo];
        
        NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) objectAtIndex:0]stringByAppendingPathComponent:@"weatherCategoryInfo.plist"];

        UIImageView *cellImageViewOne=[[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/6-25, 65, 50, 50)];
        NSString *categoryCodeOne=[[[weInfoDic objectForKey:@"daily_forecast"][1] objectForKey:@"cond"] objectForKey:@"code_d"];
        
        UIImageView *cellImageViewTwo=[[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-25, 65, 50, 50)];
        NSString *categoryCodeTwo=[[[weInfoDic objectForKey:@"daily_forecast"][2] objectForKey:@"cond"] objectForKey:@"code_d"];
        
        UIImageView *cellImageViewThree=[[UIImageView alloc]initWithFrame:CGRectMake((self.view.frame.size.width/6)*5-25, 65, 50, 50)];
        NSString *categoryCodeThree=[[[weInfoDic objectForKey:@"daily_forecast"][3] objectForKey:@"cond"] objectForKey:@"code_d"];
        NSArray *plistArray=[NSArray arrayWithContentsOfFile:path];
        
        for (NSDictionary *dict in plistArray) {
            if ([[dict objectForKey:@"code"] isEqualToString:categoryCodeOne]) {
                [cellImageViewOne sd_setImageWithURL:[dict objectForKey:@"icon"]];
                [cell.contentView addSubview:cellImageViewOne];
            }
            if ([[dict objectForKey:@"code"] isEqualToString:categoryCodeTwo]) {
                [cellImageViewTwo sd_setImageWithURL:[dict objectForKey:@"icon"]];
                [cell.contentView addSubview:cellImageViewTwo];
            }
            if ([[dict objectForKey:@"code"] isEqualToString:categoryCodeThree]) {
                [cellImageViewThree sd_setImageWithURL:[dict objectForKey:@"icon"]];
                [cell.contentView addSubview:cellImageViewThree];
            }
        }
        
        UILabel *labelCaTomo=[[UILabel alloc]initWithFrame:CGRectMake(0, 115, self.view.frame.size.width/3, 30)];
        labelCaTomo.textAlignment=NSTextAlignmentCenter;
        labelCaTomo.textColor=[UIColor whiteColor];
        NSString *txt_d=[[[weInfoDic objectForKey:@"daily_forecast"][1] objectForKey:@"cond"] objectForKey:@"txt_d"];
        NSString *txt_n=[[[weInfoDic objectForKey:@"daily_forecast"][1] objectForKey:@"cond"] objectForKey:@"txt_n"];
        NSString *txt_all;
        if ([txt_d isEqualToString:txt_n]) {
            txt_all=txt_d;
        }else{
            txt_all=[NSString stringWithFormat:@"%@转%@",txt_d,txt_n];
        }
        labelCaTomo.text=txt_all;
        [cell.contentView addSubview:labelCaTomo];
        
        UILabel *labelCaTomoo=[[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/3, 115, self.view.frame.size.width/3, 30)];
        labelCaTomoo.textAlignment=NSTextAlignmentCenter;
        labelCaTomoo.textColor=[UIColor whiteColor];
        NSString *txt_dd=[[[weInfoDic objectForKey:@"daily_forecast"][2] objectForKey:@"cond"] objectForKey:@"txt_d"];
        NSString *txt_nn=[[[weInfoDic objectForKey:@"daily_forecast"][2] objectForKey:@"cond"] objectForKey:@"txt_n"];
        NSString *txt_alll;
        if ([txt_dd isEqualToString:txt_nn]) {
            txt_alll=txt_dd;
        }else{
            txt_alll=[NSString stringWithFormat:@"%@转%@",txt_dd,txt_nn];
        }
        labelCaTomoo.text=txt_alll;
        [cell.contentView addSubview:labelCaTomoo];
        
        UILabel *labelCaTomooo=[[UILabel alloc]initWithFrame:CGRectMake((self.view.frame.size.width/3)*2, 115, self.view.frame.size.width/3, 30)];
        labelCaTomooo.textAlignment=NSTextAlignmentCenter;
        labelCaTomooo.textColor=[UIColor whiteColor];
        NSString *txt_ddd=[[[weInfoDic objectForKey:@"daily_forecast"][3] objectForKey:@"cond"] objectForKey:@"txt_d"];
        NSString *txt_nnn=[[[weInfoDic objectForKey:@"daily_forecast"][3] objectForKey:@"cond"] objectForKey:@"txt_n"];
        NSString *txt_allll;
        if ([txt_ddd isEqualToString:txt_nnn]) {
            txt_allll=txt_ddd;
        }else{
            txt_allll=[NSString stringWithFormat:@"%@转%@",txt_ddd,txt_nnn];
        }
        labelCaTomooo.text=txt_allll;
        [cell.contentView addSubview:labelCaTomooo];
        
    }else if (indexPath.row==3){
        
        UILabel *lineLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0.5)];
        lineLabel.backgroundColor=[UIColor whiteColor];
        [cell.contentView addSubview:lineLabel];
        
        for (int i=0; i<7; i++) {
            UILabel *labelTime=[[UILabel alloc]initWithFrame:CGRectMake((self.view.frame.size.width/7)*i, 5, self.view.frame.size.width/7, 30)];
            labelTime.textAlignment=NSTextAlignmentCenter;
            labelTime.textColor=[UIColor whiteColor];
            labelTime.font=[UIFont systemFontOfSize:15.0f];
            NSString *strTime=[[[weInfoDic objectForKey:@"hourly_forecast"][i] objectForKey:@"date"] substringFromIndex:11];
            NSString *strTimee=[strTime substringToIndex:2];
            NSString *strTimeFinal=[NSString stringWithFormat:@"%@时",strTimee];
            labelTime.text=strTimeFinal;
            [cell.contentView addSubview:labelTime];
            
            UILabel *popLabel=[[UILabel alloc]initWithFrame:CGRectMake((self.view.frame.size.width/7)*i, 35, self.view.frame.size.width/7, 30)];
            popLabel.textAlignment=NSTextAlignmentCenter;
            popLabel.textColor=[UIColor whiteColor];
            popLabel.font=[UIFont systemFontOfSize:15.0f];
            NSString *popStr=[[weInfoDic objectForKey:@"hourly_forecast"][i] objectForKey:@"pop"];
            NSString *percent=@"%";
            popLabel.text=[NSString stringWithFormat:@"%@%@",popStr,percent];
            [cell.contentView addSubview:popLabel];
            
            UILabel *labelTmp=[[UILabel alloc]initWithFrame:CGRectMake((self.view.frame.size.width/7)*i, 65, self.view.frame.size.width/7, 30)];
            labelTmp.textAlignment=NSTextAlignmentCenter;
            labelTmp.textColor=[UIColor whiteColor];
            labelTmp.font=[UIFont systemFontOfSize:15.0f];
            NSString *strTmp=[[weInfoDic objectForKey:@"hourly_forecast"][i] objectForKey:@"tmp"];
            labelTmp.text=[NSString stringWithFormat:@"%@℃",strTmp];
            [cell.contentView addSubview:labelTmp];
        }
    }else if (indexPath.row==4){
        
        UILabel *lineLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0.5)];
        lineLabel.backgroundColor=[UIColor whiteColor];
        [cell.contentView addSubview:lineLabel];
        
        NSMutableArray *TMP_MAX_ARR=[[NSMutableArray alloc]init];
        NSMutableArray *TMP_MIN_ARR=[[NSMutableArray alloc]init];
        for (int i=0; i<6; i++) {
            
            UILabel *labelTime=[[UILabel alloc]initWithFrame:CGRectMake((self.view.frame.size.width/6)*i, 10, self.view.frame.size.width/6, 30)];
            labelTime.textAlignment=NSTextAlignmentCenter;
            labelTime.textColor=[UIColor whiteColor];
            //labelTime.font=[UIFont systemFontOfSize:15.0f];
            NSString *strTime=[[[weInfoDic objectForKey:@"hourly_forecast"][i] objectForKey:@"date"] substringFromIndex:5];
            NSString *strTimee=[strTime substringToIndex:5];
            NSString *strTimeFinal=[NSString stringWithFormat:@"%@",strTimee];
            labelTime.text=strTimeFinal;
            [cell.contentView addSubview:labelTime];
            
            NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) objectAtIndex:0]stringByAppendingPathComponent:@"weatherCategoryInfo.plist"];
            UIImageView *cellImageView_d=[[UIImageView alloc]initWithFrame:CGRectMake((self.view.frame.size.width/12)*(i*2+1)-15, 40, 30, 30)];
            UIImageView *cellImageView_n=[[UIImageView alloc]initWithFrame:CGRectMake((self.view.frame.size.width/12)*(i*2+1)-15, 330, 30, 30)];
            NSString *categoryCode_d=[[[weInfoDic objectForKey:@"daily_forecast"][i] objectForKey:@"cond"] objectForKey:@"code_d"];
            NSString *categoryCode_n=[[[weInfoDic objectForKey:@"daily_forecast"][i] objectForKey:@"cond"] objectForKey:@"code_n"];
            NSArray *plistArray=[NSArray arrayWithContentsOfFile:path];
            for (NSDictionary *dict in plistArray) {
                if ([[dict objectForKey:@"code"] isEqualToString:categoryCode_d]) {
                    [cellImageView_d sd_setImageWithURL:[dict objectForKey:@"icon"]];
                    [cell.contentView addSubview:cellImageView_d];
                }
                if ([[dict objectForKey:@"code"] isEqualToString:categoryCode_n]) {
                    [cellImageView_n sd_setImageWithURL:[dict objectForKey:@"icon"]];
                    [cell.contentView addSubview:cellImageView_n];
                }
            }
            
            UILabel *labelCa_d=[[UILabel alloc]initWithFrame:CGRectMake((self.view.frame.size.width/6)*i, 70, self.view.frame.size.width/6, 30)];
            UILabel *labelCa_n=[[UILabel alloc]initWithFrame:CGRectMake((self.view.frame.size.width/6)*i, 300, self.view.frame.size.width/6, 30)];
            labelCa_d.textAlignment=NSTextAlignmentCenter;
            labelCa_d.textColor=[UIColor whiteColor];
            labelCa_n.textAlignment=NSTextAlignmentCenter;
            labelCa_n.textColor=[UIColor whiteColor];
            labelCa_d.font=[UIFont systemFontOfSize:15];
            labelCa_n.font=[UIFont systemFontOfSize:15];
            NSString *txt_d=[[[weInfoDic objectForKey:@"daily_forecast"][i] objectForKey:@"cond"] objectForKey:@"txt_d"];
            NSString *txt_n=[[[weInfoDic objectForKey:@"daily_forecast"][i] objectForKey:@"cond"] objectForKey:@"txt_n"];
            labelCa_d.text=txt_d;
            labelCa_n.text=txt_n;
            [cell.contentView addSubview:labelCa_d];
            [cell.contentView addSubview:labelCa_n];
            
            UILabel *labelWind=[[UILabel alloc]initWithFrame:CGRectMake((self.view.frame.size.width/6)*i, 360, self.view.frame.size.width/6, 30)];
            labelWind.textAlignment=NSTextAlignmentCenter;
            labelWind.textColor=[UIColor whiteColor];
            //labelTime.font=[UIFont systemFontOfSize:15.0f];
            NSString *strWind=[[[weInfoDic objectForKey:@"hourly_forecast"][i] objectForKey:@"wind"] objectForKey:@"dir"];
            labelWind.text=strWind;
            [cell.contentView addSubview:labelWind];
            
            UILabel *labelWindSc=[[UILabel alloc]initWithFrame:CGRectMake((self.view.frame.size.width/6)*i, 390, self.view.frame.size.width/6, 15)];
            labelWindSc.textAlignment=NSTextAlignmentCenter;
            labelWindSc.textColor=[UIColor whiteColor];
            labelWindSc.font=[UIFont systemFontOfSize:12.0f];
            NSString *strWindSc=[[[weInfoDic objectForKey:@"hourly_forecast"][i] objectForKey:@"wind"] objectForKey:@"sc"];
            labelWindSc.text=[NSString stringWithFormat:@"%@级",strWindSc];
            [cell.contentView addSubview:labelWindSc];
            
            NSString *strTmp_max=[[[weInfoDic objectForKey:@"daily_forecast"][i] objectForKey:@"tmp"] objectForKey:@"max"] ;
            NSString *strTmp_min=[[[weInfoDic objectForKey:@"daily_forecast"][i] objectForKey:@"tmp"] objectForKey:@"min"] ;
            
            [TMP_MAX_ARR addObject:strTmp_max];
            [TMP_MIN_ARR addObject:strTmp_min];
        }
        
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
    }else if (indexPath.row==3){
        return 100;
    }else if (indexPath.row==4){
        return 435;
    }else{
        return 40;
    }
}

@end
