//
//  FORDPutImageFile.h
//  ShowImagePackageDemo
//
//  Created by like on 16/2/24.
//  Copyright © 2016年 like. All rights reserved.
//
//  send RPC of SDLPutFile class

#import <Foundation/Foundation.h>
#import <SmartDeviceLink/SmartDeviceLink.h>
#import "NSMutableDictionary+FORDPutImageDictionary.h"

/**
 enum：image's source
 */
typedef enum : NSInteger {
    //bundle
    SendImageOfSourceTypeOfBundle = 101,
    //sandbox
    SendImageOfSourceTypeOfSandbox = 102,
    //network
    SendImageOfSourceTypeOfNetwork = 103
} SendImageOfSourceType;

/**
 enum：image's show location
 */
typedef enum : NSUInteger {
    //icon image
    SendImageShowTypeOfIcon = 201,
    //SDLShow's image
    SendImageShowTypeOfShow = 202,
    //SoftButton's image
    SendImageShowTypeOfSoftButton = 203,
    //Command's image
    SendImageShowTypeOfAddCommand= 204,
    //PerformInteraction's show image
    SendImageShowTypePerformInteraction = 205
} SendImageShowType;

/**
 *  block putFile result response
 *
 *  @param putFileDict image data dict
 */
typedef void (^PutIconResultBlcok)(SDLPutFileResponse *response, NSMutableDictionary *imageInfoDict);
typedef void (^PutShowResultBlcok)(SDLPutFileResponse *response, NSMutableDictionary *imageInfoDict);
typedef void (^PutSoftButtonResultBlcok)(SDLPutFileResponse *response, NSMutableDictionary *imageInfoDict);
typedef void (^PutCommandResultBlcok)(SDLPutFileResponse *response, NSMutableDictionary *imageInfoDict);
typedef void (^PutPerformInteractionResultBlcok)(SDLPutFileResponse *response, NSMutableDictionary *imageInfoDict);
//get the data of network image block
typedef void (^GetNetworkImageDataBlcok)(NSData *imageData);

@interface FORDPutImageFile : NSObject

@property (copy, nonatomic)PutIconResultBlcok putIconResultBlock;//block
@property (copy, nonatomic)PutShowResultBlcok putShowResultBlock;//block
@property (copy, nonatomic)PutSoftButtonResultBlcok putSoftButtonResultBlock;//block
@property (copy, nonatomic)PutCommandResultBlcok putCommandResultBlock;//block
@property (copy, nonatomic)PutPerformInteractionResultBlcok putPerformInteractionResultBlock;//block
@property (copy, nonatomic)GetNetworkImageDataBlcok getNetworkImageDataBlcok;//block
@property (strong, nonatomic)SDLProxy *putImageSyncProxy;//sync

/**
 *  init
 *
 *  @param proxySync SDLProxy
 *
 *  @return id self
 */
- (id)initWithSync:(SDLProxy *)proxySync;

/**
 *  release PutImageFile object
 */
- (void)releasePutImageFile;

/**
 *  send kind of icon's image info dict to array
 *
 *  @param imageFileDict image file info's dict
 */
- (void)putIconImageFile:(NSDictionary *)imageFileDict;

/**
 *  send kind of show's image info dict to array
 *
 *  @param imageFileDict image file info's dict
 */
- (void)putShowImageFile:(NSDictionary *)imageFileDict;

/**
 *  send kind of softButton's image info dict to array
 *
 *  @param imageFileDict image file info's dict
 */
- (void)putSoftButtonImageFile:(NSDictionary *)imageFileDict;

/**
 *  send kind of addCommand's image info dict to array
 *
 *  @param imageFileDict image file info's dict
 */
- (void)putAddCommandImageFile:(NSDictionary *)imageFileDict;

/**
 *  send kind of choice's image info dict to array
 *
 *  @param imageFileDict image file info's dict
 */
- (void)putChoiceImageFile:(NSDictionary *)imageFileDict;
@end
