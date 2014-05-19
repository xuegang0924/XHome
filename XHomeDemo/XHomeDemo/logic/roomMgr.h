//
//  roomMgr.h
//  XHomeDemo
//
//  Created by Gene on 14-5-11.
//  Copyright (c) 2014年 ROBOTIZE-LIFE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "roomSource.h"

@interface roomMgr : NSObject

@property(strong,nonatomic)roomSource *roomSrc;
@property(strong,nonatomic)NSMutableArray *roomsArry;

/**
 *加载数据库中的房间条目
 */
- (void)initRooms;

/**
 *新增一个房间条目
 */
- (BOOL)addNewRoom:(NSString *)newRoomName;

@end
