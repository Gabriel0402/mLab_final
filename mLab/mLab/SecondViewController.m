//
//  SecondViewController.m
//  mLab
//
//  Created by Chenyang  on 3/3/14.
//  Copyright (c) 2014 Chenyang . All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController
@synthesize myWebview;

- (IBAction)showMenu
{
    [self.sideMenuViewController presentMenuViewController];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *myUrl = @"http://158.130.12.47:3000/login";
    NSURLRequest *myRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:myUrl]];
    [myWebview loadRequest:myRequest];
}


@end
