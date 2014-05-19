//
//  roomSource.m
//  XHomeDemo
//
//  Created by Gene on 14-5-11.
//  Copyright (c) 2014年 ROBOTIZE-LIFE. All rights reserved.
//

#import "roomSource.h"

@implementation roomSource

- (id)init
{
    self = [super init];
    if (self) {
        _roomMd = [[roomModel alloc] init];
        NSLog(@"roomCache init");
    }
    return self;
}

/**
 *加载数据库中的房间条目
 */
- (NSMutableArray *)loadRooms
{
    
    return  [_roomMd getRoomMArry];
}

/**
 *新增一个房间条目
 */
- (BOOL)addRoom:(NSString *)newRoomName
{
    return [_roomMd addNewRoom:newRoomName];
}
@end
