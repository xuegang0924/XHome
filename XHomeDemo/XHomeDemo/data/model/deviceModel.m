//
//  deviceModel.m
//  XHomeDemo
//
//  Created by Gene on 14-5-16.
//  Copyright (c) 2014年 ROBOTIZE-LIFE. All rights reserved.
//

#import "deviceModel.h"

@implementation deviceModel

@synthesize deviceTb;

//初始化 创建表
-(id)init
{
    self = [super init];
    if (self) {
        self.dbHelper = [LKDBHelper getUsingLKDBHelper];
        
        //创建表  会根据表的版本号  来判断具体的操作 . create table need to manually call
        [self.dbHelper createTableWithModelClass:[deviceTable class]];
        
        self.deviceTb = [[deviceTable alloc] init];
//        self.deviceTb.roomTableID = [[roomTable alloc] init];
        NSLog(@"deviceModel init");
        
    }
    return self;
}


//得到总设备
-(NSMutableArray *)getDeviceMArry:(NSString *)whichRoomName
{
    
    
    //异步搜索 所有的元素到数组中。
    NSString *sql;
    if ([whichRoomName hasPrefix:@"DEVICE_TYPE:"] == YES) {
        NSString *strDevType = [whichRoomName substringFromIndex:12];
        sql = [[NSString alloc] initWithFormat:@"deviceType = '%@'",strDevType];
    } else {
        sql = [[NSString alloc] initWithFormat:@"roomID = '%@'",whichRoomName];
    }
    
    self.deviceMArry = [self.dbHelper search:[deviceTable class] column:nil where:sql orderBy:nil offset:0 count:0];
    return  self.deviceMArry;
}

//添加一个新设备
-(BOOL)addNewDevice:(NSString *)newDeviceName withRoomName:(NSString *)whichRoomName withDeviceType:(NSString *)deviceType
{
    
    
    deviceTable *addDevTb = [[deviceTable alloc] init];
    NSMutableString *roomDeviceName = [[NSMutableString alloc] init];
    [roomDeviceName appendString:whichRoomName];
    [roomDeviceName appendString:newDeviceName];
    addDevTb.roomDevName = roomDeviceName;
    addDevTb.roomID = whichRoomName;
    addDevTb.deviceName = newDeviceName;
    addDevTb.deviceType = deviceType;
    addDevTb.deviceState = @"OFF";

    NSLog(@"rowID1:%d", addDevTb.rowid);
    BOOL ret = [self.dbHelper insertWhenNotExists:addDevTb];
    NSLog(@"rowID2:%d", addDevTb.rowid);
    return ret;
    
}

//更新一个设备
-(BOOL)updateADevice:(NSString *)newDeviceName withOldDeviceName:(NSString *)oldDeviceName  withRoomName:(NSString *)whichRoomName
{
    NSString *str = [[NSString alloc] initWithFormat:@"roomID = '%@' and deviceName = '%@'",whichRoomName,oldDeviceName];
    NSMutableArray *marryDev = [self.dbHelper search:[deviceTable class] column:nil where:str orderBy:nil offset:0 count:0];
    deviceTable *dt = [marryDev objectAtIndex:0];
    
    self.deviceTb.deviceName = newDeviceName;
    self.deviceTb.roomID = dt.roomID;
    self.deviceTb.deviceType = dt.deviceType;
    
    
    NSMutableString *roomDeviceName = [[NSMutableString alloc] init];
    [roomDeviceName appendString:whichRoomName];
    [roomDeviceName appendString:newDeviceName];
    self.deviceTb.roomDevName = roomDeviceName;
    
//    NSString *setDevRoomName = [[NSString alloc] initWithFormat:@"roomDevName='%@'",roomDeviceName];
    
    NSString *sql = [[NSString alloc] initWithFormat:@"roomID='%@' and deviceName = '%@'",whichRoomName,oldDeviceName];
    
//    BOOL ret = [self.dbHelper updateToDB:[deviceTb class] set:setDevRoomName where:sql];

    BOOL ret = [self.dbHelper updateToDB:self.deviceTb where:sql];
    
    return  ret;
}


//删除一个设备
-(BOOL)deleteADevice:(NSString *)DeviceName  withRoomName:(NSString *)whichRoomName
{
    

    NSMutableString *roomDeviceName = [[NSMutableString alloc] init];
    [roomDeviceName appendString:whichRoomName];
    [roomDeviceName appendString:DeviceName];
    NSString *sql = [[NSString alloc] initWithFormat:@"roomID = '%@' and deviceName = '%@'",whichRoomName,DeviceName ];
    
    self.deviceTb.roomDevName = roomDeviceName;
    BOOL ret = [self.dbHelper deleteWithClass:[deviceTb class] where:sql];
//    return [self.dbHelper deleteToDB:self.deviceTb];
    return ret;
}


//更新一个设备状态
-(BOOL)updateADevice:(NSString *)deviceName withRoomName:(NSString *)whichRoomName withDevState:(NSString *)deviceState
{
    NSString *str = [[NSString alloc] initWithFormat:@"roomID = '%@' and deviceName = '%@'",whichRoomName,deviceName];
    NSMutableArray *marryDev = [self.dbHelper search:[deviceTable class] column:nil where:str orderBy:nil offset:0 count:0];
    
    deviceTable *dt = [marryDev objectAtIndex:0];
    dt.deviceState = deviceState;
    
    
    NSString *sql = [[NSString alloc] initWithFormat:@"roomID='%@' and deviceName = '%@'",whichRoomName,deviceName];    
    BOOL ret = [self.dbHelper updateToDB:dt where:sql];
    return  ret;
}

@end
