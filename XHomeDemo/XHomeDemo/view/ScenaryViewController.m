//
//  ScenaryViewController.m
//  XHomeDemo
//
//  Created by Gene on 14-5-11.
//  Copyright (c) 2014年 ROBOTIZE-LIFE. All rights reserved.
//

#import "ScenaryViewController.h"

@interface ScenaryViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *btnSclv;


@end


@implementation ScenaryViewController
@synthesize scenaryCtr;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.scenaryCtr = [[scenaryMgr alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    self.title = @"SCENARY";
    self.navigationController.view.backgroundColor = [UIColor blackColor];
    //TODO:1.查询数据库 得到 Room 条目
    [self.scenaryCtr initScenarys];
    for (NSObject* obj in self.scenaryCtr.scenarysArry) {
        [obj printAllPropertys];
    }
    NSLog(@"scenarys number:%lu",(unsigned long)self.scenaryCtr.scenarysArry.count);
    
    //加载数据库中的按钮
    [self updateView:self.scenaryCtr];
    
}









- (void)btnShortClk:(UIButton *)sender
{
    NSLog(@"short click");
    if (sender.tag == ADDNEW_SCENARY_BUTTON_TAG) {
        UIAlertView *addAlert=[[UIAlertView alloc] initWithTitle:@"添加新场景" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        addAlert.tag = ALERT_VIEW_ADDSCENARY;
        addAlert.alertViewStyle = UIAlertViewStylePlainTextInput;
        [[addAlert textFieldAtIndex:0] setPlaceholder:@"请输入新添加场景的名称"];
        [addAlert show];
    }
    
}


-(void)btnLongClik:(UILongPressGestureRecognizer *)gestureRecognizer{
    UIButton *bt = (UIButton *)gestureRecognizer.view;
    
    if ([gestureRecognizer state] == UIGestureRecognizerStateBegan) {
        NSLog(@"长按事件");
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:bt.titleLabel.text message:@"您需要做什么？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"修改命令",@"重新命名",@"删除", nil];
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
                
                BOOL isOK = [self.scenaryCtr updateScenary:[alertView textFieldAtIndex:0].text withOldScenaryName:alertView.title];
                if (isOK) {
                    [[[UIAlertView alloc] initWithTitle:@"成功" message:@"已更新！"  delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
                    [self.scenaryCtr initScenarys];
                    [self updateView:self.scenaryCtr];
                }else {
                    [[[UIAlertView alloc] initWithTitle:@"失败" message:@"房间名重复，请更换场景名重新输入！"  delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil] show];
                }
            } else {
                UIAlertView * av = [[UIAlertView alloc] initWithTitle:@"失败" message:@"请输入场景名！"  delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil];
                [av show];
            }

        }
    } else if (alertView.tag == ALERT_VIEW_BTN_LONG_PRESS) {
        if (buttonIndex == 0) {         //取消
            NSLog(@"quxiao");
            
        } else if (buttonIndex == 1) {  //修改命令
            
            //TODO:修改场景对应的命令
            ScenaryAddCommandViewController *sacVc = [[ScenaryAddCommandViewController alloc] init];
            [self.navigationController pushViewController:sacVc animated:YES];
        
        } else if (buttonIndex == 2) {  //重新命名
            NSLog(@"重新命名");
            
            UIAlertView *altV = [[UIAlertView alloc] initWithTitle:alertView.title message:@"请输入新的场景名"  delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
            altV.alertViewStyle = UIAlertViewStylePlainTextInput;
            [[altV textFieldAtIndex:0] setPlaceholder:[NSString stringWithFormat:@"请输入新的场景名如：%@1",alertView.title]];
            altV.tag = ALERT_VIEW_UPDATE;
            [altV show];
            
        } else if (buttonIndex == 3) {  //删除
            NSLog(@"shanchu");
            
            BOOL isOK = [self.scenaryCtr deleteScenary:alertView.title];
            if (isOK) {
                [[[UIAlertView alloc] initWithTitle:@"成功" message:@"已删除！"  delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
                [self.scenaryCtr initScenarys];
                [self updateView:self.scenaryCtr];
                
            }else {
                [[[UIAlertView alloc] initWithTitle:@"失败" message:@"删除失败！"  delegate:self cancelButtonTitle:@"取消" otherButtonTitles: nil] show];
            }
            
        }
    } else if (alertView.tag == ALERT_VIEW_ADDSCENARY) {
        if (buttonIndex == 0) {         //取消
            NSLog(@"quxiao");
            
        } else if (buttonIndex == 1) {  //确定
            NSLog(@"确定");
            
            if ([alertView textFieldAtIndex:0].text.length != 0) {
                
                BOOL isOK = [self.scenaryCtr addNewScenary:[alertView textFieldAtIndex:0].text];
//                             updateRoom:[alertView textFieldAtIndex:0].text withOldRoomName:alertView.title];
                if (isOK) {
                    [[[UIAlertView alloc] initWithTitle:@"成功" message:@"已添加！"  delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
                    [self.scenaryCtr initScenarys];
                    [self updateView:self.scenaryCtr];
                }else {
                    [[[UIAlertView alloc] initWithTitle:@"失败" message:@"场景名重复，请更换场景名重新输入！"  delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil] show];
                }
            } else {
                UIAlertView * av = [[UIAlertView alloc] initWithTitle:@"失败" message:@"请输入场景名！"  delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil];
                [av show];
            }
            
        }
    }
}




- (void)updateView:(scenaryMgr *)snCtr
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
    scrv.contentSize = CGSizeMake(scrv.bounds.size.width, scrv.bounds.size.height);
//    scrv.backgroundColor = [UIColor colorWithRed:140/256.0 green:200/256.0 blue:150/256.0 alpha:255/256.0];
    scrv.backgroundColor = [UIColor blackColor];
    [self.view addSubview:scrv];
    

    
#define SQUARE_SIDE_LONGTH ([[UIScreen mainScreen] bounds].size.width / 2 - 5 - 10) //一个正方形边长
#define ONE_PAGE_HEIGHT ((SQUARE_SIDE_LONGTH + 10) * 5) //一页的高
    int count = 0;
    for (NSObject *obj in snCtr.scenarysArry) {
        
        scenaryTable *st = (scenaryTable *)obj;
        NSLog(@"%@",st.scenaryName);
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        btn.tag = SCENARY_BUTTON_TAG + count;
        [btn setTitle:st.scenaryName forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:20.0];
        CGFloat r = (arc4random() % 60 + 20) / 100.0 ;
        CGFloat g = (arc4random() % 60 + 20) / 100.0 ;
        CGFloat b = (arc4random() % 60 + 20) / 100.0 ;
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
                //                   ----------------------
                //                  |                      |
                //                  |          3           |
                //                  |                      |
                //                   ----------------------
            case 3:
                btn.frame = CGRectMake(10 , count/10*ONE_PAGE_HEIGHT + 1*(SQUARE_SIDE_LONGTH + 10) + 10, SQUARE_SIDE_LONGTH * 2 + 10, SQUARE_SIDE_LONGTH );
                break;

                
                //                          group 3
                //                  --------    ---------
                //                 |        |  |   5     |
                //                 |        |   ---------
                //                 |   4    |   ---------
                //                 |        |  |   6     |
                //                  --------    ---------
            case 4:
                btn.frame = CGRectMake(10 , count/10*ONE_PAGE_HEIGHT + 2*(SQUARE_SIDE_LONGTH + 10) + 10, SQUARE_SIDE_LONGTH, SQUARE_SIDE_LONGTH);
                break;
            case 5:
                btn.frame = CGRectMake(SQUARE_SIDE_LONGTH + 20, count/10*ONE_PAGE_HEIGHT + 2*(SQUARE_SIDE_LONGTH + 10) + 10, SQUARE_SIDE_LONGTH, SQUARE_SIDE_LONGTH / 2 - 5);
                break;
            case 6:
                btn.frame = CGRectMake(SQUARE_SIDE_LONGTH + 20 , count/10*ONE_PAGE_HEIGHT + 2*(SQUARE_SIDE_LONGTH + 10) + 10 + SQUARE_SIDE_LONGTH / 2 + 5, SQUARE_SIDE_LONGTH, SQUARE_SIDE_LONGTH / 2 -5);
                break;

                
                //                          group 4
                //                 ---------    --------
                //                |    7    |  |        |
                //                 ---------   |        |
                //                 ---------   |   9    |
                //                |    8    |  |        |
                //                 ---------    --------
            case 7:
                btn.frame = CGRectMake(10 , count/10*ONE_PAGE_HEIGHT + 3*(SQUARE_SIDE_LONGTH + 10) + 10, SQUARE_SIDE_LONGTH, SQUARE_SIDE_LONGTH / 2 - 5);
                break;
            case 8:
                btn.frame = CGRectMake(10 , count/10*ONE_PAGE_HEIGHT + 3*(SQUARE_SIDE_LONGTH + 10) + 10  + SQUARE_SIDE_LONGTH / 2 + 5, SQUARE_SIDE_LONGTH, SQUARE_SIDE_LONGTH / 2 - 5);
                break;
            case 9:
                btn.frame = CGRectMake(SQUARE_SIDE_LONGTH + 20, count/10*ONE_PAGE_HEIGHT + 3*(SQUARE_SIDE_LONGTH + 10) + 10, SQUARE_SIDE_LONGTH, SQUARE_SIDE_LONGTH);
                break;
                //                          group 5
                //                   ----------------------
                //                  |                      |
                //                  |          0           |
                //                  |                      |
                //                   ----------------------
            case 0:
                btn.frame = CGRectMake(10 , count/10*ONE_PAGE_HEIGHT + 4*(SQUARE_SIDE_LONGTH + 10) + 10, (SQUARE_SIDE_LONGTH + 5) * 2, SQUARE_SIDE_LONGTH);
                break;
            default:
                btn.frame = CGRectMake(10, count * 50 + 500, 100, 40);
                break;
        }
        
        //        btn.frame = CGRectMake(10, count * 50 + 10, 100, 40);
        //        if (btn.frame.origin.y + btn.frame.size.height + 10 >= scrv.contentSize.height) {
        //            scrv.contentSize = CGSizeMake(scrv.bounds.size.width, btn.frame.origin.y + btn.frame.size.height + 10);
        //        }
        scrv.contentSize = CGSizeMake(scrv.bounds.size.width, btn.frame.origin.y + btn.frame.size.height + SQUARE_SIDE_LONGTH);
        [btn addTarget:self action:@selector(btnShortClk:) forControlEvents:UIControlEventTouchUpInside];
        
        
        //添加长按 事件 时间
        UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(btnLongClik:)];
        [lpgr setMinimumPressDuration:0.8];
        
        [btn addGestureRecognizer:lpgr];
        [scrv addSubview:btn];
        
        count++;
        
    }
    //在scrollView的最底部添加一个 "添加" 按钮
    UIButton *addNewScenaryBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect] ;
    addNewScenaryBtn.frame = CGRectMake(10, scrv.contentSize.height-100, scrv.contentSize.width - 20, 60);
    [addNewScenaryBtn setTitle:@"添加..." forState:UIControlStateNormal];
    addNewScenaryBtn.backgroundColor = [UIColor greenColor];
    addNewScenaryBtn.tag = ADDNEW_SCENARY_BUTTON_TAG;
    [addNewScenaryBtn addTarget:self action:@selector(btnShortClk:) forControlEvents:UIControlEventTouchUpInside];
    [scrv addSubview:addNewScenaryBtn];
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//- (UIStatusBarStyle)preferredStatusBarStyle
//{
//    return UIStatusBarStyleLightContent;
//}
//
//- (BOOL)prefersStatusBarHidden
//{
//    return NO;
//}
@end
