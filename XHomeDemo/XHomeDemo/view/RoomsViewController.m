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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //TODO:1.查询数据库 得到 Room 条目
    
    //TODO:2.将查询到的条目 以按钮的形式添加到view中
    
}

- (void)btnClk:(id)sender
{
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
