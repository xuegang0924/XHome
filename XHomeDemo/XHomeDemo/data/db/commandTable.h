//
//  commandTable.h
//  XHomeDemo
//
//  Created by Gene on 14-5-11.
//  Copyright (c) 2014年 ROBOTIZE-LIFE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LKDBHelper.h"
#import "deviceTable.h"

@interface commandTable : NSObject

//属性
@property(copy,nonatomic)NSString *commandCode;
@property(strong,nonatomic)deviceTable *deviceTableID;


@end
