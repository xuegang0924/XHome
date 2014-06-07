//
//  commandSource.m
//  XHomeDemo
//
//  Created by Gene on 14-5-11.
//  Copyright (c) 2014年 ROBOTIZE-LIFE. All rights reserved.
//

#import "commandSource.h"

@implementation commandSource

- (id)init
{
    self = [super init];
    if (self) {
        _commandMd = [[commandModel alloc] init];
        NSLog(@"deviceCache init");
    }
    return self;
}

/**
 *加载数据库中的房间条目
 */
- (NSMutableArray *)loadCommands:(NSString *)whichRoomName withDeviceName:(NSString *)whichDevName
{
    return [_commandMd getCommandMArryWithRoomName:whichRoomName withDeviceName:whichDevName];
}


/**
 *新增一个房间条目
 */
- (BOOL)addCommand:(NSString *)newCommandName withDevName:(NSString *)whichDevName withRoomName:(NSString *)whichRoomName withCommandData:(NSString *)commandData
{
    return [_commandMd addNewCommand:newCommandName withDeviceName:whichDevName withRoomName:whichRoomName withCommandData:commandData];
}


/**
 *更新一个房间条目
 */
- (BOOL)updateCommand:(NSString *)commandName withDevName:(NSString *)whichDevName withRoomName:(NSString *)whichRoomName withCommandData:(NSString *)newCommandData
{
    return [_commandMd updateACommand:commandName withDeviceName:whichDevName withRoomName:whichRoomName withCommandData:newCommandData];
}

/**
 *删除一个房间条目
 */
- (BOOL)deleteCommand:(NSString *)commandName withDeviceName:(NSString *)whichDevName withRoomName:(NSString *)whichRoomName
{
    return [_commandMd deleteACommand:commandName withDeviceName:whichDevName withRoomName:whichRoomName];
}

//添加至一个场景
- (BOOL)addToScenery:(NSString *)commandName withDeviceName:(NSString *)whichDevName withRoomName:(NSString *)whichRoomName withSceneryName:(NSString *)sceneryName
{
    return [_commandMd addToScenery:commandName withDeviceName:whichDevName withRoomName:whichRoomName withSceneryName:sceneryName];
}
@end
