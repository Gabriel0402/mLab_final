//
//  VIOSViewController.m
//  mLab
//
//  Created by Chenyang  on 3/3/14.
//  Copyright (c) 2014 Chenyang . All rights reserved.
//

#import "VIOSViewController.h"
#import "MenuViewController.h"

@interface VIOSViewController ()

@end

@implementation VIOSViewController

- (void)awakeFromNib
{
    self.contentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"contentController"];
    self.menuViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"menuController"];
    self.backgroundImage = [UIImage imageNamed:@"blur"];
    self.delegate = (MenuViewController *)self.menuViewController;
}

@end
