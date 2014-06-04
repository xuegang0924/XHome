//
//  deviceModel.h
//  XHomeDemo
//
//  Created by Gene on 14-5-16.
//  Copyright (c) 2014年 ROBOTIZE-LIFE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "deviceTable.h"

@interface deviceModel : NSObject

@property(strong,nonatomic)NSMutableArray *deviceMArry;//所有设备
@property(strong,nonatomic)LKDBHelper *dbHelper;

@property(strong,nonatomic)deviceTable *deviceTb;


-(NSMutableArray *)getDeviceMArry:(NSString *)whichRoomName;

//添加一个新设备
-(BOOL)addNewDevice:(NSString *)newDeviceName withRoomName:(NSString *)whichRoomName withDeviceType:(NSString *)deviceType;

//更新一个设备
-(BOOL)updateADevice:(NSString *)newDeviceName withOldDeviceName:(NSString *)oldDeviceName  withRoomName:(NSString *)whichRoomName;

//删除一个设备
-(BOOL)deleteADevice:(NSString *)DeviceName  withRoomName:(NSString *)whichRoomName;

@end
