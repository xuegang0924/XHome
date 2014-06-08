//
//  commandModel.h
//  XHomeDemo
//
//  Created by Gene on 14-5-16.
//  Copyright (c) 2014年 ROBOTIZE-LIFE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "commandTable.h"

@interface commandModel : NSObject

@property(strong,nonatomic)NSMutableArray *commandMArry;//所有设备
@property(strong,nonatomic)LKDBHelper *dbHelper;

@property(strong,nonatomic)commandTable *commandTb;


//获取所有命令
-(NSMutableArray *)getCommandMArryWithRoomName:(NSString *)whichRoomName withDeviceName:(NSString *)whichDevName;

//添加一个新设备
-(BOOL)addNewCommand:(NSString *)newCommandName withDeviceName:(NSString *)whichDevName withRoomName:(NSString *)whichRoomName withCommandData:(NSData *)commandData;

//更新一个设备
-(BOOL)updateACommand:(NSString *)commandName withDeviceName:(NSString *)whichDevName withRoomName:(NSString *)whichRoomName withCommandData:(NSData *)newCommandData;
//删除一个设备
-(BOOL)deleteACommand:(NSString *)commandName  withDeviceName:(NSString *)whichDevName withRoomName:(NSString *)whichRoomName;

//添加至一个场景
-(BOOL)addToScenery:(NSString *)commandName withDeviceName:(NSString *)whichDevName withRoomName:(NSString *)whichRoomName withSceneryName:(NSString *)sceneryName;

@end
