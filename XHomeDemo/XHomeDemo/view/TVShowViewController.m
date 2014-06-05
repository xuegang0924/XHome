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
//@synthesize btnDown;
//@synthesize btnUP;
//@synthesize btnONOFF;
//@synthesize btn0;
//@synthesize btn1;
//@synthesize btn2;
//@synthesize btn3;
//@synthesize btn4;
//@synthesize btn5;
//@synthesize btn6;
//@synthesize btn7;
//@synthesize btn8;
//@synthesize btn9;
//@synthesize btnCustom;
//@synthesize btnGoback;
//@synthesize btnLeft;
//@synthesize btnMenu;
//@synthesize btnMute;
//@synthesize btnNULL;
//@synthesize btnOK;
//@synthesize btnRight;
//@synthesize btnSignelSource;


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
    UIScrollView *scrv = [[UIScrollView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    scrv.contentSize = CGSizeMake(scrv.bounds.size.width, scrv.bounds.size.height * 2);
    scrv.backgroundColor = [UIColor blackColor];
    [scrv setPagingEnabled:YES];
    [self.view addSubview:scrv];

//    [btnONOFF setBackgroundImage:[UIImage imageNamed:@"kaiguan_400_400.png"] forState:UIControlStateNormal];
//    [scrv addSubview:btnONOFF];
//    
//    [btnUP setBackgroundImage:[UIImage imageNamed:@"up_400_400.png"] forState:UIControlStateNormal];
//    [scrv addSubview:btnUP];
//    
//    [btnDown setBackgroundImage:[UIImage imageNamed:@"down_400_400.png"] forState:UIControlStateNormal];
//    [scrv addSubview:btnDown];
//    
//    [btnRight setBackgroundImage:[UIImage imageNamed:@"right_400_400.png"] forState:UIControlStateNormal];
//    [scrv addSubview:btnRight];
//    
//    [btnLeft setBackgroundImage:[UIImage imageNamed:@"left_400_400.png"] forState:UIControlStateNormal];
//    [btnOK setBackgroundImage:[UIImage imageNamed:@"OK_400_400.png"] forState:UIControlStateNormal];
//    [btnSignelSource setBackgroundImage:[UIImage imageNamed:@"signalSource_400_400.png"] forState:UIControlStateNormal];
//    [btnMute setBackgroundImage:[UIImage imageNamed:@"mute_400_400.png"] forState:UIControlStateNormal];
//    [btnMenu setBackgroundImage:[UIImage imageNamed:@"menu_400_400.png"] forState:UIControlStateNormal];
//    [btnCustom setBackgroundImage:[UIImage imageNamed:@"custom_400_400.png"] forState:UIControlStateNormal];
//    [btnGoback setBackgroundImage:[UIImage imageNamed:@"goback_400_400.png"] forState:UIControlStateNormal];
//    [btnNULL setBackgroundImage:[UIImage imageNamed:@"NULL_400_400.png"] forState:UIControlStateNormal];
//    [btn setBackgroundImage:[UIImage imageNamed:@"_400_400.png"] forState:UIControlStateNormal];
//    [btn setBackgroundImage:[UIImage imageNamed:@"_400_400.png"] forState:UIControlStateNormal];
//    [btn setBackgroundImage:[UIImage imageNamed:@"_400_400.png"] forState:UIControlStateNormal];
//    [btn setBackgroundImage:[UIImage imageNamed:@"_400_400.png"] forState:UIControlStateNormal];
//    [btn setBackgroundImage:[UIImage imageNamed:@"_400_400.png"] forState:UIControlStateNormal];
    
#define X 110/4.0
#define BTNW  70
#define ONPAGE_HIGHTE   583
    UIButton *btn0 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn0.frame = CGRectMake(X, 40 +ONPAGE_HIGHTE, BTNW, BTNW);
    [btn0 setBackgroundImage:[UIImage imageNamed:@"0_400_400.png"] forState:UIControlStateNormal];
    btn0.tag = 0;
    [btn0 addTarget:self action:@selector(btnShortClick:) forControlEvents:UIControlEventTouchUpInside];
    [scrv addSubview:btn0];
    [scrv setContentSize:CGSizeMake(self.view.bounds.size.width, btn0.frame.origin.y + BTNW)];
    
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)btnShortClick:(UIButton *)sender
{
    NSLog(@"ss");
  

}
@end
