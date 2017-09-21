//
//  NSObject+FORDPutImageDictionary.m
//  ShowImagePackageDemo
//
//  Created by like on 16/2/25.
//  Copyright © 2016年 like. All rights reserved.
//

#import "NSMutableDictionary+FORDPutImageDictionary.h"

@implementation NSMutableDictionary (FORDPutImageDictionary)
//create setter and getter function by yourSelf
@dynamic imageNameOfMd5String;
@dynamic imageNameOfLocalString;
@dynamic imageLocalOfNetworkPathString;
@dynamic imageShowType;
@dynamic imageSourceType;
@dynamic imagePutFileCorrelationID;
@dynamic imageShowCorrelationID;

/**
 *  imageNameOfMd5String's setter
 *
 *  @param imageNameOfMd5String image's name
 */
- (void)setImageNameOfMd5String:(NSString *)imageNameOfMd5String
{
    [self setValue:imageNameOfMd5String forKey:@"imageNameOfMd5String"];
}
/**
 *  imageNameOfMd5String's getter
 *
 *  @return value of image's md5 name
 */
- (NSString *)imageNameOfMd5String
{
    return self[@"imageNameOfMd5String"];
}

/**
 *  imageNameOfLocalString's setter
 *
 *  @param imageNameOfLocalString image's local name
 */
- (void)setImageNameOfLocalString:(NSString *)imageNameOfLocalString
{
    [self setValue:imageNameOfLocalString forKey:@"imageNameOfLocalString"];
}
/**
 *  imageNameOfLocalString's getter
 *
 *  @return value of image's local name
 */
- (NSString *)imageNameOfLocalString
{
    return self[@"imageNameOfLocalString"];
}

/**
 *  imageLocalPathString's setter
 *
 *  @param imageLocalPathString image's local path
 */
- (void)setImageLocalOfNetworkPathString:(NSString *)imageLocalOfNetworkPathString
{
    [self setValue:imageLocalOfNetworkPathString forKey:@"imageLocalOfNetworkPathString"];
}
/**
 *  imageLocalOfNetworkPathString's getter
 *
 *  @return value of image's local path
 */
- (NSString *)imageLocalOfNetworkPathString
{
    return self[@"imageLocalOfNetworkPathString"];
}

/**
 *  displayLayout's setter
 *
 *  @param displayLayout value of display layout
 */
- (void)setDisplayLayout:(NSString *)displayLayout
{
    [self setValue:displayLayout forKey:@"displayLayout"];
}
/**
 *  displayLayout's getter
 *
 *  @return value of display layout
 */
- (NSString *)displayLayout
{
    return self[@"displayLayout"];
}

/**
 *  imagePositionOnScreen's setter
 *
 *  @param imagePositionOnScreen value of position
 */
- (void)setImagePositionOnScreen:(NSInteger)imagePositionOnScreen
{
    [self setObject:@(imagePositionOnScreen) forKey:@"imagePositionOnScreen"];
}
/**
 *  imagePositionOnScreen's getter
 *
 *  @return value of position
 */
- (NSInteger)imagePositionOnScreen
{
    return [self[@"imagePositionOnScreen"] integerValue];
}

/**
 *  imageShowType's setter
 *
 *  @param imageShowType image's show type
 */
- (void)setImageShowType:(NSInteger)imageShowType
{
    [self setObject:@(imageShowType) forKey:@"imageShowType"];
}
/**
 *  imageShowType's getter
 *
 *  @return value of image's show type
 */
- (NSInteger)imageShowType
{
    return [self[@"imageShowType"] integerValue];
}

/**
 *  imageSourceType's setter
 *
 *  @param imageSourceType image's source type
 */
- (void)setImageSourceType:(NSInteger)imageSourceType
{
    [self setObject:@(imageSourceType) forKey:@"imageSourceType"];
}
/**
 *  imageSourceType's getter
 *
 *  @return value of image's source type
 */
- (NSInteger)imageSourceType
{
    return [self[@"imageSourceType"] integerValue];
}

/**
 *  imagePutFileCorrelationID's setter
 *
 *  @param imagePutFileCorrelationID sync's put file correlationID
 */
- (void)setImagePutFileCorrelationID:(NSInteger)imagePutFileCorrelationID
{
    [self setObject:@(imagePutFileCorrelationID) forKey:@"imagePutFileCorrelationID"];
}
/**
 *  imagePutFileCorrelationID's getter
 *
 *  @return value of sync's put file correlationID
 */
- (NSInteger)imagePutFileCorrelationID
{
    return [self[@"imagePutFileCorrelationID"] integerValue];
}

/**
 *  imageShowCorrelationID's setter
 *
 *  @param imageShowCorrelationID sync's send show correlationID
 */
- (void)setImageShowCorrelationID:(NSInteger)imageShowCorrelationID
{
    [self setObject:@(imageShowCorrelationID) forKey:@"imageShowCorrelationID"];
}
/**
 *  imageShowCorrelationID's getter
 *
 *  @return value of sync's send show correlationID
 */
- (NSInteger)imageShowCorrelationID
{
    return [self[@"imageShowCorrelationID"] integerValue];
}

/**
 *  imagePutState's setter
 *
 *  @param imagePutState image put state
 */
- (void)setImagePutState:(BOOL)imagePutState
{
    [self setObject:@(imagePutState) forKey:@"imagePutState"];
}
/**
 *  imagePutState's getter
 *
 *  @return value of image put state
 */
- (BOOL)imagePutState
{
    return [self[@"imagePutState"] integerValue];
}
@end
