//
//  FORDSendCommandImage.m
//  ShowImagePackageDemo
//
//  Created by like on 16/2/24.
//  Copyright © 2016年 like. All rights reserved.
//

#import "FORDSendCommandImage.h"
@interface FORDSendCommandImage ()
{
    dispatch_queue_t sendCommandSerialQueue;//command queue
}
@property (strong, nonatomic) NSMutableArray *addCommandArray;//SDLAddCommand array
@end
@implementation FORDSendCommandImage

/**
 *  release command of SendImage object
 */
- (void)releaseAllKindsOfSendImageObject
{
    sendCommandSerialQueue = nil;
    self.addCommandArray = nil;
    self.sendImageDictArray = nil;
    self.sendImageDict = nil;
    [self.putImageFileObject releasePutImageFile];
    self.putImageFileObject = nil;
    self.putImageSyncProxy = nil;
}

/**
 *  to add images data dictionary in the array
 *
 *  @param sendImageDict image data dictionary
 */
- (void)setSendImageDict:(NSMutableDictionary *)sendImageDict
{
    if (!sendCommandSerialQueue) {
        sendCommandSerialQueue = dispatch_queue_create("sendCommandSerialQueue", DISPATCH_QUEUE_SERIAL);
    }
    if (self.sendImageDictArray) {
        [self.sendImageDictArray addObject:sendImageDict];
    }
    //if array count is 1, call send function
    if (self.sendImageDictArray && [self.sendImageDictArray count] == 1) {
        [self sendImageToPutFileClass];
    }
}

/**
 *  addCommand's setter
 *
 *  @param addCommand SDLAddCommand
 */
- (void)setAddCommand:(SDLAddCommand *)addCommand
{
    _addCommand = addCommand;
    //addCommand is not nil
    if (_addCommand) {
        //add
        if (!self.addCommandArray) {
            self.addCommandArray = [[NSMutableArray alloc]initWithObjects:addCommand, nil];
        }else {
            if (self.addCommandArray) {
                [self.addCommandArray addObject:addCommand];
            }
        }
    }
}

//put image
- (void)sendImageToPutFileClass
{
    dispatch_async(sendCommandSerialQueue, ^{
        //the count of image array as same as the count of command array
        if ([self.sendImageDictArray count] > 0 && [self.sendImageDictArray count] >= [self.addCommandArray count]) {
            __weak __typeof(self)weakSelf = self;
            //block
            [self.putImageFileObject setPutCommandResultBlock:^(SDLPutFileResponse *response, NSMutableDictionary *imageInfoDict) {
                __strong __typeof(weakSelf)strongSelf = weakSelf;
                //judge result if YES=sendRPC NO=fail
                if (response && response.resultCode == [SDLResult SUCCESS]) {
                    //sendRPC
                    [strongSelf sendAddCommandRPC:imageInfoDict];
                }else {
                    //fail
                }
                //delete finish image info
                if ([strongSelf.sendImageDictArray count] > 0) {
                    [strongSelf.sendImageDictArray removeObjectAtIndex:0];
                }
                //delete finish addCommand info
                if ([strongSelf.addCommandArray count] > 0) {
                    [strongSelf.addCommandArray removeObjectAtIndex:0];
                }
                //the current block is finish, so release
                strongSelf.putImageFileObject.putCommandResultBlock = nil;
                //recycle send image info
                [strongSelf sendImageToPutFileClass];
            }];
            //put addCommand image info
            [self.putImageFileObject putAddCommandImageFile:[self.sendImageDictArray firstObject]];
        }
    });
}

/**
 *  send addCommand RPC
 *
 *  @param imageInfoDict image data dictionary
 */
- (void)sendAddCommandRPC:(NSMutableDictionary *)imageInfoDict
{
    if (imageInfoDict) {
        SDLAddCommand *addCommand = (SDLAddCommand *)self.addCommandArray[0];
        SDLImage *image = [[SDLImage alloc]init];
        image.value = imageInfoDict.imageNameOfMd5String;
        image.imageType = [SDLImageType DYNAMIC];//DYNAMIC
        addCommand.cmdIcon = image;
        [self.putImageSyncProxy sendRPC:addCommand];
    }
}

/**
 *  implement app softButton response
 *
 *  @param response SDLSoftButton Response
 */
- (void)onAddCommandResponse:(SDLAddCommandResponse *)response
{
    
}
@end
