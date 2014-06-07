//
//  commandModel.m
//  XHomeDemo
//
//  Created by Gene on 14-5-16.
//  Copyright (c) 2014年 ROBOTIZE-LIFE. All rights reserved.
//

#import "commandModel.h"

@implementation commandModel

@synthesize commandTb;

//初始化 创建表
-(id)init
{
    self = [super init];
    if (self) {
        self.dbHelper = [LKDBHelper getUsingLKDBHelper];
        
        //创建表  会根据表的版本号  来判断具体的操作 . create table need to manually call
        [self.dbHelper createTableWithModelClass:[commandTable class]];
        
        self.commandTb = [[commandTable alloc] init];
        //        self.deviceTb.roomTableID = [[roomTable alloc] init];
        NSLog(@"commandModel init");
        
    }
    return self;
}

//获取所有命令
-(NSMutableArray *)getCommandMArryWithRoomName:(NSString *)whichRoomName withDeviceName:(NSString *)whichDevName
{
    //异步搜索 所有的元素到数组中。
//    NSString *sql;
//    if ([whichRoomName hasPrefix:@"DEVICE_TYPE:"] == YES) {
//        NSString *strDevType = [whichRoomName substringFromIndex:12];
//        sql = [[NSString alloc] initWithFormat:@"deviceType = '%@'",strDevType];
//    } else {
//        sql = [[NSString alloc] initWithFormat:@"roomID = '%@'",whichRoomName];
//    }
    
    self.commandMArry = [self.dbHelper search:[commandTable class] column:nil where:nil orderBy:nil offset:0 count:0];
    return  self.commandMArry;
}

//添加一个新设备
-(BOOL)addNewCommand:(NSString *)newCommandName withDeviceName:(NSString *)whichDevName withRoomName:(NSString *)whichRoomName withCommandData:(NSString *)commandData
{
    
    NSMutableString *roomDeviceCommand = [[NSMutableString alloc] init];
    [roomDeviceCommand appendString:whichRoomName];
    [roomDeviceCommand appendString:whichDevName];
    [roomDeviceCommand appendString:newCommandName];
    
    commandTable *addComTb = [[commandTable alloc] init];
    addComTb.commandName = newCommandName;
    addComTb.commandDevice = whichDevName;
    addComTb.commandRoom = whichRoomName;
    addComTb.commandCode = commandData;
    addComTb.commandScenery = nil;
    addComTb.roomDeviceCommand = roomDeviceCommand;
    
    if (addComTb.commandCode.length == 0) {
            addComTb.hasCommand = NO;
    } else {
        
            addComTb.hasCommand = YES;
    }
    
    
    return [self.dbHelper insertWhenNotExists:addComTb];
}

//更新一个设备
-(BOOL)updateACommand:(NSString *)commandName withDeviceName:(NSString *)whichDevName withRoomName:(NSString *)whichRoomName withCommandData:(NSString *)newCommandData
{
    NSString *str = [[NSString alloc] initWithFormat:@"commandRoom = '%@' and commandDevice = '%@' and commandName = '%@'",whichRoomName,whichDevName,commandName];
    NSMutableArray *marryCom = [self.dbHelper search:[commandTable class] column:nil where:str orderBy:nil offset:0 count:0];
    commandTable *dt = [marryCom objectAtIndex:0];
    
    self.commandTb.commandCode = newCommandData;
    
    self.commandTb.commandName = dt.commandName;
    self.commandTb.commandDevice = dt.commandDevice;
    self.commandTb.commandRoom = dt.commandRoom;
    self.commandTb.commandScenery = dt.commandScenery;
    self.commandTb.roomDeviceCommand = dt.roomDeviceCommand;
    self.commandTb.hasCommand = dt.hasCommand;
    
    if (self.commandTb.commandCode.length == 0) {
        self.commandTb.hasCommand = NO;
    } else {
        
        self.commandTb.hasCommand = YES;
    }
    
    NSString *sql = [[NSString alloc] initWithFormat:@"commandRoom = '%@' and commandDevice = '%@' and commandName = '%@'",whichRoomName,whichDevName,commandName];
    
    BOOL ret = [self.dbHelper updateToDB:self.commandTb where:sql];
    return  ret;
}


//删除一个设备
-(BOOL)deleteACommand:(NSString *)commandName  withDeviceName:(NSString *)whichDevName withRoomName:(NSString *)whichRoomName
{
    NSMutableString *roomDeviceCommand = [[NSMutableString alloc] init];
    [roomDeviceCommand appendString:whichRoomName];
    [roomDeviceCommand appendString:whichDevName];
    [roomDeviceCommand appendString:commandName];
    
    NSString *sql = [[NSString alloc] initWithFormat:@"commandRoom = '%@' and commandDevice = '%@' and commandName = '%@'",whichRoomName,whichDevName,commandName];
    
    self.commandTb.roomDeviceCommand = roomDeviceCommand;
    BOOL ret = [self.dbHelper deleteWithClass:[commandTable class] where:sql];
    return ret;
}

//添加至一个场景
-(BOOL)addToScenery:(NSString *)commandName withDeviceName:(NSString *)whichDevName withRoomName:(NSString *)whichRoomName withSceneryName:(NSString *)sceneryName
{
    NSString *str = [[NSString alloc] initWithFormat:@"commandRoom = '%@' and commandDevice = '%@' and commandName = '%@'",whichRoomName,whichDevName,commandName];
    NSMutableArray *marryCom = [self.dbHelper search:[commandTable class] column:nil where:str orderBy:nil offset:0 count:0];
    commandTable *dt = [marryCom objectAtIndex:0];
    
    self.commandTb.commandCode = dt.commandCode;
    
    self.commandTb.commandName = dt.commandName;
    self.commandTb.commandDevice = dt.commandDevice;
    self.commandTb.commandRoom = dt.commandRoom;
    self.commandTb.commandScenery = sceneryName;
    self.commandTb.roomDeviceCommand = dt.roomDeviceCommand;
    self.commandTb.hasCommand = dt.hasCommand;
    
    
    NSString *sql = [[NSString alloc] initWithFormat:@"commandRoom = '%@' and commandDevice = '%@' and commandName = '%@'",whichRoomName,whichDevName,commandName];
    
    BOOL ret = [self.dbHelper updateToDB:self.commandTb where:sql];
    return  ret;
}

@end
