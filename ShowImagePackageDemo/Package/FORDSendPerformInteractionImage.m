//
//  FORDSendPerformInteractionImage.m
//  ShowImagePackageDemo
//
//  Created by like on 16/2/24.
//  Copyright © 2016年 like. All rights reserved.
//

#import "FORDSendPerformInteractionImage.h"
@interface FORDSendPerformInteractionImage ()
{
    dispatch_queue_t sendPerformInteractionSerialQueue;//performInteraction queue
}
@end
@implementation FORDSendPerformInteractionImage

/**
 *  release choice of SendImage object
 */
- (void)releaseAllKindsOfSendImageObject
{
    sendPerformInteractionSerialQueue = nil;
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
    if (!sendPerformInteractionSerialQueue) {
        sendPerformInteractionSerialQueue = dispatch_queue_create("sendPerformInteractionSerialQueue", DISPATCH_QUEUE_SERIAL);
    }
    if (self.sendImageDictArray) {
        [self.sendImageDictArray addObject:sendImageDict];
    }
    //if array count is 1, call send function
    if (self.sendImageDictArray && [self.sendImageDictArray count] == 1) {
        [self sendImageToPutFileClass];
    }
}

//put image
- (void)sendImageToPutFileClass
{
    dispatch_async(sendPerformInteractionSerialQueue, ^{
        //the count of image array as same as the count of choice array
        if ([self.sendImageDictArray count] > 0) {
            __weak __typeof(self)weakSelf = self;
            //block
            [self.putImageFileObject setPutPerformInteractionResultBlock:^(SDLPutFileResponse *response, NSMutableDictionary *imageInfoDict) {
                __strong __typeof(weakSelf)strongSelf = weakSelf;
                //judge result if YES=sendRPC NO=fail
                if (response && response.resultCode == [SDLResult SUCCESS]) {
                    //array is finish and put file response
                    //set put state YES
                    imageInfoDict.imagePutState = YES;
                }else {
                    //fail response
                    //set put state NO
                    imageInfoDict.imagePutState = NO;
                }
                //response
                [[NSNotificationCenter defaultCenter] postNotificationName:@"FORDSendChoiceImageNotification" object:nil userInfo:imageInfoDict];
                //delete finish image info
                if ([strongSelf.sendImageDictArray count] > 0) {
                    [strongSelf.sendImageDictArray removeObjectAtIndex:0];
                }
                //the current block is finish, so release
                strongSelf.putImageFileObject.putCommandResultBlock = nil;
                //recycle send image info
                [strongSelf sendImageToPutFileClass];
            }];
            //put choice image info
            [self.putImageFileObject putChoiceImageFile:[self.sendImageDictArray firstObject]];
        }
    });
}
@end
