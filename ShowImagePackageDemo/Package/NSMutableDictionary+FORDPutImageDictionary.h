//
//  NSObject+FORDPutImageDictionary.h
//  ShowImagePackageDemo
//
//  Created by like on 16/2/25.
//  Copyright © 2016年 like. All rights reserved.
//
//  the category class of NSMutableDictionary

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (FORDPutImageDictionary)
@property (strong, nonatomic) NSString *imageNameOfMd5String;//the name of the image through the md5 encryption
@property (strong, nonatomic) NSString *imageNameOfLocalString;//the local name of image
@property (strong, nonatomic) NSString *imageLocalOfNetworkPathString;//the local|network path of image
@property (strong, nonatomic) NSString *displayLayout;//the display layout of the screen
@property (assign, nonatomic) NSInteger imagePositionOnScreen;//the position of the image on screen
@property (assign, nonatomic) NSInteger imageShowType;//the regional type of image show
@property (assign, nonatomic) NSInteger imageSourceType;//the source of the image's type
@property (assign, nonatomic) NSInteger imagePutFileCorrelationID;//send the file id of sync
@property (assign, nonatomic) NSInteger imageShowCorrelationID;//image put successfully and send display image id of sync
@property (assign, nonatomic) BOOL imagePutState;//image put success(YES) or fail(NO)
@end
