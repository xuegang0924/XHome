//
//  ScenaryViewController.h
//  XHomeDemo
//
//  Created by Gene on 14-5-11.
//  Copyright (c) 2014年 ROBOTIZE-LIFE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScenaryAddCommandViewController.h"
#import "scenaryMgr.h"
#import "ButtonTagDef.h"

@interface ScenaryViewController : UIViewController<UIAlertViewDelegate>

@property(strong,nonatomic)scenaryMgr *scenaryCtr;
@end
