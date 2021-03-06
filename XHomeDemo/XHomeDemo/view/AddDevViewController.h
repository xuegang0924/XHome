//
//  AddDevViewController.h
//  XHomeDemo
//
//  Created by Gene on 14-5-11.
//  Copyright (c) 2014年 ROBOTIZE-LIFE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "deviceMgr.h"
#import "roomMgr.h"
#import "ButtonTagDef.h"

@interface AddDevViewController : UIViewController<UIPickerViewDelegate,UIPickerViewDataSource>

@property(strong,nonatomic)IBOutlet UIButton *btnDeviceRoom;
@property(strong,nonatomic)IBOutlet UIButton *btnOK;
@property(strong,nonatomic)IBOutlet UIButton *btnCancle;
@property(strong,nonatomic)IBOutlet UITextField *txtfDeviceName;
@property(strong,nonatomic)UIPickerView *pkvDeviceRooms;

@property(strong,nonatomic)NSMutableArray *arryPkvRowTitleStr;
@property(strong,nonatomic)deviceMgr *deviceCtr;
@property(strong,nonatomic)roomMgr *roomCtr;
@end
