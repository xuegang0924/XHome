//
//  deviceTable.h
//  XHomeDemo
//
//  Created by Gene on 14-5-11.
//  Copyright (c) 2014年 ROBOTIZE-LIFE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LKDBHelper.h"
#include "roomTable.h"

@interface deviceTable : NSObject
//属性
@property(strong,nonatomic)NSString *roomDevName;
@property(strong,nonatomic)NSString *deviceName;
@property(strong,nonatomic)NSString *deviceType;


//@property(strong,nonatomic)roomTable *roomTableID;
@property(strong,nonatomic)NSString *roomID;

@end
