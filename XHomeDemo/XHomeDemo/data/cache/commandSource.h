//
//  commandSource.h
//  XHomeDemo
//
//  Created by Gene on 14-5-11.
//  Copyright (c) 2014年 ROBOTIZE-LIFE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "commandModel.h"

@interface commandSource : NSObject

@property(strong,nonatomic)commandModel *commandMd;

/**
 *加载数据库中的房间条目
 */
- (NSMutableArray *)loadCommands:(NSString *)whichRoomName withDeviceName:(NSString *)whichDevName; 


/**
 *新增一个房间条目
 */
- (BOOL)addCommand:(NSString *)newCommandName withDevName:(NSString *)whichDevName withRoomName:(NSString *)whichRoomName withCommandData:(NSString *)commandData;


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
@end
