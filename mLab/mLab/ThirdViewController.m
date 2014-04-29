//
//  ThirdViewController.m
//  mLab
//
//  Created by Chenyang Zhu on 3/24/14.
//  Copyright (c) 2014 Chenyang . All rights reserved.
//

#import "ThirdViewController.h"

@interface ThirdViewController ()

@end

@implementation ThirdViewController
@synthesize myWebView;

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
    // Do any additional setup after loading the view.
    NSString *myUrl = @"http://158.130.12.47:3000/reg";
    NSURLRequest *myRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:myUrl]];
    [myWebView loadRequest:myRequest];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showMenu
{
    [self.sideMenuViewController presentMenuViewController];
}



@end
