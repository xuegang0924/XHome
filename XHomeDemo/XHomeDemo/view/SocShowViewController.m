//
//  SocShowViewController.m
//  XHomeDemo
//
//  Created by Gene on 14-6-4.
//  Copyright (c) 2014年 ROBOTIZE-LIFE. All rights reserved.
//

#import "SocShowViewController.h"

@interface SocShowViewController ()
@property(strong,nonatomic)UIButton *btnSocONOFF;

@end

@implementation SocShowViewController

@synthesize strDeviceName;
@synthesize strRoomName;
@synthesize strCommanName;
@synthesize commandCtr;
@synthesize deviceCtr;
@synthesize dataTrans;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        if (!_btnSocONOFF) {
            _btnSocONOFF = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            _btnSocONOFF.frame = CGRectMake(10, 150, 300, 300);
        }
        
        if (!self.commandCtr) {
            self.commandCtr = [[commandMgr alloc] init];
            
        }
        
        if (!self.deviceCtr) {
            self.deviceCtr = [[deviceMgr alloc]  init];
        }
        
        if (!self.dataTrans) {
            self.dataTrans = [[DataTransfer alloc] init];
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = [UIColor blackColor];
    NSRange rg = [self.title rangeOfString:@"-"];
    self.strRoomName = [self.title substringToIndex:rg.location];
    self.strDeviceName = [self.title substringFromIndex:(rg.location + rg.length)];
    
    NSString *strDevState = [self.deviceCtr getDeviceState:self.strDeviceName withRoomName:self.strRoomName];
    if ([strDevState isEqualToString:@"ON"]) {
        [_btnSocONOFF setBackgroundImage:[UIImage imageNamed:@"soc_ON_480_480.png"] forState:UIControlStateNormal];
    } else {
        [_btnSocONOFF setBackgroundImage:[UIImage imageNamed:@"soc_OFF_480_480.png"] forState:UIControlStateNormal];
    }
    
    _btnSocONOFF.tag = 1;
    [_btnSocONOFF addTarget:self action:@selector(btnShortClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btnSocONOFF];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    [self.dataTrans disconnectSocket];
}

- (void)btnShortClick:(UIButton *)sender
{
    
    NSString *strDevState = [self.deviceCtr getDeviceState:self.strDeviceName withRoomName:self.strRoomName];
    
    if ([strDevState isEqualToString:@"ON"]) {
        self.strCommanName = @"COM_SOC_ON";
        
        NSData *strCommandData = [self.commandCtr getCommandData:self.strCommanName withDeviceName:self.strDeviceName withRoomName:self.strRoomName];
        if (strCommandData.length == 0) {
            NSLog(@"NOCommand");
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:self.title message:@"此按键还没有学习命令" delegate:self cancelButtonTitle:@"取消" otherButtonTitles: nil];
            alert.tag = 1;
            [alert show];
            
            
            //TODO1:等待socket数据 将命令添加至按键对应的数据库 //TODO:NSdata
            BOOL ret = [self.commandCtr addNewCommand:self.strCommanName withDevName:self.strDeviceName withRoomName:self.strRoomName withCommandData:nil];
            [self.commandCtr initCommandsWithRoomName:self.strRoomName withDeviceName:self.strDeviceName];
            NSLog(@"%d",ret);
        } else {
            
            //TODO2:将取得的commandData数据 经过socket 发送出去
            int IDnum = [self.deviceCtr getDeviceIDNumber:self.strDeviceName withRoomName:strRoomName];
            if (IDnum < 0) {
                NSLog(@"Error there is no dev");
            }
            [self.dataTrans sendData:strCommandData withDevType:@"插座" withDevID:IDnum withCom:YES];
            NSLog(@"%@",strCommandData);
            
            //TODO3:等待socket的回复数据 是否顺利执行命令
            [_btnSocONOFF setBackgroundImage:[UIImage imageNamed:@"soc_OFF_480_480.png"] forState:UIControlStateNormal];
            BOOL ret = [self.deviceCtr  setDeviceState:self.strDeviceName withRoomName:self.strRoomName withDeviceState:@"OFF"];
            NSLog(@"%d",ret);
        }
        
    } else {
        self.strCommanName = @"COM_SOC_OFF";
        
        NSData *strCommandData = [self.commandCtr getCommandData:self.strCommanName withDeviceName:self.strDeviceName withRoomName:self.strRoomName];
        if (strCommandData.length == 0) {
            NSLog(@"NOCommand");
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:self.title message:@"此按键还没有学习命令" delegate:self cancelButtonTitle:@"取消" otherButtonTitles: nil];
            alert.tag = 1;
            [alert show];
            
            
            //TODO1:等待socket数据 将命令添加至按键对应的数据库 //TODO:NSdata
            BOOL ret = [self.commandCtr addNewCommand:self.strCommanName withDevName:self.strDeviceName withRoomName:self.strRoomName withCommandData:nil];
            [self.commandCtr initCommandsWithRoomName:self.strRoomName withDeviceName:self.strDeviceName];
            NSLog(@"%d",ret);
        } else {
            
            //TODO2:将取得的commandData数据 经过socket 发送出去
            int IDnum = [self.deviceCtr getDeviceIDNumber:self.strDeviceName withRoomName:strRoomName];
            if (IDnum < 0) {
                NSLog(@"Error there is no dev");
            }
            [self.dataTrans sendData:strCommandData withDevType:@"插座" withDevID:IDnum withCom:YES];
            NSLog(@"%@",strCommandData);
            
            //TODO3:等待socket的回复数据 是否顺利执行命令
            [_btnSocONOFF setBackgroundImage:[UIImage imageNamed:@"soc_ON_480_480.png"] forState:UIControlStateNormal];
            BOOL ret = [self.deviceCtr  setDeviceState:self.strDeviceName withRoomName:self.strRoomName withDeviceState:@"ON"];
            NSLog(@"%d",ret);
        }
        
    }
    
    
    
    
    
}






@end
