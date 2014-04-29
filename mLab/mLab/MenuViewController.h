//
//  MenuViewController.h
//  mLab
//
//  Created by Chenyang  on 3/3/14.
//  Copyright (c) 2014 Chenyang . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RESideMenu.h"

@interface MenuViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, RESideMenuDelegate>
@property (strong, readwrite, nonatomic) UITableView *tableView;

@end
