//
//  scenarySource.m
//  XHomeDemo
//
//  Created by Gene on 14-5-11.
//  Copyright (c) 2014年 ROBOTIZE-LIFE. All rights reserved.
//

#import "scenarySource.h"

@implementation scenarySource

- (id)init
{
    self = [super init];
    if (self) {
        _scenaryMd = [[scenaryModel alloc] init];
        NSLog(@"scenaryCache init");
    }
    return self;
}

/**
 *加载数据库中的场景条目
 */
- (NSMutableArray *)loadScenarys
{
    
    return  [_scenaryMd getScenaryMArry];
}

/**
 *新增一个场景条目
 */
- (BOOL)addScenary:(NSString *)newScenaryName
{
    return [_scenaryMd addNewScenary:newScenaryName];
}


/**
 *更新一个场景条目
 */
- (BOOL)updateScenary:(NSString *)newScenaryName withOldScenaryName:(NSString *)oldScenaryName
{
    return [_scenaryMd updateAScenary:newScenaryName withOldScenaryName:oldScenaryName];
}

/**
 *删除一个场景条目
 */
- (BOOL)deleteScenary:(NSString *)ScenaryName
{
    return [_scenaryMd deleteAScenary:ScenaryName];
}




@end
