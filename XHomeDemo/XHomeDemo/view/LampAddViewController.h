//
//  LampAddViewController.h
//  XHomeDemo
//
//  Created by Gene on 14-6-3.
//  Copyright (c) 2014年 ROBOTIZE-LIFE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "deviceMgr.h"
#import "roomMgr.h"
#import "ButtonTagDef.h"

@interface LampAddViewController : UIViewController<UIPickerViewDelegate,UIPickerViewDataSource>

@property(strong,nonatomic)IBOutlet UIButton *btnDeviceRoom;
@property(strong,nonatomic)IBOutlet UIButton *btnOK;
@property(strong,nonatomic)IBOutlet UIButton *btnCancle;
@property(strong,nonatomic)IBOutlet UITextField *txtfDeviceName;
@property(strong,nonatomic)UIPickerView *pkvDeviceRooms;

@property(strong,nonatomic)NSMutableArray *arryPkvRowTitleStr;
@property(strong,nonatomic)deviceMgr *deviceCtr;
@property(strong,nonatomic)roomMgr *roomCtr;
@end
