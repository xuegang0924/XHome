//
//  RoomsAddDevViewController.h
//  XHomeDemo
//
//  Created by Gene on 14-5-30.
//  Copyright (c) 2014年 ROBOTIZE-LIFE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ButtonTagDef.h"
#import "deviceMgr.h"
#import "RoomsDetailViewController.h"

@interface RoomsAddDevViewController : UIViewController<UIPickerViewDelegate,UIPickerViewDataSource>

@property(strong,nonatomic)IBOutlet UIButton *btnDeviceType;
@property(strong,nonatomic)IBOutlet UIButton *btnOK;
@property(strong,nonatomic)IBOutlet UIButton *btnCancle;


@property(strong,nonatomic)IBOutlet UITextField *txtfDeviceName;
@property(strong,nonatomic)UIPickerView *pkvDeviceType;

@property(strong,nonatomic)deviceMgr *deviceCtr;

@end
