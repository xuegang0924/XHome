//
//  SocShowViewController.m
//  XHomeDemo
//
//  Created by Gene on 14-6-4.
//  Copyright (c) 2014年 ROBOTIZE-LIFE. All rights reserved.
//

#import "SocShowViewController.h"

@interface SocShowViewController ()
@property(strong,nonatomic)UIButton *btnSocONOFF;

@end

@implementation SocShowViewController
@synthesize strDeviceName;
@synthesize strDevRoom;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        if (!_btnSocONOFF) {
            _btnSocONOFF = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            _btnSocONOFF.frame = CGRectMake(10, 150, 300, 300);
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
    
    [_btnSocONOFF setBackgroundImage:[UIImage imageNamed:@"soc_OFF_480_480.png"] forState:UIControlStateNormal];
    _btnSocONOFF.tag = 1;
    [_btnSocONOFF addTarget:self action:@selector(btnShortClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btnSocONOFF];
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
        [_btnSocONOFF setBackgroundImage:[UIImage imageNamed:@"soc_ON_480_480.png"] forState:UIControlStateNormal];
    } else {
        [_btnSocONOFF setBackgroundImage:[UIImage imageNamed:@"soc_OFF_480_480.png"] forState:UIControlStateNormal];
        
    }
}

@end
