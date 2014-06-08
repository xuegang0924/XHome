//
//  LampShowViewController.m
//  XHomeDemo
//
//  Created by Gene on 14-6-4.
//  Copyright (c) 2014年 ROBOTIZE-LIFE. All rights reserved.
//

#import "LampShowViewController.h"

@interface LampShowViewController ()
@property(strong,nonatomic)UIButton *btnLampONOFF;

@end


@implementation LampShowViewController
@synthesize strDeviceName;
@synthesize strRoomName;
@synthesize strCommanName;
@synthesize commandCtr;
@synthesize deviceCtr;
@synthesize dataTrans;
@synthesize myAlert;
@synthesize bNeedAddBtnCommadFlag;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        if (!_btnLampONOFF) {
            _btnLampONOFF = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            _btnLampONOFF.frame = CGRectMake((320 - 285) /2, 80, 285, 480);
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
    
    self.dataTrans.sendRecvDataDelegate = self;
    
    self.view.backgroundColor = [UIColor blackColor];
    NSRange rg = [self.title rangeOfString:@"-"];
    self.strRoomName = [self.title substringToIndex:rg.location];
    self.strDeviceName = [self.title substringFromIndex:(rg.location + rg.length)];
    
    NSString *strDevState = [self.deviceCtr getDeviceState:self.strDeviceName withRoomName:self.strRoomName];
    if ([strDevState isEqualToString:@"ON"]) {
        [_btnLampONOFF setBackgroundImage:[UIImage imageNamed:@"lamp_ON_480_285.png"] forState:UIControlStateNormal];
    } else {
        [_btnLampONOFF setBackgroundImage:[UIImage imageNamed:@"lamp_OFF_480_285.png"] forState:UIControlStateNormal];
    }
    
     _btnLampONOFF.tag = 1;
    [_btnLampONOFF addTarget:self action:@selector(btnShortClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btnLampONOFF];
    
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
    [self.dataTrans.recvDataThread cancel];
//    self.dataTrans = nil;
    
}

- (void)btnShortClick:(UIButton *)sender
{
    
    NSString *strDevState = [self.deviceCtr getDeviceState:self.strDeviceName withRoomName:self.strRoomName];
    
    if ([strDevState isEqualToString:@"ON"]) {
        self.strCommanName = @"COM_LAMP_ON";
        
        NSData *strCommandData = [self.commandCtr getCommandData:self.strCommanName withDeviceName:self.strDeviceName withRoomName:self.strRoomName];
        if (strCommandData.length == 0) {
            NSLog(@"NOCommand");
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:self.title message:@"此按键还没有学习命令,正在加载数据，请稍候..." delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            alert.tag = 1;
            [alert show];
            
            self.bNeedAddBtnCommadFlag = YES;
            //TODO1:等待socket数据 将命令添加至按键对应的数据库 //TODO:NSdata
//            BOOL ret = [self.commandCtr addNewCommand:self.strCommanName withDevName:self.strDeviceName withRoomName:self.strRoomName withCommandData:nil];
//            [self.commandCtr initCommandsWithRoomName:self.strRoomName withDeviceName:self.strDeviceName];
//            NSLog(@"%d",ret);
        } else {
            
            //TODO2:将取得的commandData数据 经过socket 发送出去
            int IDnum = [self.deviceCtr getDeviceIDNumber:self.strDeviceName withRoomName:strRoomName];
            if (IDnum < 0) {
                NSLog(@"Error there is no dev");
            }
            [self.dataTrans sendData:strCommandData withDevType:@"电灯" withDevID:IDnum withCom:YES];
            NSLog(@"%@",strCommandData);
            
            //TODO3:等待socket的回复数据 是否顺利执行命令
            [_btnLampONOFF setBackgroundImage:[UIImage imageNamed:@"lamp_OFF_480_285.png"] forState:UIControlStateNormal];
            BOOL ret = [self.deviceCtr  setDeviceState:self.strDeviceName withRoomName:self.strRoomName withDeviceState:@"OFF"];
            NSLog(@"%d",ret);
        }
        
    } else {
        self.strCommanName = @"COM_LAMP_OFF";
        
        NSData *strCommandData = [self.commandCtr getCommandData:self.strCommanName withDeviceName:self.strDeviceName withRoomName:self.strRoomName];
        if (strCommandData.length == 0) {
            NSLog(@"NOCommand");
//            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:self.title message:@"此按键还没有学习命令" delegate:self cancelButtonTitle:@"取消" otherButtonTitles: nil];
//            alert.tag = 1;
//            [alert show];
            
            
            //TODO1:等待socket数据 将命令添加至按键对应的数据库
            [[[UIAlertView alloc] initWithTitle:nil message:@"正在加载数据，请稍候..." delegate:self cancelButtonTitle: @"取消" otherButtonTitles: @"确定",nil] show];
//            BOOL ret = [self.commandCtr addNewCommand:self.strCommanName withDevName:self.strDeviceName withRoomName:self.strRoomName withCommandData:@"123456"];
//            [self.commandCtr initCommandsWithRoomName:self.strRoomName withDeviceName:self.strDeviceName];
//            NSLog(@"%d",ret);
            
            self.bNeedAddBtnCommadFlag = YES;

            
        } else {
            
            //TODO2:将取得的commandData数据 经过socket 发送出去
            int IDnum = [self.deviceCtr getDeviceIDNumber:self.strDeviceName withRoomName:strRoomName];
            if (IDnum < 0) {
                NSLog(@"Error there is no dev");
            }
            [self.dataTrans sendData:strCommandData withDevType:@"电灯" withDevID:IDnum withCom:YES];
            NSLog(@"%@",strCommandData);
            
            //TODO3:等待socket的回复数据 是否顺利执行命令
            [_btnLampONOFF setBackgroundImage:[UIImage imageNamed:@"lamp_ON_480_285.png"] forState:UIControlStateNormal];
            BOOL ret = [self.deviceCtr  setDeviceState:self.strDeviceName withRoomName:self.strRoomName withDeviceState:@"ON"];
            NSLog(@"%d",ret);
        }

    }
    
    
    
    
    
}


#pragma mark----SendRecvSocketDataDelegate
-(void)recvSocketData:(NSData *)recvData
{
    
    if (self.bNeedAddBtnCommadFlag) {
        self.bNeedAddBtnCommadFlag = NO;
        NSData *comData = [recvData subdataWithRange:NSMakeRange(6, recvData.length-7)];
        
        BOOL ret = [self.commandCtr addNewCommand:self.strCommanName withDevName:self.strDeviceName withRoomName:self.strRoomName withCommandData:comData];
        [self.commandCtr initCommandsWithRoomName:self.strRoomName withDeviceName:self.strDeviceName];
        NSLog(@"%d",ret);
    }
    
}
@end
