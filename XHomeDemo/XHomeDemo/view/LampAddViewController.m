//
//  LampAddViewController.m
//  XHomeDemo
//
//  Created by Gene on 14-6-3.
//  Copyright (c) 2014年 ROBOTIZE-LIFE. All rights reserved.
//

#import "LampAddViewController.h"

@interface LampAddViewController ()

@end

@implementation LampAddViewController

@synthesize btnDeviceRoom;
@synthesize btnOK;
@synthesize btnCancle;
@synthesize pkvDeviceRooms;
@synthesize txtfDeviceName;
@synthesize deviceCtr;
@synthesize arryPkvRowTitleStr;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        if (!self.deviceCtr) {
            self.deviceCtr = [[deviceMgr alloc] init];
        }
        if (!self.roomCtr) {
            self.roomCtr = [[roomMgr alloc] init];
        }
        if (!self.arryPkvRowTitleStr) {
            self.arryPkvRowTitleStr = [[NSMutableArray alloc] init];
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //初始化room
    [self.roomCtr initRooms];

    [self.arryPkvRowTitleStr addObject:@"无"];
    for (roomTable *obj in self.roomCtr.roomsArry) {
        [arryPkvRowTitleStr addObject:obj.roomName];
        NSLog(@"%@",obj.roomName);
    }
    
    
    //加入tap手势
    UITapGestureRecognizer *tapgst = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gestureRecognizerShortTouchUp:)];
    tapgst.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tapgst];
    
    self.btnDeviceRoom.tag = DEVICE_ROOM_BUTTON_TAG;
    [self.btnDeviceRoom addTarget:self action:@selector(btnShortClick:) forControlEvents:UIControlEventTouchUpInside];
    self.btnOK.tag = BUTTON_TAG_OK;
    [self.btnOK addTarget:self action:@selector(btnShortClick:) forControlEvents:UIControlEventTouchUpInside];
    self.btnCancle.tag= BUTTON_TAG_CANCLE;
    [self.btnCancle addTarget:self action:@selector(btnShortClick:) forControlEvents:UIControlEventTouchUpInside];
}


- (void)btnShortClick:(UIButton *)sender
{
    if (sender.tag == DEVICE_ROOM_BUTTON_TAG) { //选择设备类型
        //取消键盘
        [self.txtfDeviceName resignFirstResponder];
        if (self.pkvDeviceRooms == nil) {
            self.pkvDeviceRooms = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 580, 320, 460)];
            self.pkvDeviceRooms.delegate = self;
            self.pkvDeviceRooms.dataSource = self;
            //        self.pkvDeviceType.showsSelectionIndicator = YES;
            self.pkvDeviceRooms.backgroundColor = [UIColor whiteColor];
            [self.view addSubview:self.pkvDeviceRooms];
        }
        [UIView beginAnimations: @"Animation" context:nil];
        [UIView setAnimationDuration:0.3];
        self.pkvDeviceRooms.frame = CGRectMake(0, 380, 320, 552);
        [UIView commitAnimations];
    } else if (sender.tag == BUTTON_TAG_OK) {   //确定按钮
        //1.拿到房间名，设备名字
        NSString *devRoom = [[NSString alloc] initWithString:self.btnDeviceRoom.titleLabel.text];
        NSString *devName = [[NSString alloc] initWithString:self.txtfDeviceName.text];
        
        if ([devRoom isEqualToString:@"无"] == NO && [devRoom isEqualToString:@"点击此处选择要把设备加入的房间"] == NO) {
            if (devName.length != 0) {
                
                //2.添加到数据库
                NSString *str = self.title;
                BOOL ret = [self.deviceCtr addNewDevice:devName withRoomName:devRoom withDeviceType:str];
                if (ret) {
                    //3.添加成功提示框
                    [[[UIAlertView alloc] initWithTitle:@"成功" message:@"已经成功添加新设备" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil] show];
                } else {
                    [[[UIAlertView alloc] initWithTitle:@"失败" message:@"同名的设备已经存在！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil] show];
                }
                
            } else {
                [[[UIAlertView alloc] initWithTitle:@"错误" message:@"请输入设备名称" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil] show];
            }
            
        } else {
            [[[UIAlertView alloc] initWithTitle:@"错误" message:@"请选择要添加的房间" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil] show];
        }
        
        
    }else if (sender.tag == BUTTON_TAG_CANCLE) {    //取消按钮
        //直接返回到上一层view
        //        RoomsDetailViewController *rdvc = [[RoomsDetailViewController alloc] init];
        [self.navigationController popViewControllerAnimated:YES];
        
    }
}

//tap手势相应函数
-(void)gestureRecognizerShortTouchUp:(UIGestureRecognizer *)sender
{
    //取消pickerView
    if (self.pkvDeviceRooms) {
        [UIView beginAnimations: @"Animation" context:nil];
        [UIView setAnimationDuration:0.3];
        self.pkvDeviceRooms.frame = CGRectMake(0, 580, 320, 552);
        [UIView commitAnimations];
    }
    
    //取消键盘
    [self.txtfDeviceName resignFirstResponder];
}


#pragma mark pickerView delegate

//返回pickerview的组件数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
    return 1;
}

//返回每个组件上的行数
- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
	
    //查询room的条数
    
    return self.arryPkvRowTitleStr.count;
    
}

//设置每行显示的内容
- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    return [self.arryPkvRowTitleStr objectAtIndex:row];

}

//当你选中pickerview的某行时会调用该函数
- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSLog(@"You select row %ld",(long)row);
    [self.btnDeviceRoom setTitle:[self.arryPkvRowTitleStr objectAtIndex:row] forState:UIControlStateNormal];
}


@end
