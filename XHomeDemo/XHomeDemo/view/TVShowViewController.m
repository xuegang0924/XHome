//
//  TVShowViewController.m
//  XHomeDemo
//
//  Created by Gene on 14-6-4.
//  Copyright (c) 2014年 ROBOTIZE-LIFE. All rights reserved.
//

#import "TVShowViewController.h"

@interface TVShowViewController ()

@end

@implementation TVShowViewController
@synthesize commandCtr;
@synthesize strCommanName;
@synthesize strDeviceName;
@synthesize strRoomName;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        if (!self.commandCtr) {
            self.commandCtr = [[commandMgr alloc] init];
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSRange rg = [self.title rangeOfString:@"-"];
    NSString *RoomName = [self.title substringToIndex:rg.location];
    NSString *devName = [self.title substringFromIndex:(rg.location + rg.length)];
    self.strRoomName = RoomName;
    self.strDeviceName = devName;
    
    [self.commandCtr initCommandsWithRoomName:self.strRoomName withDeviceName:self.strDeviceName];
    
    self.view.backgroundColor = [UIColor blackColor];

    [self updateView];
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)btnShortClick:(UIButton *)sender
{
    NSLog(@"ss");
  
    if (sender.tag == 100) {    //comONOFF
        self.strCommanName = @"COM_TV_ONOFF";
        NSString *strCommandData = [self.commandCtr getCommandData:self.strCommanName withDeviceName:self.strDeviceName withRoomName:self.strRoomName];
        if (strCommandData.length == 0) {
            NSLog(@"NOCommand");
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:self.title message:@"此按键还没有学习命令" delegate:self cancelButtonTitle:@"取消" otherButtonTitles: nil];
            alert.tag = 1;
            [alert show];
            
            
            //TODO1:等待socket数据 将命令添加至按键对应的数据库
            BOOL ret = [self.commandCtr addNewCommand:self.strCommanName withDevName:self.strDeviceName withRoomName:self.strRoomName withCommandData:@"123456"];
            [self.commandCtr initCommandsWithRoomName:self.strRoomName withDeviceName:self.strDeviceName];
            NSLog(@"%d",ret);
        }
        
        //TODO2:将取得的commandData数据 经过socket 发送出去
        NSLog(@"%@",strCommandData);        
    }

}


- (void)updateView
{
    //添加一个scrollView
    UIScrollView *scrv = [[UIScrollView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    scrv.contentSize = CGSizeMake(scrv.bounds.size.width, scrv.bounds.size.height * 2);
    scrv.backgroundColor = [UIColor blackColor];
    [scrv setPagingEnabled:YES];
    [self.view addSubview:scrv];
    
    
#define X3 110/4.0
#define X4 40/5.0
#define BTNW  70
#define LENGW   (BTNW+X4)
#define LENGH   50
#define ONPAGE_HIGHTE   583
    
    UIButton *btnONOFF = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btnONOFF.frame = CGRectMake(X4, LENGH, BTNW, BTNW);
    [btnONOFF setBackgroundImage:[UIImage imageNamed:@"kaiguan_400_400.png"] forState:UIControlStateNormal];
    btnONOFF.tag = 100;
    [btnONOFF addTarget:self action:@selector(btnShortClick:) forControlEvents:UIControlEventTouchUpInside];
    [scrv addSubview:btnONOFF];
    [scrv setContentSize:CGSizeMake(self.view.bounds.size.width, btnONOFF.frame.origin.y + BTNW)];
    
    UIButton *btnMenu = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btnMenu.frame = CGRectMake(LENGW +X4, LENGH, BTNW, BTNW);
    [btnMenu setBackgroundImage:[UIImage imageNamed:@"menu_400_400.png"] forState:UIControlStateNormal];
    btnMenu.tag = 101;
    [btnMenu addTarget:self action:@selector(btnShortClick:) forControlEvents:UIControlEventTouchUpInside];
    [scrv addSubview:btnMenu];
    [scrv setContentSize:CGSizeMake(self.view.bounds.size.width, btnMenu.frame.origin.y + BTNW)];
    
    UIButton *btnSignelSource = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btnSignelSource.frame = CGRectMake(LENGW*2 +X4, LENGH, BTNW, BTNW);
    [btnSignelSource setBackgroundImage:[UIImage imageNamed:@"signalSource_400_400.png"] forState:UIControlStateNormal];
    btnSignelSource.tag = 102;
    [btnSignelSource addTarget:self action:@selector(btnShortClick:) forControlEvents:UIControlEventTouchUpInside];
    [scrv addSubview:btnSignelSource];
    [scrv setContentSize:CGSizeMake(self.view.bounds.size.width, btnSignelSource.frame.origin.y + BTNW)];
    
    UIButton *btnMute = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btnMute.frame = CGRectMake(LENGW*3 +X4, LENGH, BTNW, BTNW);
    [btnMute setBackgroundImage:[UIImage imageNamed:@"mute_400_400.png"] forState:UIControlStateNormal];
    btnMute.tag = 103;
    [btnMute addTarget:self action:@selector(btnShortClick:) forControlEvents:UIControlEventTouchUpInside];
    [scrv addSubview:btnMute];
    [scrv setContentSize:CGSizeMake(self.view.bounds.size.width, btnMute.frame.origin.y + BTNW)];
    
    
#define MIDSIZE   (320 - BTNW)/2
    UIButton *btnUP = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btnUP.frame = CGRectMake(MIDSIZE, LENGH + BTNW + 20, BTNW, BTNW);
    [btnUP setBackgroundImage:[UIImage imageNamed:@"up_400_400.png"] forState:UIControlStateNormal];
    btnUP.tag = 104;
    [btnUP addTarget:self action:@selector(btnShortClick:) forControlEvents:UIControlEventTouchUpInside];
    [scrv addSubview:btnUP];
    [scrv setContentSize:CGSizeMake(self.view.bounds.size.width, btnUP.frame.origin.y + BTNW)];
    
    UIButton *btnOK = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btnOK.frame = CGRectMake(MIDSIZE, LENGH + (BTNW + 20)*2,  BTNW, BTNW);
    [btnOK setBackgroundImage:[UIImage imageNamed:@"OK_400_400.png"] forState:UIControlStateNormal];
    btnOK.tag = 105;
    [btnOK addTarget:self action:@selector(btnShortClick:) forControlEvents:UIControlEventTouchUpInside];
    [scrv addSubview:btnOK];
    [scrv setContentSize:CGSizeMake(self.view.bounds.size.width, btnOK.frame.origin.y + BTNW)];
    
    UIButton *btnDown = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btnDown.frame = CGRectMake(MIDSIZE, LENGH + (BTNW + 20)*3, BTNW, BTNW);
    [btnDown setBackgroundImage:[UIImage imageNamed:@"down_400_400.png"] forState:UIControlStateNormal];
    btnDown.tag = 106;
    [btnDown addTarget:self action:@selector(btnShortClick:) forControlEvents:UIControlEventTouchUpInside];
    [scrv addSubview:btnDown];
    [scrv setContentSize:CGSizeMake(self.view.bounds.size.width, btnDown.frame.origin.y + BTNW)];
    
    UIButton *btnLeft = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btnLeft.frame = CGRectMake(MIDSIZE - BTNW -20, LENGH + (BTNW + 20)*2, BTNW, BTNW);
    [btnLeft setBackgroundImage:[UIImage imageNamed:@"left_400_400.png"] forState:UIControlStateNormal];
    btnLeft.tag = 107;
    [btnLeft addTarget:self action:@selector(btnShortClick:) forControlEvents:UIControlEventTouchUpInside];
    [scrv addSubview:btnLeft];
    [scrv setContentSize:CGSizeMake(self.view.bounds.size.width, btnLeft.frame.origin.y + BTNW)];
    
    
    UIButton *btnRight = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btnRight.frame = CGRectMake(MIDSIZE +BTNW +20, LENGH + (BTNW + 20)*2, BTNW, BTNW);
    [btnRight setBackgroundImage:[UIImage imageNamed:@"right_400_400.png"] forState:UIControlStateNormal];
    btnRight.tag = 108;
    [btnRight addTarget:self action:@selector(btnShortClick:) forControlEvents:UIControlEventTouchUpInside];
    [scrv addSubview:btnRight];
    [scrv setContentSize:CGSizeMake(self.view.bounds.size.width, btnRight.frame.origin.y + BTNW)];
    
    
    
    
    
    UIButton *btnCustom = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btnCustom.frame = CGRectMake(MIDSIZE - BTNW -20, LENGH + (BTNW + 20)*4, BTNW, BTNW);
    [btnCustom setBackgroundImage:[UIImage imageNamed:@"custom_400_400.png"] forState:UIControlStateNormal];
    btnCustom.tag = 109;
    [btnCustom addTarget:self action:@selector(btnShortClick:) forControlEvents:UIControlEventTouchUpInside];
    [scrv addSubview:btnCustom];
    [scrv setContentSize:CGSizeMake(self.view.bounds.size.width, btnCustom.frame.origin.y + BTNW)];
    
    UIButton *btnGoback = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btnGoback.frame = CGRectMake(MIDSIZE + BTNW +20, LENGH + (BTNW + 20)*4, BTNW, BTNW);
    [btnGoback setBackgroundImage:[UIImage imageNamed:@"goback_400_400.png"] forState:UIControlStateNormal];
    btnGoback.tag = 110;
    [btnGoback addTarget:self action:@selector(btnShortClick:) forControlEvents:UIControlEventTouchUpInside];
    [scrv addSubview:btnGoback];
    [scrv setContentSize:CGSizeMake(self.view.bounds.size.width, btnGoback.frame.origin.y + BTNW)];
    
    
    UIButton *btnNULL = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btnNULL.frame = CGRectMake(MIDSIZE, LENGH + (BTNW + 20)*4, BTNW, BTNW);
    [btnNULL setBackgroundImage:[UIImage imageNamed:@"NULL_400_400.png"] forState:UIControlStateNormal];
    btnNULL.tag = 111;
    [btnNULL addTarget:self action:@selector(btnShortClick:) forControlEvents:UIControlEventTouchUpInside];
    [scrv addSubview:btnNULL];
    [scrv setContentSize:CGSizeMake(self.view.bounds.size.width, btnNULL.frame.origin.y + BTNW)];
    
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    
#define LENGW3    (BTNW+X3)
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn1.frame = CGRectMake(X3, ONPAGE_HIGHTE, BTNW, BTNW);
    [btn1 setBackgroundImage:[UIImage imageNamed:@"1_400_400.png"] forState:UIControlStateNormal];
    btn1.tag = 11;
    [btn1 addTarget:self action:@selector(btnShortClick:) forControlEvents:UIControlEventTouchUpInside];
    [scrv addSubview:btn1];
    [scrv setContentSize:CGSizeMake(self.view.bounds.size.width, btn1.frame.origin.y + BTNW)];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn2.frame = CGRectMake(LENGW3 +X3, ONPAGE_HIGHTE, BTNW, BTNW);
    [btn2 setBackgroundImage:[UIImage imageNamed:@"2_400_400.png"] forState:UIControlStateNormal];
    btn2.tag = 12;
    [btn2 addTarget:self action:@selector(btnShortClick:) forControlEvents:UIControlEventTouchUpInside];
    [scrv addSubview:btn2];
    [scrv setContentSize:CGSizeMake(self.view.bounds.size.width, btn2.frame.origin.y + BTNW)];
    
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn3.frame = CGRectMake(LENGW3*2 +X3, ONPAGE_HIGHTE, BTNW, BTNW);
    [btn3 setBackgroundImage:[UIImage imageNamed:@"3_400_400.png"] forState:UIControlStateNormal];
    btn3.tag = 13;
    [btn3 addTarget:self action:@selector(btnShortClick:) forControlEvents:UIControlEventTouchUpInside];
    [scrv addSubview:btn3];
    [scrv setContentSize:CGSizeMake(self.view.bounds.size.width, btn3.frame.origin.y + BTNW)];
    
    
    
    UIButton *btn4 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn4.frame = CGRectMake(X3, ONPAGE_HIGHTE +BTNW +20, BTNW, BTNW);
    [btn4 setBackgroundImage:[UIImage imageNamed:@"4_400_400.png"] forState:UIControlStateNormal];
    btn4.tag = 14;
    [btn4 addTarget:self action:@selector(btnShortClick:) forControlEvents:UIControlEventTouchUpInside];
    [scrv addSubview:btn4];
    [scrv setContentSize:CGSizeMake(self.view.bounds.size.width, btn4.frame.origin.y + BTNW)];
    
    UIButton *btn5 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn5.frame = CGRectMake(LENGW3 +X3, ONPAGE_HIGHTE +BTNW +20, BTNW, BTNW);
    [btn5 setBackgroundImage:[UIImage imageNamed:@"5_400_400.png"] forState:UIControlStateNormal];
    btn5.tag = 15;
    [btn5 addTarget:self action:@selector(btnShortClick:) forControlEvents:UIControlEventTouchUpInside];
    [scrv addSubview:btn5];
    [scrv setContentSize:CGSizeMake(self.view.bounds.size.width, btn5.frame.origin.y + BTNW)];
    
    UIButton *btn6 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn6.frame = CGRectMake(LENGW3*2 +X3, ONPAGE_HIGHTE +BTNW +20, BTNW, BTNW);
    [btn6 setBackgroundImage:[UIImage imageNamed:@"6_400_400.png"] forState:UIControlStateNormal];
    btn6.tag = 16;
    [btn6 addTarget:self action:@selector(btnShortClick:) forControlEvents:UIControlEventTouchUpInside];
    [scrv addSubview:btn6];
    [scrv setContentSize:CGSizeMake(self.view.bounds.size.width, btn6.frame.origin.y + BTNW)];
    
    
    
    UIButton *btn7 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn7.frame = CGRectMake(X3, ONPAGE_HIGHTE +(BTNW +20)*2, BTNW, BTNW);
    [btn7 setBackgroundImage:[UIImage imageNamed:@"7_400_400.png"] forState:UIControlStateNormal];
    btn7.tag = 17;
    [btn7 addTarget:self action:@selector(btnShortClick:) forControlEvents:UIControlEventTouchUpInside];
    [scrv addSubview:btn7];
    [scrv setContentSize:CGSizeMake(self.view.bounds.size.width, btn7.frame.origin.y + BTNW)];
    
    UIButton *btn8 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn8.frame = CGRectMake(LENGW3 +X3, ONPAGE_HIGHTE +(BTNW +20)*2, BTNW, BTNW);
    [btn8 setBackgroundImage:[UIImage imageNamed:@"8_400_400.png"] forState:UIControlStateNormal];
    btn8.tag = 18;
    [btn8 addTarget:self action:@selector(btnShortClick:) forControlEvents:UIControlEventTouchUpInside];
    [scrv addSubview:btn8];
    [scrv setContentSize:CGSizeMake(self.view.bounds.size.width, btn8.frame.origin.y + BTNW)];
    
    UIButton *btn9 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn9.frame = CGRectMake(LENGW3*2 +X3, ONPAGE_HIGHTE +(BTNW +20)*2, BTNW, BTNW);
    [btn9 setBackgroundImage:[UIImage imageNamed:@"9_400_400.png"] forState:UIControlStateNormal];
    btn9.tag = 19;
    [btn9 addTarget:self action:@selector(btnShortClick:) forControlEvents:UIControlEventTouchUpInside];
    [scrv addSubview:btn9];
    [scrv setContentSize:CGSizeMake(self.view.bounds.size.width, btn9.frame.origin.y + BTNW)];
    
    
    
    UIButton *btn0 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn0.frame = CGRectMake(LENGW3 +X3, ONPAGE_HIGHTE +(BTNW +20)*3, BTNW, BTNW);
    [btn0 setBackgroundImage:[UIImage imageNamed:@"0_400_400.png"] forState:UIControlStateNormal];
    btn0.tag = 10;
    [btn0 addTarget:self action:@selector(btnShortClick:) forControlEvents:UIControlEventTouchUpInside];
    [scrv addSubview:btn0];
    [scrv setContentSize:CGSizeMake(self.view.bounds.size.width, btn0.frame.origin.y + BTNW)];
    
    
    UIButton *btnCustom1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btnCustom1.frame = CGRectMake(X3, ONPAGE_HIGHTE +(BTNW +20)*4, BTNW, BTNW);
    [btnCustom1 setBackgroundImage:[UIImage imageNamed:@"custom_400_400.png"] forState:UIControlStateNormal];
    btnCustom1.tag = 10;
    [btnCustom1 addTarget:self action:@selector(btnShortClick:) forControlEvents:UIControlEventTouchUpInside];
    [scrv addSubview:btnCustom1];
    [scrv setContentSize:CGSizeMake(self.view.bounds.size.width, btnCustom1.frame.origin.y + BTNW)];
    
    UIButton *btnCustom2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btnCustom2.frame = CGRectMake(LENGW3 +X3, ONPAGE_HIGHTE +(BTNW +20)*4, BTNW, BTNW);
    [btnCustom2 setBackgroundImage:[UIImage imageNamed:@"custom_400_400.png"] forState:UIControlStateNormal];
    btnCustom2.tag = 10;
    [btnCustom2 addTarget:self action:@selector(btnShortClick:) forControlEvents:UIControlEventTouchUpInside];
    [scrv addSubview:btnCustom2];
    [scrv setContentSize:CGSizeMake(self.view.bounds.size.width, btnCustom2.frame.origin.y + BTNW)];
    
    UIButton *btnCustom3 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btnCustom3.frame = CGRectMake(LENGW3*2 +X3, ONPAGE_HIGHTE +(BTNW +20)*4, BTNW, BTNW);
    [btnCustom3 setBackgroundImage:[UIImage imageNamed:@"custom_400_400.png"] forState:UIControlStateNormal];
    btnCustom3.tag = 10;
    [btnCustom3 addTarget:self action:@selector(btnShortClick:) forControlEvents:UIControlEventTouchUpInside];
    [scrv addSubview:btnCustom3];
    [scrv setContentSize:CGSizeMake(self.view.bounds.size.width, btnCustom3.frame.origin.y + BTNW*2)];
}

@end
