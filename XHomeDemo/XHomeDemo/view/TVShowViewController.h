//
//  TVShowViewController.h
//  XHomeDemo
//
//  Created by Gene on 14-6-4.
//  Copyright (c) 2014年 ROBOTIZE-LIFE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "commandMgr.h"

@interface TVShowViewController : UIViewController

@property(strong,nonatomic)commandMgr *commandCtr;

@property(strong,nonatomic)NSString *strRoomName;
@property(strong,nonatomic)NSString *strDeviceName;
@property(strong,nonatomic)NSString *strCommanName;


@end
