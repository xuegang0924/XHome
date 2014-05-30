//
//  scenaryModel.h
//  XHomeDemo
//
//  Created by Gene on 14-5-16.
//  Copyright (c) 2014年 ROBOTIZE-LIFE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "scenaryTable.h"

@interface scenaryModel : NSObject

@property(strong,nonatomic)NSMutableArray *scenaryMArry;//所有场景
@property(strong,nonatomic)LKDBHelper *dbHelper;


-(NSMutableArray *)getScenaryMArry;

//添加一个新场景
-(BOOL)addNewScenary:(NSString *)newScenaryName;

//更新一个场景
-(BOOL)updateAScenary:(NSString *)newScenaryName withOldScenaryName:(NSString *)oldScenaryName;

//删除一个场景
-(BOOL)deleteAScenary:(NSString *)ScenaryName;


@end
