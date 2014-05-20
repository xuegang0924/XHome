//
//  RoomsAddViewController.m
//  XHomeDemo
//
//  Created by Gene on 14-5-15.
//  Copyright (c) 2014年 ROBOTIZE-LIFE. All rights reserved.
//

#import "RoomsAddViewController.h"

@interface RoomsAddViewController ()

@end

@implementation RoomsAddViewController

@synthesize tfNewRoomName;
@synthesize roomCtr;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        roomCtr = [[roomMgr alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    UIBarButtonItem *OKBtn = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleBordered target:self action:@selector(btnClik:)];
//    OKBtn.tag = 1000;
//    self.navigationItem.rightBarButtonItem = OKBtn;
}

//- (void)btnClik:(UIButton *)sender
//{
//    if (sender.tag == 1000) {   //完成添加
//        NSLog(@"OK");
//        
//    }
//}

- (IBAction)addNewRoom:(id)sender
{
    if (tfNewRoomName.text.length != 0 ) {
        BOOL isOK = [roomCtr addNewRoom:tfNewRoomName.text];
        if (isOK) {
//            [[[UIAlertView alloc] initWithTitle:@"成功" message:@"成功添加！"  delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
            [self.navigationController popViewControllerAnimated:YES];

        }else {
            [[[UIAlertView alloc] initWithTitle:@"失败" message:@"房间名重复，请更换房间名重新输入！"  delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil] show];
        }
    } else {
        [[[UIAlertView alloc] initWithTitle:@"错误" message:@"请输入房间名"  delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil] show];
    }
}

- (IBAction)updateRoom:(id)sender
{
    if (tfNewRoomName.text.length != 0 ) {
        BOOL isOK = [roomCtr updateRoom:tfNewRoomName.text];
        if (isOK) {
            //            [[[UIAlertView alloc] initWithTitle:@"成功" message:@"成功添加！"  delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
            [self.navigationController popViewControllerAnimated:YES];
            
        }else {
            [[[UIAlertView alloc] initWithTitle:@"失败" message:@"房间名重复，请更换房间名重新输入！"  delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil] show];
        }
    } else {
        [[[UIAlertView alloc] initWithTitle:@"错误" message:@"请输入房间名"  delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil] show];
    }
}

- (IBAction)deleteRoom:(id)sender
{
    if (tfNewRoomName.text.length != 0 ) {
        BOOL isOK = [roomCtr deleteRoom:tfNewRoomName.text];
        if (isOK) {
            //            [[[UIAlertView alloc] initWithTitle:@"成功" message:@"成功添加！"  delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
            [self.navigationController popViewControllerAnimated:YES];
            
        }else {
            [[[UIAlertView alloc] initWithTitle:@"失败" message:@"没有此房间，请更换房间名重新输入！"  delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil] show];
        }
    } else {
        [[[UIAlertView alloc] initWithTitle:@"错误" message:@"请输入房间名"  delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil] show];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
