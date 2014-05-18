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
@property(copy,nonatomic)NSString *deviceName;
@property(strong,nonatomic)roomTable *roomTableID;

@end
