//
//  commandMgr.m
//  XHomeDemo
//
//  Created by Gene on 14-5-11.
//  Copyright (c) 2014年 ROBOTIZE-LIFE. All rights reserved.
//

#import "commandMgr.h"

@implementation commandMgr

@synthesize  commandsArry;

- (id)init
{
    self = [super init];
    if (self) {
        _commandSrc = [[commandSource alloc] init];
        
        NSLog(@"commandMgr init");
    }
    return self;
}

/**
 *加载数据库中的房间条目
 */
- (void)initCommandsWithRoomName:(NSString *)whichRoomName withDeviceName:(NSString *)whichDevName
{
    self.commandsArry =  [_commandSrc loadCommands:whichRoomName withDeviceName:whichDevName];
}


/**
 *新增一个房间条目
 */
- (BOOL)addNewCommand:(NSString *)newCommandName withDevName:(NSString *)whichDevName withRoomName:(NSString *)whichRoomName withCommandData:(NSString *)commandData
{
    return [_commandSrc addCommand:newCommandName withDevName:whichDevName withRoomName:whichRoomName withCommandData:commandData];

}


/**
 *更新一个房间条目
 */
- (BOOL)updateCommand:(NSString *)commandName withDevName:(NSString *)whichDevName withRoomName:(NSString *)whichRoomName withCommandData:(NSString *)newCommandData
{
    return [_commandSrc updateCommand:commandName withDevName:whichDevName withRoomName:whichRoomName withCommandData:newCommandData];

}

/**
 *删除一个房间条目
 */
- (BOOL)deleteCommand:(NSString *)commandName withDeviceName:(NSString *)whichDevName withRoomName:(NSString *)whichRoomName
{
    return [_commandSrc deleteCommand:commandName withDeviceName:whichDevName withRoomName:whichRoomName];

}

//添加至一个场景
- (BOOL)addToScenery:(NSString *)commandName withDeviceName:(NSString *)whichDevName withRoomName:(NSString *)whichRoomName withSceneryName:(NSString *)sceneryName
{
    return [_commandSrc addToScenery:commandName withDeviceName:whichDevName withRoomName:whichRoomName withSceneryName:sceneryName];
}

/**
 *得到设备上某个按钮对应的命令数据
 */
- (NSString *)getCommandData:(NSString *)commandName withDeviceName:(NSString *)whichDevName withRoomName:(NSString *)whichRoomName
{
    commandTable *ct = [[commandTable alloc] init];
    for (ct in self.commandsArry) {
        if ([ct.commandName isEqualToString:commandName] && [ct.commandDevice isEqualToString:whichDevName] && [ct.commandRoom isEqualToString:whichRoomName]) {
            return ct.commandCode;
        }
    }
    
    return nil;
}

@end
