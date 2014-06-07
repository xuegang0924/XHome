//
//  commandTable.h
//  XHomeDemo
//
//  Created by Gene on 14-5-11.
//  Copyright (c) 2014年 ROBOTIZE-LIFE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LKDBHelper.h"

@interface commandTable : NSObject

//属性
@property(strong,nonatomic)NSString *commandName;
@property(strong,nonatomic)NSString *commandCode;
@property(strong,nonatomic)NSString *commandDevice;
@property(strong,nonatomic)NSString *commandRoom;
@property(strong,nonatomic)NSString *roomDeviceCommand;
@property(strong,nonatomic)NSString *commandScenery;
@property BOOL hasCommand;


@end
