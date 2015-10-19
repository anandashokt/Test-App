//
//  ViewController.h
//  TestApp
//
//  Created by Anand on 10/15/15.
//  Copyright (c) 2015 Anand. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *feedsTableView;
   
}
@property(strong, nonatomic) UITableView *feedsTableView;


@end

