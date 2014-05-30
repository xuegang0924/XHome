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

    NSString *sql = [[NSString alloc] initWithFormat:@"roomID = '%@'",whichRoomName];
    self.deviceMArry = [self.dbHelper search:[deviceTable class] column:nil where:sql orderBy:nil offset:0 count:0];
    return  self.deviceMArry;
}

//添加一个新设备
-(BOOL)addNewDevice:(NSString *)newDeviceName withRoomName:(NSString *)whichRoomName withDeviveType:(NSString *)deviveType
{

    
//    NSMutableString *roomDeviceName = [[NSMutableString alloc] init];
//    [roomDeviceName appendString:whichRoomName];
//    [roomDeviceName appendString:newDeviceName];
//    self.deviceTb.roomDevName = roomDeviceName;
//    
//    self.deviceTb.deviceName = newDeviceName;
//    self.deviceTb.roomID = whichRoomName;
////    roomTable *rt = [[roomTable alloc] init];
////    rt.roomName = whichRoomName;
////    self.deviceTb.roomTableID = rt;
//    
//    self.deviceMArry = [self.dbHelper search:[deviceTable class] column:nil where:nil orderBy:nil offset:0 count:0];
//    NSLog(@"rowID1:%d", self.deviceTb.rowid);
//    BOOL ret = [self.dbHelper insertWhenNotExists:self.deviceTb];
////    BOOL ret = [self.dbHelper insertToDB:self.deviceTb];
//    NSLog(@"rowID2:%d", self.deviceTb.rowid);
//    return ret;
    
    
    deviceTable *addDevTb = [[deviceTable alloc] init];
    NSMutableString *roomDeviceName = [[NSMutableString alloc] init];
    [roomDeviceName appendString:whichRoomName];
    [roomDeviceName appendString:newDeviceName];
    addDevTb.roomDevName = roomDeviceName;
    addDevTb.roomID = whichRoomName;
    addDevTb.deviceName = newDeviceName;

    NSLog(@"rowID1:%d", addDevTb.rowid);
    BOOL ret = [self.dbHelper insertWhenNotExists:addDevTb];
    NSLog(@"rowID2:%d", addDevTb.rowid);
    return ret;
    
}

//更新一个设备
-(BOOL)updateADevice:(NSString *)newDeviceName withOldDeviceName:(NSString *)oldDeviceName  withRoomName:(NSString *)whichRoomName
{
  
    
    self.deviceTb.deviceName = newDeviceName;
    self.deviceTb.roomID = whichRoomName;
    
    
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


@end
