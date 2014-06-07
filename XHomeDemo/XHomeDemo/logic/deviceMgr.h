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
 *加载数据库中的设备条目
 */
- (void)initDevices:(NSString *)whichRoomName;

/**
 *新增一个设备条目
 */
- (BOOL)addNewDevice:(NSString *)newDeviceName withRoomName:(NSString *)whichRoomName withDeviceType:(NSString *)deviceType;

/**
 *更新一个设备条目
 */
- (BOOL)updateDevice:(NSString *)newDeviceName withOldDeviceName:(NSString *)oldDeviceName withRoomName:(NSString *)whichRoomName;

/**
 *删除一个设备条目
 */
- (BOOL)deleteDevice:(NSString *)DeviceName withRoomName:(NSString *)whichRoomName;

/**
 *得到一个设备类型
 */
- (NSString *)getDeviceType:(NSString *)DeviceName withRoomName:(NSString *)whichRoomName;

/**
 *得到一个设备运行状态
 */
- (NSString *)getDeviceState:(NSString *)DeviceName withRoomName:(NSString *)whichRoomName;

/**
 *设置一个设备运行状态
 */
- (BOOL)setDeviceState:(NSString *)DeviceName withRoomName:(NSString *)whichRoomName withDeviceState:(NSString *)deviceState;

/**
 *获得一个设备的ID号 rowID
 */
- (int)getDeviceIDNumber:(NSString *)DeviceName withRoomName:(NSString *)whichRoomName;

@end
