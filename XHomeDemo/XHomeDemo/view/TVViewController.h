//
//  TVViewController.h
//  XHomeDemo
//
//  Created by Gene on 14-5-11.
//  Copyright (c) 2014年 ROBOTIZE-LIFE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "deviceMgr.h"
#import "ButtonTagDef.h"
#import "AddDevViewController.h"
#import "TVShowViewController.h"


@interface TVViewController : UIViewController<UIAlertViewDelegate>

@property(strong,nonatomic)deviceMgr *deviceCtr;

@end
