//
//  TVShowViewController.m
//  XHomeDemo
//
//  Created by Gene on 14-6-4.
//  Copyright (c) 2014年 ROBOTIZE-LIFE. All rights reserved.
//

#import "TVShowViewController.h"

@interface TVShowViewController ()

@end

@implementation TVShowViewController
@synthesize scrvTV;
@synthesize btnDown;
@synthesize btnUP;
@synthesize btnONOFF;
@synthesize btn0;
@synthesize btn1;
@synthesize btn2;
@synthesize btn3;
@synthesize btn4;
@synthesize btn5;
@synthesize btn6;
@synthesize btn7;
@synthesize btn8;
@synthesize btn9;
@synthesize btnCustom;
@synthesize btnGoback;
@synthesize btnLeft;
@synthesize btnMenu;
@synthesize btnMute;
@synthesize btnNULL;
@synthesize btnOK;
@synthesize btnRight;
@synthesize btnSignelSource;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor blackColor];
    //添加一个scrollView

    scrvTV.contentSize = CGSizeMake(scrvTV.bounds.size.width, scrvTV.bounds.size.height * 2);
    scrvTV.backgroundColor = [UIColor blackColor];
    [self.view addSubview:scrvTV];

    [btnONOFF setBackgroundImage:[UIImage imageNamed:@"kaiguan_400_400.png"] forState:UIControlStateNormal];
    [btnUP setBackgroundImage:[UIImage imageNamed:@"up_400_400.png"] forState:UIControlStateNormal];
    [btnDown setBackgroundImage:[UIImage imageNamed:@"down_400_400.png"] forState:UIControlStateNormal];
    [btnRight setBackgroundImage:[UIImage imageNamed:@"right_400_400.png"] forState:UIControlStateNormal];
    [btnLeft setBackgroundImage:[UIImage imageNamed:@"left_400_400.png"] forState:UIControlStateNormal];
    [btnOK setBackgroundImage:[UIImage imageNamed:@"OK_400_400.png"] forState:UIControlStateNormal];
    [btnSignelSource setBackgroundImage:[UIImage imageNamed:@"signalSource_400_400.png"] forState:UIControlStateNormal];
    [btnMute setBackgroundImage:[UIImage imageNamed:@"mute_400_400.png"] forState:UIControlStateNormal];
    [btnMenu setBackgroundImage:[UIImage imageNamed:@"menu_400_400.png"] forState:UIControlStateNormal];
    [btnCustom setBackgroundImage:[UIImage imageNamed:@"custom_400_400.png"] forState:UIControlStateNormal];
    [btnGoback setBackgroundImage:[UIImage imageNamed:@"goback_400_400.png"] forState:UIControlStateNormal];
    [btnNULL setBackgroundImage:[UIImage imageNamed:@"NULL_400_400.png"] forState:UIControlStateNormal];
//    [btn setBackgroundImage:[UIImage imageNamed:@"_400_400.png"] forState:UIControlStateNormal];
//    [btn setBackgroundImage:[UIImage imageNamed:@"_400_400.png"] forState:UIControlStateNormal];
//    [btn setBackgroundImage:[UIImage imageNamed:@"_400_400.png"] forState:UIControlStateNormal];
//    [btn setBackgroundImage:[UIImage imageNamed:@"_400_400.png"] forState:UIControlStateNormal];
//    [btn setBackgroundImage:[UIImage imageNamed:@"_400_400.png"] forState:UIControlStateNormal];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
