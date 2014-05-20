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
        
        for (NSObject* obj in self.roomCtr.roomsArry) {
            [obj printAllPropertys];
        }
        NSLog(@"rooms number:%lu",(unsigned long)self.roomCtr.roomsArry.count);
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //设置导航栏的右侧添加按钮
    UIBarButtonItem *addBtn = [[UIBarButtonItem alloc] initWithTitle:@"更多" style:UIBarButtonItemStylePlain target:self action:@selector(btnClk:)];
    addBtn.tag = 1000;
    self.navigationItem.rightBarButtonItem = addBtn;

    //添加一个scrollView
    UIScrollView *scrv = [[UIScrollView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    scrv.contentSize = CGSizeMake(scrv.bounds.size.width, scrv.bounds.size.height * 2);
    
    [self.view addSubview:scrv];
    

    //TODO:2.将查询到的条目 以按钮的形式添加到view中
#define SQUARE_SIDE_LONGTH (scrv.bounds.size.width / 2 - 5 - 10) //一个正方形边长
#define ONE_PAGE_HEIGHT ((SQUARE_SIDE_LONGTH + 10) * 4) //一页的高
    int count = 0;
    for (NSObject *obj in self.roomCtr.roomsArry) {
        
        NSLog(@"%d",obj.rowid);
        [obj printAllPropertys];
//        NSObject *oo = [self.roomCtr.roomsArry objectAtIndex:0] ;

        roomTable *rt = (roomTable *)obj;
        NSLog(@"%@",rt.roomName);
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        btn.tag = ROOMS_BUTTON_TAG + count;
        [btn setTitle:rt.roomName forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:20.0];
        [btn setBackgroundColor:[UIColor colorWithRed:(CGFloat)((count + 5) % 10 / 10.0) green:(CGFloat)((count + 3) % 10 / 10.0) blue:(CGFloat)((count + 4) % 10 / 10.0) alpha:1.0]];
        
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
//
////                          group 3
////                  -----    ------------
////                 |     |  |      7     |
////                 |     |   ------------
////                 |  6  |   ------------
////                 |     |  |      8     |
////                  -----    ------------
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
   
    if (btn.tag == 1000) {  //更多按钮
        NSLog(@"more");
        //转到RoomsAddView
        RoomsAddViewController *ravc = [[RoomsAddViewController alloc] init];
        [self.navigationController pushViewController:ravc animated:YES];
        
    }
    //TODO:3.识别相应的按钮操作
    NSLog(@"short click");
}


-(void)btnLongClik:(UILongPressGestureRecognizer *)gestureRecognizer{
    if ([gestureRecognizer state] == UIGestureRecognizerStateBegan) {
        NSLog(@"长按事件");
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"消息" message:@"确定删除该模式吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"删除", nil];
        [alert show];
    }
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
