//
//  RoomsAddViewController.h
//  XHomeDemo
//
//  Created by Gene on 14-5-15.
//  Copyright (c) 2014年 ROBOTIZE-LIFE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "roomMgr.h"
#import "RoomsViewController.h"

@interface RoomsAddViewController : UIViewController

@property(strong,nonatomic) IBOutlet UITextField *tfNewRoomName;
//@property(strong,nonatomic) IBOutlet UIButton *btAddNewRoom;
//@property(strong,nonatomic) IBOutlet UIButton *btUpdateRoom;
//@property(strong,nonatomic) IBOutlet UIButton *btDeleteRoom;
@property(strong,nonatomic)roomMgr *roomCtr;

@end
