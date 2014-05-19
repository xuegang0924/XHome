//
//  roomModel.h
//  XHomeDemo
//
//  Created by Gene on 14-5-16.
//  Copyright (c) 2014年 ROBOTIZE-LIFE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "roomTable.h"


@interface roomModel : NSObject

@property(strong,nonatomic)NSMutableArray *roomMArry;//所有房间
@property(strong,nonatomic)LKDBHelper *dbHelper;


-(NSMutableArray *)getRoomMArry;

//添加一个新房间
-(BOOL)addNewRoom:(NSString *)newRoomName;

@end
