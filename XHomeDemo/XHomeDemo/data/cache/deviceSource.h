//
//  deviceSource.h
//  XHomeDemo
//
//  Created by Gene on 14-5-11.
//  Copyright (c) 2014年 ROBOTIZE-LIFE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "deviceModel.h"

@interface deviceSource : NSObject

@property(strong,nonatomic)deviceModel *deviceMd;

/**
 *加载数据库中的房间条目
 */
- (NSMutableArray *)loadDevices:(NSString *)whichRoomName;


/**
 *新增一个房间条目
 */
- (BOOL)addDevice:(NSString *)newDeviceName withRoomName:(NSString *)whichRoomName withDeviveType:(NSString *)deviveType;


/**
 *更新一个房间条目
 */
- (BOOL)updateDevice:(NSString *)newDeviceName withOldDeviceName:(NSString *)oldDeviceName withRoomName:(NSString *)whichRoomName;

/**
 *删除一个房间条目
 */
- (BOOL)deleteDevice:(NSString *)DeviceName withRoomName:(NSString *)whichRoomName;
@end
