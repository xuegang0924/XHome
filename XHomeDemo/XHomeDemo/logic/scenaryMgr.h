//
//  scenaryMgr.h
//  XHomeDemo
//
//  Created by Gene on 14-5-11.
//  Copyright (c) 2014年 ROBOTIZE-LIFE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "scenarySource.h"

@interface scenaryMgr : NSObject

@property(strong,nonatomic)scenarySource *scenarySrc;
@property(strong,nonatomic)NSMutableArray *scenarysArry;


/**
 *加载数据库中的场景条目
 */
- (void)initScenarys;

/**
 *新增一个场景条目
 */
- (BOOL)addNewScenary:(NSString *)newScenaryName;

/**
 *更新一个场景条目
 */
- (BOOL)updateScenary:(NSString *)newScenaryName withOldScenaryName:(NSString *)oldScenaryName;

/**
 *删除一个场景条目
 */
- (BOOL)deleteScenary:(NSString *)ScenaryName;

@end
