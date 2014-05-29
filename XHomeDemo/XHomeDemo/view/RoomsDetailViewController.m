//
//  RoomsDetailViewController.m
//  XHomeDemo
//
//  Created by Gene on 14-5-21.
//  Copyright (c) 2014年 ROBOTIZE-LIFE. All rights reserved.
//

#import "RoomsDetailViewController.h"
#import "ButtonTagDef.h"

@interface RoomsDetailViewController ()

@end

@implementation RoomsDetailViewController

@synthesize deviceCtr;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.deviceCtr = [[deviceMgr alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIBarButtonItem *addDevBtn = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(btnShortClk:)];
    addDevBtn.tag = ADDNEWDEV_BUTTON_TAG;
    self.navigationItem.rightBarButtonItem = addDevBtn;
    
    NSLog(@"%@",self.title);
    
    

    [self.deviceCtr initDevices:self.title];
    
    [self updateView:self.deviceCtr];
    
}

- (void)btnShortClk:(UIButton *)sender
{

    //如果是添加设备按钮按下 弹出添加框
    if (sender.tag == ADDNEWDEV_BUTTON_TAG) {
        
        UIAlertView *addDevAlertv=[[UIAlertView alloc] initWithTitle:@"添加新设备" message:@"请输入新的设备名称？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [addDevAlertv setAlertViewStyle:UIAlertViewStylePlainTextInput];
        [[addDevAlertv textFieldAtIndex:0] setPlaceholder:@"请输入新的设备名称"];
        addDevAlertv.tag = ALERT_VIEW_ADDDEV;
        [addDevAlertv show];
    }
    NSLog(@"lll");

}


- (void)btnLongClk:(UILongPressGestureRecognizer *)gestureRecognizer
{
    UIButton *bt = (UIButton *)gestureRecognizer.view;
    
    if ([gestureRecognizer state] == UIGestureRecognizerStateBegan) {
        NSLog(@"长按事件");
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:bt.titleLabel.text message:@"您需要做什么？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"更新",@"删除", nil];
        alert.tag = ALERT_VIEW_BTN_LONG_PRESS;
        [alert show];
    }
    
}



//UIAlertView响应 代理函数
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == ALERT_VIEW_ADDDEV) { //添加按钮 提示框
        if (buttonIndex == 0) {
            NSLog(@"quxiao");
        } else if (buttonIndex == 1) {
            if ([alertView textFieldAtIndex:0].text.length != 0) {
                BOOL isOK = [self.deviceCtr addNewDevice:[alertView textFieldAtIndex:0].text withRoomName:self.title];
                if (isOK) {
                    [[[UIAlertView alloc] initWithTitle:@"添加成功" message:@"已添加！"  delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
                    [self.deviceCtr initDevices:self.title];
                    [self updateView:self.deviceCtr];
                } else {
                    [[[UIAlertView alloc] initWithTitle:@"添加失败" message:@"房间名重复，请更换房间名重新输入！"  delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil] show];
                }
            } else {
                UIAlertView * av = [[UIAlertView alloc] initWithTitle:@"失败" message:@"请输入房间名！"  delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil];
                [av show];
            }
            
        }
        
    } else if (alertView.tag == ALERT_VIEW_UPDATE) {
        if (buttonIndex == 0) {         //取消
            NSLog(@"quxiao");
            
        } else if (buttonIndex == 1) {  //确定
            NSLog(@"确定");
            NSLog(@"%@:--%@",alertView.title,[alertView textFieldAtIndex:0].text);
            if ([alertView textFieldAtIndex:0].text.length != 0) {
                
                BOOL isOK = [self.deviceCtr updateDevice:[alertView textFieldAtIndex:0].text withOldDeviceName:alertView.title withRoomName:self.title];
                if (isOK) {
                    [[[UIAlertView alloc] initWithTitle:@"成功" message:@"已更新！"  delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
                    [self.deviceCtr initDevices:self.title];
                    [self updateView:self.deviceCtr];
                }else {
                    [[[UIAlertView alloc] initWithTitle:@"失败" message:@"房间名重复，请更换房间名重新输入！"  delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil] show];
                }
            } else {
                UIAlertView * av = [[UIAlertView alloc] initWithTitle:@"失败" message:@"请输入房间名！"  delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil];
                [av show];
            }
            
        }
    } else if (alertView.tag == ALERT_VIEW_BTN_LONG_PRESS) {
        if (buttonIndex == 0) {         //取消
            NSLog(@"quxiao");
            
        } else if (buttonIndex == 1) {  //更新
            NSLog(@"gengxin");
            
            UIAlertView *altV = [[UIAlertView alloc] initWithTitle:alertView.title message:@"请输入新的房间名"  delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
            altV.alertViewStyle = UIAlertViewStylePlainTextInput;
            [[altV textFieldAtIndex:0] setPlaceholder:[NSString stringWithFormat:@"请输入新的房间名如：%@1",alertView.title]];
            altV.tag = ALERT_VIEW_UPDATE;
            [altV show];
            
        } else if (buttonIndex == 2) {  //删除
            NSLog(@"shanchu");
            
            BOOL isOK = [self.deviceCtr deleteDevice:alertView.title withRoomName:self.title];
            if (isOK) {
                [[[UIAlertView alloc] initWithTitle:@"成功" message:@"已删除！"  delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
                [self.deviceCtr initDevices:self.title];
                [self updateView:self.deviceCtr];
                
            }else {
                [[[UIAlertView alloc] initWithTitle:@"失败" message:@"删除失败！"  delegate:self cancelButtonTitle:@"取消" otherButtonTitles: nil] show];
            }
            
        }
    }
}







- (void)updateView:(deviceMgr *)dvCtr
{
    //清空view中的东西
    //获取此view中所有的子view
    NSArray *subViews = [[NSArray alloc] initWithArray:[self.view subviews]];
    //从view中删除
    for (UIView *subv in subViews) {
        //        NSArray *subViewArry = [[NSArray alloc] initWithArray:[subv subviews]];
        //        for (UIView *sv in subViewArry) {
        //            [sv removeFromSuperview];
        //        }
        [subv removeFromSuperview];
    }
	
    //添加一个scrollView
    UIScrollView *scrv = [[UIScrollView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    scrv.contentSize = CGSizeMake(scrv.bounds.size.width, scrv.bounds.size.height * 20);
    [self.view addSubview:scrv];
    
    //TODO:2.将查询到的条目 以按钮的形式添加到view中
#define SQUARE_SIDE_LONGTH ([[UIScreen mainScreen] bounds].size.width / 2 - 5 - 10) //一个正方形边长
#define ONE_PAGE_HEIGHT ((SQUARE_SIDE_LONGTH + 10) * 5) //一页的高
    int count = 0;
    for (NSObject *obj in dvCtr.devicesArry) {
        
        deviceTable *dt = (deviceTable *)obj;
        NSLog(@"%@",dt.deviceName);
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        btn.tag = DEVICE_BUTTON_TAG + count;
        [btn setTitle:dt.deviceName forState:UIControlStateNormal];
        
        btn.titleLabel.font = [UIFont systemFontOfSize:20.0];
        CGFloat r = arc4random() % 100 / 100.0 ;
        CGFloat g = arc4random() % 100 / 100.0 ;
        CGFloat b = arc4random() % 100 / 100.0 ;
        [btn setBackgroundColor:[UIColor colorWithRed:r green:g blue:b alpha:1.0]];
        //        [btn setTitleColor:[UIColor colorWithRed:1.0-r green:1.0-g blue:1.0-b alpha:1.0] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        int btnTypeNum = (count+1) % 10;
        switch (btnTypeNum) {
                //                      group 1
                //                 --------    --------
                //                |        |  |        |
                //                |   1    |  |    2   |
                //                |        |  |        |
                //                 --------    --------
            case 1:
                btn.frame = CGRectMake(10, count/10*ONE_PAGE_HEIGHT + 10, SQUARE_SIDE_LONGTH, SQUARE_SIDE_LONGTH);
                break;
            case 2:
                btn.frame = CGRectMake(SQUARE_SIDE_LONGTH + 20 , count/10*ONE_PAGE_HEIGHT + 10, SQUARE_SIDE_LONGTH, SQUARE_SIDE_LONGTH);
                break;
                
                //                      group 2
                //                 --------    --------
                //                |        |  |        |
                //                |   3    |  |    4   |
                //                |        |  |        |
                //                 --------    --------
            case 3:
                btn.frame = CGRectMake(10 , count/10*ONE_PAGE_HEIGHT + 1*(SQUARE_SIDE_LONGTH + 10) + 10, SQUARE_SIDE_LONGTH, SQUARE_SIDE_LONGTH);
                break;
            case 4:
                btn.frame = CGRectMake(SQUARE_SIDE_LONGTH + 20 , count/10*ONE_PAGE_HEIGHT + 1*(SQUARE_SIDE_LONGTH + 10) + 10 , SQUARE_SIDE_LONGTH, SQUARE_SIDE_LONGTH);
                break;
                
                
                //                         group 3
                //                   ----------------------
                //                  |                      |
                //                  |          5           |
                //                  |                      |
                //                   ----------------------
            case 5:
                btn.frame = CGRectMake(10 , count/10*ONE_PAGE_HEIGHT + 2*(SQUARE_SIDE_LONGTH + 10) + 10, SQUARE_SIDE_LONGTH * 2 + 10, SQUARE_SIDE_LONGTH);
                break;
                
                //                         group 4
                //                   ----------------------
                //                  |          6           |
                //                   ----------------------
                //                   ----------------------
                //                  |          7           |
                //                   ----------------------
            case 6:
                btn.frame = CGRectMake(10 , count/10*ONE_PAGE_HEIGHT + 3*(SQUARE_SIDE_LONGTH + 10) + 10, (SQUARE_SIDE_LONGTH + 5) * 2, SQUARE_SIDE_LONGTH / 2 - 5);
                break;
            case 7:
                btn.frame = CGRectMake(10 , count/10*ONE_PAGE_HEIGHT + 3*(SQUARE_SIDE_LONGTH + 10) + 10  + SQUARE_SIDE_LONGTH / 2 + 5, (SQUARE_SIDE_LONGTH + 5) * 2, SQUARE_SIDE_LONGTH / 2 - 5);
                break;
                
                
                //                          group 5
                //                 ------------    -----
                //                |      8     |  |     |
                //                 ------------   |     |
                //                 ------------   |  0  |
                //                |      9     |  |     |
                //                 ------------    -----
            case 8:
                btn.frame = CGRectMake(10 , count/10*ONE_PAGE_HEIGHT + 4*(SQUARE_SIDE_LONGTH + 10) + 10, SQUARE_SIDE_LONGTH * 4 / 3, SQUARE_SIDE_LONGTH / 2 - 5);
                break;
            case 9:
                btn.frame = CGRectMake(10 , count/10*ONE_PAGE_HEIGHT + 4*(SQUARE_SIDE_LONGTH + 10) + 10  + SQUARE_SIDE_LONGTH / 2 + 5, SQUARE_SIDE_LONGTH * 4 / 3, SQUARE_SIDE_LONGTH / 2 - 5);
                break;
            case 0:
                btn.frame = CGRectMake(SQUARE_SIDE_LONGTH * 4 / 3 + 20 , count/10*ONE_PAGE_HEIGHT + 4*(SQUARE_SIDE_LONGTH + 10) + 10, SQUARE_SIDE_LONGTH * 2 / 3, SQUARE_SIDE_LONGTH);
                break;
            default:
                btn.frame = CGRectMake(10, count * 50 + 500, 100, 40);
                break;
        }
        
        scrv.contentSize = CGSizeMake(scrv.bounds.size.width, btn.frame.origin.y + btn.frame.size.height + SQUARE_SIDE_LONGTH);
        [btn addTarget:self action:@selector(btnShortClk:) forControlEvents:UIControlEventTouchUpInside];
        
        
        //添加长按 事件 时间
        UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(btnLongClk:)];
        [lpgr setMinimumPressDuration:0.8];
        [btn addGestureRecognizer:lpgr];
        
        [scrv addSubview:btn];
        
        count++;
        
    }
    
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
