//
//  CuttainShowViewController.m
//  XHomeDemo
//
//  Created by Gene on 14-6-4.
//  Copyright (c) 2014年 ROBOTIZE-LIFE. All rights reserved.
//

#import "CuttainShowViewController.h"

@interface CuttainShowViewController ()
@property(strong,nonatomic)UIButton *btnCurtainONOFF;

@end

@implementation CuttainShowViewController
@synthesize strDeviceName;
@synthesize strDevRoom;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        if (!_btnCurtainONOFF) {
            _btnCurtainONOFF = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            _btnCurtainONOFF.frame = CGRectMake(10, 150, 300, 300);
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor blackColor];
    NSRange rg = [self.title rangeOfString:@"-"];
    self.strDevRoom = [self.title substringToIndex:rg.location];
    self.strDeviceName = [self.title substringFromIndex:(rg.location + rg.length)];
    
    [_btnCurtainONOFF setBackgroundImage:[UIImage imageNamed:@"curtain_OFF_480_480.png"] forState:UIControlStateNormal];
    _btnCurtainONOFF.tag = 1;
    [_btnCurtainONOFF addTarget:self action:@selector(btnShortClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btnCurtainONOFF];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)btnShortClick:(UIButton *)sender
{
    static BOOL _bBackGroundFlag;
    NSLog(@"ss");
    
    
    
    _bBackGroundFlag = !_bBackGroundFlag;
    if (_bBackGroundFlag) {
        [_btnCurtainONOFF setBackgroundImage:[UIImage imageNamed:@"curtain_ON_480_480.png"] forState:UIControlStateNormal];
    } else {
        [_btnCurtainONOFF setBackgroundImage:[UIImage imageNamed:@"curtain_OFF_480_480.png"] forState:UIControlStateNormal];
        
    }
}

@end
