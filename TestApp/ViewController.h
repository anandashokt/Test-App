//
//  ViewController.h
//  TestApp
//
//  Created by Anand on 10/15/15.
//  Copyright (c) 2015 Anand. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContentsTableViewCell.h"
#import "HelperClass.h"
#import "FeedsData.h"
#import "Reachability.h"

@interface ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *feedsTableView;
    NSMutableArray *feedsArray;
    UIActivityIndicatorView *activityIndicator;
}

@property(strong, nonatomic) UITableView *feedsTableView;
@property(strong, nonatomic) NSMutableArray *feedsArray;

@end

