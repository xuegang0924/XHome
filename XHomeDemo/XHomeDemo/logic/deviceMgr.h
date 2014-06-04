//
//  deviceMgr.h
//  XHomeDemo
//
//  Created by Gene on 14-5-11.
//  Copyright (c) 2014年 ROBOTIZE-LIFE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "deviceSource.h"

@interface deviceMgr : NSObject


@property(strong,nonatomic)deviceSource *deviceSrc;
@property(strong,nonatomic)NSMutableArray *devicesArry;

/**
 *加载数据库中的房间条目
 */
- (void)initDevices:(NSString *)whichRoomName;

/**
 *新增一个房间条目
 */
- (BOOL)addNewDevice:(NSString *)newDeviceName withRoomName:(NSString *)whichRoomName withDeviceType:(NSString *)deviceType;

/**
 *更新一个房间条目
 */
- (BOOL)updateDevice:(NSString *)newDeviceName withOldDeviceName:(NSString *)oldDeviceName withRoomName:(NSString *)whichRoomName;

/**
 *删除一个房间条目
 */
- (BOOL)deleteDevice:(NSString *)DeviceName withRoomName:(NSString *)whichRoomName;

@end
