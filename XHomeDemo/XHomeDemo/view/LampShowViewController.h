//
//  LampShowViewController.h
//  XHomeDemo
//
//  Created by Gene on 14-6-4.
//  Copyright (c) 2014年 ROBOTIZE-LIFE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "commandMgr.h"
#import "deviceMgr.h"

@interface LampShowViewController : UIViewController

@property(strong,nonatomic)commandMgr *commandCtr;
@property(strong,nonatomic)deviceMgr *deviceCtr;

@property(strong,nonatomic)NSString *strDeviceName;
@property(strong,nonatomic)NSString *strCommanName;
@property(strong,nonatomic)NSString *strRoomName;

@end
