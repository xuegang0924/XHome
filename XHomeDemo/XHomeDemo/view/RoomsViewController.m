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
        
        self.roomCtr = [[roomMgr alloc] init];

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //设置导航栏的右侧添加按钮
    UIBarButtonItem *moreBtn = [[UIBarButtonItem alloc] initWithTitle:@"更多" style:UIBarButtonItemStylePlain target:self action:@selector(btnClk:)];
    moreBtn.tag = MOREROOMINFO_BUTTON_TAG;
    self.navigationItem.rightBarButtonItem = moreBtn;

    //TODO:1.查询数据库 得到 Room 条目
    [self.roomCtr initRooms];
    for (NSObject* obj in self.roomCtr.roomsArry) {
        [obj printAllPropertys];
    }
    NSLog(@"rooms number:%lu",(unsigned long)self.roomCtr.roomsArry.count);
    
    //加载数据库中的按钮
    [self updateView:roomCtr];
    
}

- (void)updateView:(roomMgr *)rmCtr
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
#define SQUARE_SIDE_LONGTH (scrv.bounds.size.width / 2 - 5 - 10) //一个正方形边长
#define ONE_PAGE_HEIGHT ((SQUARE_SIDE_LONGTH + 10) * 4) //一页的高
    BOOL gotoFlag = YES;
    int count = 0;
    for (NSObject *obj in rmCtr.roomsArry) {
        
        roomTable *rt = (roomTable *)obj;
        NSLog(@"%@",rt.roomName);
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
       
        btn.tag = ROOMS_BUTTON_TAG + count;
        [btn setTitle:rt.roomName forState:UIControlStateNormal];
        
        if (!gotoFlag) {
            btn.tag = ADDNEWROOM_BUTTON_TAG;
            [btn setTitle:@"添加新房间" forState:UIControlStateNormal];
        }
        
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
                
//                          group 2
//                 ------------    -----
//                |      3     |  |     |
//                 ------------   |     |
//                 ------------   |  5  |
//                |      4     |  |     |
//                 ------------    -----
            case 3:
                btn.frame = CGRectMake(10 , count/10*ONE_PAGE_HEIGHT + 1*(SQUARE_SIDE_LONGTH + 10) + 10, SQUARE_SIDE_LONGTH * 4 / 3, SQUARE_SIDE_LONGTH / 2 - 5);
                break;
            case 4:
                btn.frame = CGRectMake(10 , count/10*ONE_PAGE_HEIGHT + 1*(SQUARE_SIDE_LONGTH + 10) + 10  + SQUARE_SIDE_LONGTH / 2 + 5, SQUARE_SIDE_LONGTH * 4 / 3, SQUARE_SIDE_LONGTH / 2 - 5);
                break;
            case 5:
                btn.frame = CGRectMake(SQUARE_SIDE_LONGTH * 4 / 3 + 20 , count/10*ONE_PAGE_HEIGHT + 1*(SQUARE_SIDE_LONGTH + 10) + 10, SQUARE_SIDE_LONGTH * 2 / 3, SQUARE_SIDE_LONGTH);
                break;

//                          group 3
//                  -----    ------------
//                 |     |  |      7     |
//                 |     |   ------------
//                 |  6  |   ------------
//                 |     |  |      8     |
//                  -----    ------------
            case 6:
                btn.frame = CGRectMake(10 , count/10*ONE_PAGE_HEIGHT + 2*(SQUARE_SIDE_LONGTH + 10) + 10, SQUARE_SIDE_LONGTH * 2 / 3, SQUARE_SIDE_LONGTH);
                break;
            case 7:
                btn.frame = CGRectMake(SQUARE_SIDE_LONGTH * 2 / 3 + 20 , count/10*ONE_PAGE_HEIGHT + 2*(SQUARE_SIDE_LONGTH + 10) + 10, SQUARE_SIDE_LONGTH * 4 / 3, SQUARE_SIDE_LONGTH / 2 - 5);
                break;
            case 8:
                btn.frame = CGRectMake(SQUARE_SIDE_LONGTH * 2 / 3 + 20 , count/10*ONE_PAGE_HEIGHT + 2*(SQUARE_SIDE_LONGTH + 10) + 10  + SQUARE_SIDE_LONGTH / 2 + 5, SQUARE_SIDE_LONGTH * 4 / 3, SQUARE_SIDE_LONGTH / 2 - 5);
                break;
                
//                         group 4
//                   ----------------------
//                  |          9           |
//                   ----------------------
//                   ----------------------
//                  |          0           |
//                   ----------------------
            case 9:
                btn.frame = CGRectMake(10 , count/10*ONE_PAGE_HEIGHT + 3*(SQUARE_SIDE_LONGTH + 10) + 10, (SQUARE_SIDE_LONGTH + 5) * 2, SQUARE_SIDE_LONGTH / 2 - 5);
                break;
            case 0:
                btn.frame = CGRectMake(10 , count/10*ONE_PAGE_HEIGHT + 3*(SQUARE_SIDE_LONGTH + 10) + 10  + SQUARE_SIDE_LONGTH / 2 + 5, (SQUARE_SIDE_LONGTH + 5) * 2, SQUARE_SIDE_LONGTH / 2 - 5);
                break;
            default:
                btn.frame = CGRectMake(10, count * 50 + 500, 100, 40);
                break;
        }
        
        //        btn.frame = CGRectMake(10, count * 50 + 10, 100, 40);
        if (btn.frame.origin.y + btn.frame.size.height + 10 >= scrv.contentSize.height) {
            scrv.contentSize = CGSizeMake(scrv.bounds.size.width, btn.frame.origin.y + btn.frame.size.height + 10);
        }
        scrv.contentSize = CGSizeMake(scrv.bounds.size.width, btn.frame.origin.y + btn.frame.size.height + SQUARE_SIDE_LONGTH);
        [btn addTarget:self action:@selector(btnClk:) forControlEvents:UIControlEventTouchUpInside];
        
        
        //添加长按 事件 时间
        UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(btnLongClik:)];
        [lpgr setMinimumPressDuration:0.8];
        
        [btn addGestureRecognizer:lpgr];
        [scrv addSubview:btn];

        count++;
        
    }
    
}


- (void)btnClk:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    NSLog(@"short click");
    
    if (btn.tag == MOREROOMINFO_BUTTON_TAG) {  //更多按钮
        NSLog(@"more");
        //转到RoomsAddView
        RoomsAddViewController *ravc = [[RoomsAddViewController alloc] init];
       
        [self.navigationController pushViewController:ravc animated:YES];
        
    } else if (btn.tag == ADDNEWROOM_BUTTON_TAG) {
        
    } else {      //TODO:3.识别相应的按钮操作
        RoomsDetailViewController *rdvc = [[RoomsDetailViewController alloc] init];
        rdvc.title = btn.titleLabel.text;
        [self.navigationController pushViewController:rdvc animated:YES];        
    }
    

    
}


-(void)btnLongClik:(UILongPressGestureRecognizer *)gestureRecognizer{
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
    if (alertView.tag == ALERT_VIEW_UPDATE) {
        if (buttonIndex == 0) {         //取消
            NSLog(@"quxiao");
            
        } else if (buttonIndex == 1) {  //确定
            NSLog(@"确定");
            NSLog(@"%@:--%@",alertView.title,[alertView textFieldAtIndex:0].text);
            if ([alertView textFieldAtIndex:0].text.length != 0) {
                
                BOOL isOK = [self.roomCtr updateRoom:[alertView textFieldAtIndex:0].text withOldRoomName:alertView.title];
                if (isOK) {
                    [[[UIAlertView alloc] initWithTitle:@"成功" message:@"已更新！"  delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
                    [self.roomCtr initRooms];
                    [self updateView:self.roomCtr];
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

            BOOL isOK = [self.roomCtr deleteRoom:alertView.title];
            if (isOK) {
                [[[UIAlertView alloc] initWithTitle:@"成功" message:@"已删除！"  delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
                [self.roomCtr initRooms];
                [self updateView:self.roomCtr];
                
            }else {
                [[[UIAlertView alloc] initWithTitle:@"失败" message:@"删除失败！"  delegate:self cancelButtonTitle:@"取消" otherButtonTitles: nil] show];
            }
           
        }
    }
}






- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
