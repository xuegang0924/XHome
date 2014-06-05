//
//  LampShowViewController.m
//  XHomeDemo
//
//  Created by Gene on 14-6-4.
//  Copyright (c) 2014年 ROBOTIZE-LIFE. All rights reserved.
//

#import "LampShowViewController.h"

@interface LampShowViewController ()
@property(strong,nonatomic)UIButton *btnLampONOFF;

@end


@implementation LampShowViewController
@synthesize strDeviceName;
@synthesize strDevRoom;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        if (!_btnLampONOFF) {
            _btnLampONOFF = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            _btnLampONOFF.frame = CGRectMake((320 - 285) /2, 80, 285, 480);
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
    
    [_btnLampONOFF setBackgroundImage:[UIImage imageNamed:@"lamp_OFF_480_285.png"] forState:UIControlStateNormal];
    _btnLampONOFF.tag = 1;
    [_btnLampONOFF addTarget:self action:@selector(btnShortClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btnLampONOFF];
    
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
        [_btnLampONOFF setBackgroundImage:[UIImage imageNamed:@"lamp_ON_480_285.png"] forState:UIControlStateNormal];
    } else {
        [_btnLampONOFF setBackgroundImage:[UIImage imageNamed:@"lamp_OFF_480_285.png"] forState:UIControlStateNormal];

    }
}









@end
