//
//  AppDelegate.h
//  TestApp
//
//  Created by Anand on 10/15/15.
//  Copyright (c) 2015 Anand. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "FeedsData.h"

@interface ServiceHelper : NSObject<NSURLConnectionDelegate>
{
    NSMutableData *receivedData;
    NSURLConnection *connection;
    id currentReceivedData;
    
}


+ (NSDictionary *)stringWithUrl:(NSURL *)url postData:(NSData *)postData httpMethod:(NSString *)method withCallbackBlock:(void (^)(NSError *error)) callback;

+(NSString *)checkEmptyValue:(id )string;

+(NSMutableArray *)feedsList:(void (^)(NSError *error)) callback;

+(void)downloadImageWithURL:(NSURL *)url completionBlock:(void (^)(BOOL succeeded, UIImage *image))completionBlock;

+ (BOOL)createNSError:(NSInteger)errCode errString:(NSString *)aString errObject:(NSError **)anObject;

@end
