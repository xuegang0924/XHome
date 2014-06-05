//
//  WebcamShowViewController.m
//  XHomeDemo
//
//  Created by Gene on 14-6-4.
//  Copyright (c) 2014年 ROBOTIZE-LIFE. All rights reserved.
//

#import "WebcamShowViewController.h"

@interface WebcamShowViewController ()

@end

@implementation WebcamShowViewController
@synthesize btnPhoto;
@synthesize btnRec;


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
    
    [btnPhoto setBackgroundImage:[UIImage imageNamed:@"photo_400_400.png"] forState:UIControlStateNormal];
    [btnRec setBackgroundImage:[UIImage imageNamed:@"record_400_400.png"] forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
