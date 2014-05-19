//
//  RoomsViewController.m
//  XHomeDemo
//
//  Created by Gene on 14-5-11.
//  Copyright (c) 2014年 ROBOTIZE-LIFE. All rights reserved.
//

#import "RoomsViewController.h"


@interface RoomsViewController ()

@end



@implementation RoomsViewController

@synthesize roomCtr;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
       
        //TODO:1.查询数据库 得到 Room 条目
        self.roomCtr = [[roomMgr alloc] init];
        [self.roomCtr initRooms];
        
        NSLog(@"rooms number:%lu",(unsigned long)self.roomCtr.roomsArry.count);
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //设置导航栏的右侧添加按钮
    UIBarButtonItem *addBtn = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(btnClk:)];
    addBtn.tag = 1000;
    self.navigationItem.rightBarButtonItem = addBtn;

   
    

    

    //TODO:2.将查询到的条目 以按钮的形式添加到view中
    
}

- (void)btnClk:(id)sender
{
    UIButton *btn = (UIButton *)sender;
   
    if (btn.tag == 1000) {  //添加按钮
        NSLog(@"add");
        //转到RoomsAddView
        RoomsAddViewController *ravc = [[RoomsAddViewController alloc] init];
        [self.navigationController pushViewController:ravc animated:YES];
        
    }
    //TODO:3.识别相应的按钮操作
}

- (void)btnClkAddNew:(id)sender
{
    //TODO:4.跳转到添加ViewCtr
}






- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
