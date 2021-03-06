//
//  RoomsAddDevViewController.m
//  XHomeDemo
//
//  Created by Gene on 14-5-30.
//  Copyright (c) 2014年 ROBOTIZE-LIFE. All rights reserved.
//

#import "RoomsAddDevViewController.h"

@interface RoomsAddDevViewController ()

@end


@implementation RoomsAddDevViewController

@synthesize btnDeviceType;
@synthesize btnOK;
@synthesize btnCancle;
@synthesize pkvDeviceType;
@synthesize txtfDeviceName;
@synthesize deviceCtr;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        if (!self.deviceCtr) {
            self.deviceCtr = [[deviceMgr alloc] init];
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//加入tap手势
    UITapGestureRecognizer *tapgst = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gestureRecognizerShortTouchUp:)];
    tapgst.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tapgst];
    
    self.btnDeviceType.tag = DEVICE_TYPE_BUTTON_TAG;
    [self.btnDeviceType addTarget:self action:@selector(btnShortClick:) forControlEvents:UIControlEventTouchUpInside];
    self.btnOK.tag = BUTTON_TAG_OK;
    [self.btnOK addTarget:self action:@selector(btnShortClick:) forControlEvents:UIControlEventTouchUpInside];
    self.btnCancle.tag= BUTTON_TAG_CANCLE;
    [self.btnCancle addTarget:self action:@selector(btnShortClick:) forControlEvents:UIControlEventTouchUpInside];
}


- (void)btnShortClick:(UIButton *)sender
{
    if (sender.tag == DEVICE_TYPE_BUTTON_TAG) { //选择设备类型
        //取消键盘
        [self.txtfDeviceName resignFirstResponder];
        if (self.pkvDeviceType == nil) {
            self.pkvDeviceType = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 580, 320, 460)];
            self.pkvDeviceType.delegate = self;
            self.pkvDeviceType.dataSource = self;
    //        self.pkvDeviceType.showsSelectionIndicator = YES;
            self.pkvDeviceType.backgroundColor = [UIColor whiteColor];
    //        pkvDeviceType.alpha = 1.0f;
            [self.view addSubview:self.pkvDeviceType];
            //            [pickerView release];
        }
        [UIView beginAnimations: @"Animation" context:nil];
        [UIView setAnimationDuration:0.3];
        self.pkvDeviceType.frame = CGRectMake(0, 380, 320, 552);
        [UIView commitAnimations];
    } else if (sender.tag == BUTTON_TAG_OK) {   //确定按钮
        //1.拿到设备类型，设备名字
        NSString *devType = [[NSString alloc] initWithString:self.btnDeviceType.titleLabel.text];
        NSString *devName = [[NSString alloc] initWithString:self.txtfDeviceName.text];

        if ([devType isEqualToString:@"无"] == NO && [devType isEqualToString:@"点击此处选择设备类型"] == NO) {
            if (devName.length != 0) {
                
                //2.添加到数据库
                BOOL ret = [self.deviceCtr addNewDevice:devName withRoomName:self.title withDeviceType:devType];
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
            [[[UIAlertView alloc] initWithTitle:@"错误" message:@"请选择设备类型" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil] show];
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
    if (self.pkvDeviceType) {
        [UIView beginAnimations: @"Animation" context:nil];
        [UIView setAnimationDuration:0.3];
        self.pkvDeviceType.frame = CGRectMake(0, 580, 320, 552);
        [UIView commitAnimations];
    }
    
    //取消键盘
    [self.txtfDeviceName resignFirstResponder];
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





#pragma mark pickerView delegate

//返回pickerview的组件数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
    return 1;
}

//返回每个组件上的行数
- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
	
    return 9;
    
}

//设置每行显示的内容
- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    NSArray *arryTitleString = [[NSArray alloc] initWithObjects:@"无",@"红外控制器",@"电视",@"空调",@"电灯",@"插座",@"窗帘",@"摄像头",@"其他", nil];
    return [arryTitleString objectAtIndex:row];
    
    /*
     无，
     红外控制器，
     电视，
     空调，
     电灯，
     插座，
     窗帘，
     摄像头，
     其他
     */
}

//当你选中pickerview的某行时会调用该函数
- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSLog(@"You select row %ld",(long)row);
    NSArray *arryTitleString = [[NSArray alloc] initWithObjects:@"无",@"红外控制器",@"电视",@"空调",@"电灯",@"插座",@"窗帘",@"摄像头",@"其他", nil];
    [self.btnDeviceType setTitle:[arryTitleString objectAtIndex:row] forState:UIControlStateNormal];
}




@end
