//
//  ThirdViewController.h
//  mLab
//
//  Created by Chenyang Zhu on 3/24/14.
//  Copyright (c) 2014 Chenyang . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RESideMenu.h"

@interface ThirdViewController : UIViewController <UIPickerViewDelegate>

- (IBAction)showMenu;
@property (strong, nonatomic) IBOutlet UIWebView *myWebView;


@end
