//
//  deviceTable.m
//  XHomeDemo
//
//  Created by Gene on 14-5-11.
//  Copyright (c) 2014年 ROBOTIZE-LIFE. All rights reserved.
//

#import "deviceTable.h"

@implementation deviceTable


//在类 初始化的时候
+(void)initialize
{
    //remove unwant property
    //比如 getTableMapping 返回nil 的时候   会取全部属性  这时候 就可以 用这个方法  移除掉 不要的属性
    [self removePropertyWithColumnName:@"error"];
    
    
    //simple set a column as "LKSQL_Mapping_UserCalculate"
    //根据 属性名  来启用自己计算
    //[self setUserCalculateForCN:@"error"];
    
    
    //根据 属性类型  来启用自己计算
    //[self setUserCalculateForPTN:@"NSDictionary"];
    
    //enable own calculations
//    [self setUserCalculateForCN:@"roomTableID"];
    
    //enable the column binding property name
    [self setTableColumnName:@"MyRoomDevName" bindingPropertyName:@"roomDevName"];
    
    //You can create a table here
    //[[self getUsingLKDBHelper] createTableWithModelClass:self];
}

// 将要插入数据库
+(BOOL)dbWillInsert:(NSObject *)entity
{
    LKErrorLog(@"will insert : %@",NSStringFromClass(self));
    return YES;
}

//已经插入数据库
+(void)dbDidInserted:(NSObject *)entity result:(BOOL)result
{
    LKErrorLog(@"did insert : %@",NSStringFromClass(self));
}

// 重载    返回自己处理过的 要插入数据库的值
-(id)userGetValueForModel:(LKDBProperty *)property
{
    //    if([property.sqlColumnName isEqualToString:@"address"])
    //    {
    //        if(self.address == nil)
    //            return @"";
    //        [LKTestForeign insertToDB:self.address];
    //        return @(self.address.addid);
    //    }
    return nil;
}

// 重载    从数据库中  获取的值   经过自己处理 再保存
-(void)userSetValueForModel:(LKDBProperty *)property value:(id)value
{
    //    if([property.sqlColumnName isEqualToString:@"address"])
    //    {
    //        self.address = nil;
    //
    //        NSMutableArray* array  = [LKTestForeign searchWithWhere:[NSString stringWithFormat:@"addid = %d",[value intValue]] orderBy:nil offset:0 count:1];
    //
    //        if(array.count>0)
    //            self.address = [array objectAtIndex:0];
    //    }
}

//列属性
+(void)columnAttributeWithProperty:(LKDBProperty *)property
{
    //    if([property.sqlColumnName isEqualToString:@"MyAge"])
    //    {
    //        property.defaultValue = @"15";
    //    }
    //    else if([property.propertyName isEqualToString:@"date"])
    //    {
    //        // if you use unique,this property will also become the primary key
    //        //        property.isUnique = YES;
    //        property.checkValue = @"MyDate > '2000-01-01 00:00:00'";
    //        property.length = 30;
    //    }
}

//手动or自动 绑定sql列
+(NSDictionary *)getTableMapping
{
    return nil;
    //    return @{@"name":LKSQL_Mapping_Inherit,
    //             @"MyAge":@"age",
    //             @"img":LKSQL_Mapping_Inherit,
    //             @"MyDate":@"date",
    //
    //             // version 2 after add
    //             @"color":LKSQL_Mapping_Inherit,
    //
    //             //version 3 after add
    //             @"address":LKSQL_Mapping_UserCalculate,
    //             @"error":LKSQL_Mapping_Inherit
    //             };
}

//主键
+(NSString *)getPrimaryKey
{
    return @"roomDevName";
}

//+(NSArray *)getPrimaryKeyUnionArray
//{
//    return @[@"name",@"MyAge"];
//}

//表名
+(NSString *)getTableName
{
    return @"deviceTable";
}

//表版本
+(int)getTableVersion
{
    return 3;
}

//升级
+(LKTableUpdateType)tableUpdateForOldVersion:(int)oldVersion newVersion:(int)newVersion
{
    //..... eh...  upgrade for table
    switch (oldVersion) {
        case 1:
        {
            //            [self updateToDBWithSet:@"blah blah" where:nil];
        }
        case 2:
        {
            //            [self deleteWithWhere:@"blah blah"];
        }
            break;
    }
    return LKTableUpdateTypeCustom;
}






@end
