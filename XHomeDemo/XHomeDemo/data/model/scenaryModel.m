//
//  scenaryModel.m
//  XHomeDemo
//
//  Created by Gene on 14-5-16.
//  Copyright (c) 2014年 ROBOTIZE-LIFE. All rights reserved.
//

#import "scenaryModel.h"

@implementation scenaryModel


//初始化 创建表
-(id)init
{
    self = [super init];
    if (self) {
        self.dbHelper = [LKDBHelper getUsingLKDBHelper];
        
        //创建表  会根据表的版本号  来判断具体的操作 . create table need to manually call
        [self.dbHelper createTableWithModelClass:[scenaryTable class]];
        
        NSLog(@"scenaryModel init");
        
    }
    return self;
}


//得到总场景
-(NSMutableArray *)getScenaryMArry
{
    
    
    //异步搜索 所有的元素到数组中。
    //    [self.dbHelper search:[scenaryTable class] where:nil orderBy:nil offset:0 count:0 callback:^(NSMutableArray *array) {
    ////        self.scenaryMArry = array;
    //        for (NSObject* obj in array) {
    //            [obj printAllPropertys];
    //        }
    //    }];
    self.scenaryMArry = [self.dbHelper search:[scenaryTable class] column:nil where:nil orderBy:nil offset:0 count:0];
    return  self.scenaryMArry;
}

//添加一个新场景
-(BOOL)addNewScenary:(NSString *)newScenaryName
{
    scenaryTable *addScenary = [[scenaryTable alloc] init];
    addScenary.scenaryName = newScenaryName;
    return [self.dbHelper insertWhenNotExists:addScenary];
}

//更新一个场景
-(BOOL)updateAScenary:(NSString *)newScenaryName withOldScenaryName:(NSString *)oldScenaryName
{
    NSString *sql = [[NSString alloc] initWithFormat:@"scenaryName='%@'",oldScenaryName];
    scenaryTable *updateScenary = [[scenaryTable alloc] init];
    updateScenary.scenaryName = newScenaryName;
    int ret = [self.dbHelper updateToDB:updateScenary where:sql];
    
    return  ret;
}


//删除一个场景
-(BOOL)deleteAScenary:(NSString *)ScenaryName
{
    scenaryTable *deleteScenary = [[scenaryTable alloc] init];
    deleteScenary.scenaryName = ScenaryName;
    return [self.dbHelper deleteToDB:deleteScenary];
}


@end
