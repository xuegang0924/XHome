//
//  RoomsDetailViewController.h
//  XHomeDemo
//
//  Created by Gene on 14-5-21.
//  Copyright (c) 2014年 ROBOTIZE-LIFE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RoomsAddDevViewController.h"
#import "deviceMgr.h"
#import "LampShowViewController.h"
#import "TVShowViewController.h"
#import "AirconShowViewController.h"
#import "SocShowViewController.h"
#import "CuttainShowViewController.h"
#import "WebcamShowViewController.h"

@interface RoomsDetailViewController : UIViewController

@property(strong,nonatomic)deviceMgr *deviceCtr;

@end
