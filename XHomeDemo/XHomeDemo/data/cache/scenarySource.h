//
//  scenarySource.h
//  XHomeDemo
//
//  Created by Gene on 14-5-11.
//  Copyright (c) 2014年 ROBOTIZE-LIFE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "scenaryModel.h"

@interface scenarySource : NSObject


@property(strong,nonatomic)scenaryModel *scenaryMd;

/**
 *加载数据库中的场景条目
 */
- (NSMutableArray *)loadScenarys;


/**
 *新增一个场景条目
 */
- (BOOL)addScenary:(NSString *)newScenaryName;


/**
 *更新一个场景条目
 */
- (BOOL)updateScenary:(NSString *)newScenaryName withOldScenaryName:(NSString *)oldScenaryName;

/**
 *删除一个场景条目
 */
- (BOOL)deleteScenary:(NSString *)ScenaryName;

@end
