//
//  roomMgr.m
//  XHomeDemo
//
//  Created by Gene on 14-5-11.
//  Copyright (c) 2014年 ROBOTIZE-LIFE. All rights reserved.
//

#import "roomMgr.h"


@implementation roomMgr

@synthesize  roomsArry;

- (id)init
{
    self = [super init];
    if (self) {
        _roomSrc = [[roomSource alloc] init];
        
        NSLog(@"roomMgr init");
    }
    return self;
}

/**
 *加载数据库中的房间条目
 */
- (void)initRooms
{
    self.roomsArry = [_roomSrc loadRooms];
}

/**
 *新增一个房间条目
 */
- (BOOL)addNewRoom:(NSString *)newRoomName
{
    return [_roomSrc addRoom:newRoomName];
}

/**
 *更新一个房间条目
 */
- (BOOL)updateRoom:(NSString *)newRoomName withOldRoomName:(NSString *)oldRoomName
{
    return [_roomSrc updateRoom:newRoomName withOldRoomName:oldRoomName];
}

/**
 *删除一个房间条目
 */
- (BOOL)deleteRoom:(NSString *)RoomName
{
    return [_roomSrc deleteRoom:RoomName];
}

@end
