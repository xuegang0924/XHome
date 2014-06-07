//
//  commandMgr.h
//  XHomeDemo
//
//  Created by Gene on 14-5-11.
//  Copyright (c) 2014年 ROBOTIZE-LIFE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "commandSource.h"

@interface commandMgr : NSObject

@property(strong,nonatomic)commandSource *commandSrc;
@property(strong,nonatomic)NSMutableArray *commandsArry;


/**
 *加载数据库中的房间条目
 */
- (void)initCommandsWithRoomName:(NSString *)whichRoomName withDeviceName:(NSString *)whichDevName;


/**
 *新增一个房间条目
 */
- (BOOL)addNewCommand:(NSString *)newCommandName withDevName:(NSString *)whichDevName withRoomName:(NSString *)whichRoomName withCommandData:(NSString *)commandData;


/**
 *更新一个房间条目
 */
- (BOOL)updateCommand:(NSString *)commandName withDevName:(NSString *)whichDevName withRoomName:(NSString *)whichRoomName withCommandData:(NSString *)newCommandData;

/**
 *删除一个房间条目
 */
- (BOOL)deleteCommand:(NSString *)commandName withDeviceName:(NSString *)whichDevName withRoomName:(NSString *)whichRoomName;

//添加至一个场景
- (BOOL)addToScenery:(NSString *)commandName withDeviceName:(NSString *)whichDevName withRoomName:(NSString *)whichRoomName withSceneryName:(NSString *)sceneryName;

/**
 *得到设备上某个按钮对应的命令数据
 */
- (NSString *)getCommandData:(NSString *)commandName withDeviceName:(NSString *)whichDevName withRoomName:(NSString *)whichRoomName;

@end
