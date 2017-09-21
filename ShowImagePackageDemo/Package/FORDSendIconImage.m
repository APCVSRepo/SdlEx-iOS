
//  FORDSendIconImage.m
//  ShowImagePackageDemo
//
//  Created by like on 16/2/24.
//  Copyright © 2016年 like. All rights reserved.
//

#import "FORDSendIconImage.h"
@interface FORDSendIconImage ()
{
    dispatch_queue_t sendIconSerialQueue;//icon队列
}
@end
@implementation FORDSendIconImage

/**
 *  release icon of SendImage object
 */
- (void)releaseAllKindsOfSendImageObject
{
    sendIconSerialQueue = nil;
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
    if (!sendIconSerialQueue) {
        sendIconSerialQueue = dispatch_queue_create("sendIconSerialQueue", DISPATCH_QUEUE_SERIAL);
    }
    //add to array
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
    dispatch_async(sendIconSerialQueue, ^{
        if ([self.sendImageDictArray count] > 0) {
            __weak __typeof(self)weakSelf = self;
            //block
            [self.putImageFileObject setPutIconResultBlock:^(SDLPutFileResponse *response, NSMutableDictionary *imageInfoDict) {
                __strong __typeof(weakSelf)strongSelf = weakSelf;
                //judge result if YES=sendRPC NO=fail
                if (response && response.resultCode == [SDLResult SUCCESS]) {
                    //sendRPC
                    [strongSelf sendIconRPC:imageInfoDict];
                }else {
                    //fail
                }
                //delete finish image info
                if ([strongSelf.sendImageDictArray count] > 0) {
                    [strongSelf.sendImageDictArray removeObjectAtIndex:0];
                }
                //the current block is finish, so release
                strongSelf.putImageFileObject.putIconResultBlock = nil;
                //recycle send image info
                [strongSelf sendImageToPutFileClass];
            }];
            //put icon image info
            [self.putImageFileObject putIconImageFile:[self.sendImageDictArray firstObject]];
        }
    });
}

/**
 *  send icon RPC
 *
 *  @param imageInfoDict image info dict
 */
- (void)sendIconRPC:(NSMutableDictionary *)imageInfoDict
{
    SDLSetAppIcon *appIcon = [SDLSetAppIcon new];
    appIcon.syncFileName = imageInfoDict.imageNameOfMd5String;
    appIcon.correlationID = [NSNumber numberWithInteger:imageInfoDict.imageShowCorrelationID];
    [self.putImageSyncProxy sendRPC:appIcon];
}

/**
 *  set app icon response
 *
 *  @param response <#response description#>
 */
-(void) onSetAppIconResponse:(SDLSetAppIconResponse*) response
{
    
}
@end
