//
//  AppDelegate.h
//  TestApp
//
//  Created by Anand on 10/15/15.
//  Copyright (c) 2015 Anand. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FeedsData : NSObject
{
    NSString *feedTitle;
    NSString *feedImageUrl;
    NSString *feedDescription;
    UIImage *imageCache;
}

@property(strong, nonatomic) NSString *feedTitle;
@property(strong, nonatomic) NSString *feedImageUrl;
@property(strong, nonatomic) NSString *feedDescription;
@property(strong, nonatomic) UIImage *imageCache;
@end
