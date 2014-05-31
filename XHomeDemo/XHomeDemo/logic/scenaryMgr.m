//
//  scenaryMgr.m
//  XHomeDemo
//
//  Created by Gene on 14-5-11.
//  Copyright (c) 2014年 ROBOTIZE-LIFE. All rights reserved.
//

#import "scenaryMgr.h"

@implementation scenaryMgr
@synthesize scenarysArry;

- (id)init
{
    self = [super init];
    if (self) {
        _scenarySrc = [[scenarySource alloc] init];
        
        NSLog(@"scenaryMgr init");
    }
    return self;
}

/**
 *加载数据库中的场景条目
 */
- (void)initScenarys
{
    self.scenarysArry = [_scenarySrc loadScenarys];
}

/**
 *新增一个场景条目
 */
- (BOOL)addNewScenary:(NSString *)newScenaryName
{
    return [_scenarySrc addScenary:newScenaryName];
}

/**
 *更新一个场景条目
 */
- (BOOL)updateScenary:(NSString *)newScenaryName withOldScenaryName:(NSString *)oldScenaryName
{
    return [_scenarySrc updateScenary:newScenaryName withOldScenaryName:oldScenaryName];
}

/**
 *删除一个场景条目
 */
- (BOOL)deleteScenary:(NSString *)ScenaryName
{
    return [_scenarySrc deleteScenary:ScenaryName];
}



@end
