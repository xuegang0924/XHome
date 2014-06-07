//
//  deviceMgr.m
//  XHomeDemo
//
//  Created by Gene on 14-5-11.
//  Copyright (c) 2014年 ROBOTIZE-LIFE. All rights reserved.
//

#import "deviceMgr.h"

@implementation deviceMgr


@synthesize  devicesArry;

- (id)init
{
    self = [super init];
    if (self) {
        _deviceSrc = [[deviceSource alloc] init];
        
        NSLog(@"deviceMgr init");
    }
    return self;
}

/**
 *加载数据库中的房间条目
 */
- (void)initDevices:(NSString *)whichRoomName
{
    self.devicesArry = [_deviceSrc loadDevices:whichRoomName];
}

/**
 *新增一个房间条目
 */
- (BOOL)addNewDevice:(NSString *)newDeviceName withRoomName:(NSString *)whichRoomName withDeviceType:(NSString *)deviceType
{
    return [_deviceSrc addDevice:newDeviceName withRoomName:whichRoomName withDeviceType:deviceType];
}

/**
 *更新一个房间条目
 */
- (BOOL)updateDevice:(NSString *)newDeviceName withOldDeviceName:(NSString *)oldDeviceName withRoomName:(NSString *)whichRoomName
{
    return [_deviceSrc updateDevice:newDeviceName withOldDeviceName:oldDeviceName withRoomName:whichRoomName];
}

/**
 *删除一个房间条目
 */
- (BOOL)deleteDevice:(NSString *)DeviceName withRoomName:(NSString *)whichRoomName
{
    return [_deviceSrc deleteDevice:DeviceName withRoomName:whichRoomName];
}

/**
 *得到一个设备类型
 */
- (NSString *)getDeviceType:(NSString *)DeviceName withRoomName:(NSString *)whichRoomName
{
    [self initDevices:whichRoomName];
    deviceTable *dt = [[deviceTable alloc] init];
    for (dt in self.devicesArry) {
        if ([dt.deviceName isEqualToString:DeviceName] && [dt.roomID isEqualToString:whichRoomName]) {
            return dt.deviceType;
        }
    }
    
    return nil;

}

/**
 *得到一个设备运行状态
 */
- (NSString *)getDeviceState:(NSString *)DeviceName withRoomName:(NSString *)whichRoomName
{
    [self initDevices:whichRoomName];
    deviceTable *dt = [[deviceTable alloc] init];
    
    for (dt in self.devicesArry) {
        if ([dt.deviceName isEqualToString:DeviceName] && [dt.roomID isEqualToString:whichRoomName]) {
            return dt.deviceState;
        }
    }
    
    return nil;
}



/**
 *设置一个设备运行状态
 */
- (BOOL)setDeviceState:(NSString *)DeviceName withRoomName:(NSString *)whichRoomName withDeviceState:(NSString *)deviceState
{
    
    return [_deviceSrc updateDevice:DeviceName withRoomName:whichRoomName withDevState:deviceState];
}



/**
 *获得一个设备的ID号 rowID
 */
- (int)getDeviceIDNumber:(NSString *)DeviceName withRoomName:(NSString *)whichRoomName
{
    [self initDevices:whichRoomName];
    deviceTable *dt = [[deviceTable alloc] init];
    
    for (dt in self.devicesArry) {
        if ([dt.deviceName isEqualToString:DeviceName] && [dt.roomID isEqualToString:whichRoomName]) {
            return (int)dt.rowid;
        }
    }
    
    return -1;    
}
@end
