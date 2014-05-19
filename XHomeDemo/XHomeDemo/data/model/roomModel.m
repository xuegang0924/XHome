//
//  roomModel.m
//  XHomeDemo
//
//  Created by Gene on 14-5-16.
//  Copyright (c) 2014年 ROBOTIZE-LIFE. All rights reserved.
//

#import "roomModel.h"

@implementation roomModel

//初始化 创建表
-(id)init
{
    self = [super init];
    if (self) {
        self.dbHelper = [LKDBHelper getUsingLKDBHelper];
        
        //创建表  会根据表的版本号  来判断具体的操作 . create table need to manually call
        [self.dbHelper createTableWithModelClass:[roomTable class]];
        
        NSLog(@"roomModel init");
        
    }
    return self;
}


//得到总房间
-(NSMutableArray *)getRoomMArry
{

    
    //异步搜索 所有的元素到数组中。
    [self.dbHelper search:[roomTable class] where:nil orderBy:nil offset:0 count:0 callback:^(NSMutableArray *array) {
//        self.roomMArry = array;
        for (NSObject* obj in array) {
            [obj printAllPropertys];
        }
    }];
    self.roomMArry = [self.dbHelper search:[roomTable class] column:nil where:nil orderBy:nil offset:0 count:0];
    return  self.roomMArry;
}

//添加一个新房间
-(BOOL)addNewRoom:(NSString *)newRoomName
{
    roomTable *addRoom = [[roomTable alloc] init];
    addRoom.roomName = newRoomName;
    return [self.dbHelper insertWhenNotExists:addRoom];
    return NO;
}

//删除一个房间
-(BOOL)deleteRoom:(roomTable *)deleteRoom
{
    
    return [self.dbHelper deleteToDB:deleteRoom];
    return NO;
}

//更新一个房间
-(BOOL)updateRoom:(roomTable *)updateRoom
{
    return [self.dbHelper updateToDB:updateRoom where:@"nil"];
    return NO;
}


@end
