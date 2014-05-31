//
//  roomSource.h
//  XHomeDemo
//
//  Created by Gene on 14-5-11.
//  Copyright (c) 2014年 ROBOTIZE-LIFE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "roomModel.h"

@interface roomSource : NSObject

@property(strong,nonatomic)roomModel *roomMd;

/**
 *加载数据库中的房间条目
 */
- (NSMutableArray *)loadRooms;


/**
 *新增一个房间条目
 */
- (BOOL)addRoom:(NSString *)newRoomName;


/**
 *更新一个房间条目
 */
- (BOOL)updateRoom:(NSString *)newRoomName withOldRoomName:(NSString *)oldRoomName;

/**
 *删除一个房间条目
 */
- (BOOL)deleteRoom:(NSString *)RoomName;
@end
