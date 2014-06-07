//
//  deviceSource.m
//  XHomeDemo
//
//  Created by Gene on 14-5-11.
//  Copyright (c) 2014年 ROBOTIZE-LIFE. All rights reserved.
//

#import "deviceSource.h"

@implementation deviceSource




- (id)init
{
    self = [super init];
    if (self) {
        _deviceMd = [[deviceModel alloc] init];
        NSLog(@"deviceCache init");
    }
    return self;
}

/**
 *加载数据库中的房间条目
 */
- (NSMutableArray *)loadDevices:(NSString *)whichRoomName
{
    
    return  [_deviceMd getDeviceMArry:whichRoomName];
}

/**
 *新增一个房间条目
 */
- (BOOL)addDevice:(NSString *)newDeviceName withRoomName:(NSString *)whichRoomName withDeviceType:(NSString *)deviceType
{
    return [_deviceMd addNewDevice:newDeviceName withRoomName:whichRoomName withDeviceType:deviceType];
}


/**
 *更新一个房间条目
 */
- (BOOL)updateDevice:(NSString *)newDeviceName withOldDeviceName:(NSString *)oldDeviceName withRoomName:(NSString *)whichRoomName
{
    return [_deviceMd updateADevice:newDeviceName withOldDeviceName:oldDeviceName withRoomName:whichRoomName];
}

/**
 *删除一个房间条目
 */
- (BOOL)deleteDevice:(NSString *)DeviceName withRoomName:(NSString *)whichRoomName
{
    return [_deviceMd deleteADevice:DeviceName withRoomName:whichRoomName];
}

/**
 *更新一个设备的状态
 */
- (BOOL)updateDevice:(NSString *)deviceName withRoomName:(NSString *)whichRoomName withDevState:(NSString *)deviceState
{
    return [_deviceMd updateADevice:deviceName withRoomName:whichRoomName withDevState:deviceState];
}

@end
