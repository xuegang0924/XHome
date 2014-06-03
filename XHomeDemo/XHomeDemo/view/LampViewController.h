//
//  LampViewController.h
//  XHomeDemo
//
//  Created by Gene on 14-5-11.
//  Copyright (c) 2014年 ROBOTIZE-LIFE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "deviceMgr.h"
#import "ButtonTagDef.h"
#import "LampAddViewController.h"
#import "AddDevViewController.h"

@interface LampViewController : UIViewController<UIAlertViewDelegate>

@property(strong,nonatomic)deviceMgr *deviceCtr;

@end
