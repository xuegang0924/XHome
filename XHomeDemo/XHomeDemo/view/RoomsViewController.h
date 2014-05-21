//
//  RoomsViewController.h
//  XHomeDemo
//
//  Created by Gene on 14-5-11.
//  Copyright (c) 2014年 ROBOTIZE-LIFE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RoomsAddViewController.h"
#import "RoomsDetailViewController.h"
#import "roomMgr.h"
#import "ButtonTagDef.h"


@interface RoomsViewController : UIViewController <UIAlertViewDelegate>

@property(strong,nonatomic)roomMgr *roomCtr;

@end
