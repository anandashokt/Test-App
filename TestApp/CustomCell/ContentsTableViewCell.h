//
//  AppDelegate.h
//  TestApp
//
//  Created by Anand on 10/15/15.
//  Copyright (c) 2015 Anand. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface ContentsTableViewCell : UITableViewCell
{
    UIImageView *itemImage;
    UILabel *itemTitle;
    UILabel *itemDescription;
}

@property (nonatomic, strong) UIImageView *itemImage;
@property (nonatomic, strong) UILabel *itemTitle;
@property (nonatomic, strong) UILabel *itemDescription;

@end
