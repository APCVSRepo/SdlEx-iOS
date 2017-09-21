//
//  FORDSendImageObject.m
//  ShowImagePackageDemo
//
//  Created by like on 16/2/24.
//  Copyright © 2016年 like. All rights reserved.
//

#import "FORDSendImageObject.h"

#import "FORDSendIconImage.h"
#import "FORDSendShowImage.h"
#import "FORDSendSoftButtonImage.h"
#import "FORDSendCommandImage.h"
#import "FORDSendPerformInteractionImage.h"

static FORDSendImageObject *sendImageObject = nil;
@interface FORDSendImageObject ()
{
    dispatch_queue_t putImageDataSerialQueue;//put image data queue
    
    FORDSendIconImage *sendIconImageObject;//send icon class
    FORDSendShowImage *sendShowImageObject;//send show class
    FORDSendSoftButtonImage *sendSoftButtonImageObject;//send softButton class
    FORDSendCommandImage *sendCommandImageObject;//send command class
    FORDSendPerformInteractionImage *sendPerformInteractionImageObject;//send choice class
}
@end
@implementation FORDSendImageObject

#pragma mark <--------初始化 start
/**
 *  初始化
 *
 *  @param proxySync SDLProxy
 *
 *  @return id self
 */
- (id)initWithSync:(SDLProxy *)proxySync
{
    self = [super init];
    if (self) {
        //init the corresponding queue
        putImageDataSerialQueue = dispatch_queue_create("putImageDataSerialQueue", DISPATCH_QUEUE_SERIAL);
        
        //init all objects
        sendIconImageObject = [[FORDSendIconImage alloc] initWithSync:proxySync];
        sendShowImageObject = [[FORDSendShowImage alloc] initWithSync:proxySync];
        sendSoftButtonImageObject = [[FORDSendSoftButtonImage alloc] initWithSync:proxySync];
        sendCommandImageObject = [[FORDSendCommandImage alloc] initWithSync:proxySync];
        sendPerformInteractionImageObject = [[FORDSendPerformInteractionImage alloc] initWithSync:proxySync];
    }
    return self;
}

/**
 *  get the current instance of the class
 *
 *  @param proxySync instance of the SDLProxy
 *
 *  @return FORDSendImageObject
 */
+ (FORDSendImageObject *)shareSendImageObjectWithSync:(SDLProxy *)proxySync
{
    //init
    if (proxySync && !sendImageObject) {
        sendImageObject = [[FORDSendImageObject alloc] initWithSync:proxySync];
    }else if (!proxySync && sendImageObject) {//proxySync is nil (release)
        [sendImageObject releaseSendImageObject];
    }
    return sendImageObject;
}

/**
 *  SendImageObject release
 */
- (void)releaseSendImageObject
{
    putImageDataSerialQueue = nil;
    
    [sendIconImageObject releaseAllKindsOfSendImageObject];
    sendIconImageObject = nil;
    [sendShowImageObject releaseAllKindsOfSendImageObject];
    sendShowImageObject = nil;
    [sendSoftButtonImageObject releaseAllKindsOfSendImageObject];
    sendSoftButtonImageObject = nil;
    [sendCommandImageObject releaseAllKindsOfSendImageObject];
    sendCommandImageObject = nil;
    [sendPerformInteractionImageObject releaseAllKindsOfSendImageObject];
    sendPerformInteractionImageObject = nil;
    
    sendImageObject = nil;
}

#pragma mark 初始化 end---------->

#pragma mark <--------put image file start
/**
 *  put icon image
 *
 *  @param imageDict image data dictionary
 */
- (void)putIconImage:(NSMutableDictionary *)imageDict
{
    dispatch_async(putImageDataSerialQueue, ^{
        [sendIconImageObject setSendImageDict:imageDict];
    });
}

/**
 *  put show image
 *
 *  @param imageDict image data dictionary
 */
- (void)putShowImage:(NSMutableDictionary *)imageDict
{
    dispatch_async(putImageDataSerialQueue, ^{
        [sendShowImageObject setSendImageDict:imageDict];
    });
}

/**
 *  put softButton image
 *
 *  @param imageArray      image array
 *  @param softButtonArray softButton array
 *  @param correlationID the only text softButton RPC's correlationID
 */
- (void)putSoftButtonImage:(NSMutableArray *)imageArray withSoftButtonArray:(NSMutableArray *)softButtonArray withTextCorrelationID:(NSInteger)correlationID
{
    dispatch_async(putImageDataSerialQueue, ^{
        //init image array
        [sendSoftButtonImageObject setSendImageDictArray:imageArray];
        //init softButton array
        [sendSoftButtonImageObject setSoftButtonArray:softButtonArray];
        [sendSoftButtonImageObject setCorrelationIDOfText:correlationID];
    });
}

/**
 *  put Command image
 *
 *  @param imageDict image data dictionary
 *  @param command SDLAddCommand
 */
- (void)putCommandImage:(NSMutableDictionary *)imageDict withCommand:(SDLAddCommand *)command
{
    dispatch_async(putImageDataSerialQueue, ^{
        [sendCommandImageObject setAddCommand:command];
        [sendCommandImageObject setSendImageDict:imageDict];
    });
}

/**
 *  put PerformInteractionOfChoice image
 *
 *  @param imageDict image data dictionary
 *  @param choice SDLChoice
 */
- (void)putPerformInteractionOfChoiceImage:(NSMutableDictionary *)imageDict
{
    dispatch_async(putImageDataSerialQueue, ^{
        [sendPerformInteractionImageObject setSendImageDict:imageDict];
    });
}
#pragma mark put image file end---------->
@end
