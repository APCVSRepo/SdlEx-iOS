//
//  FORDSendShowImage.m
//  ShowImagePackageDemo
//
//  Created by like on 16/2/24.
//  Copyright © 2016年 like. All rights reserved.
//

#import "FORDSendShowImage.h"
@interface FORDSendShowImage ()
{
    dispatch_queue_t sendShowSerialQueue;//icon队列
}
@end
@implementation FORDSendShowImage

/**
 *  release show of SendImage object
 */
- (void)releaseAllKindsOfSendImageObject
{
    sendShowSerialQueue = nil;
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
    if (!sendShowSerialQueue) {
        sendShowSerialQueue = dispatch_queue_create("sendShowSerialQueue", DISPATCH_QUEUE_SERIAL);
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

/**
 *  put image data
 */
- (void)sendImageToPutFileClass
{
    dispatch_async(sendShowSerialQueue, ^{
        if ([self.sendImageDictArray count] > 0) {
            __weak __typeof(self)weakSelf = self;
            //block
            [self.putImageFileObject setPutShowResultBlock:^(SDLPutFileResponse *response, NSMutableDictionary *imageInfoDict) {
                __strong __typeof(weakSelf)strongSelf = weakSelf;
                //judge result if YES=sendRPC NO=fail
                if (response && response.resultCode == [SDLResult SUCCESS]) {
                    //sendRPC
                    if ([imageInfoDict[@"displayLayout"] isEqualToString:@"DOUBLE_GRAPHIC_WITH_SOFTBUTTONS"]) {//double iamges
                        //the position of image
                        switch ([imageInfoDict[@"imagePositionOnScreen"] intValue]) {
                            case 1://first image
                                [strongSelf sendShowRPC:imageInfoDict withShowPosition:1];
                                break;
                            case 2://second image
                                [strongSelf sendShowRPC:imageInfoDict withShowPosition:2];
                                break;
                            default:
                                break;
                        }
                    }else {//single image
                        [strongSelf sendShowRPC:imageInfoDict withShowPosition:1];
                    }
                }else {
                    //fail
                }
                //delete finish image info
                if ([strongSelf.sendImageDictArray count] > 0) {
                    [strongSelf.sendImageDictArray removeObjectAtIndex:0];
                }
                //the current block is finish, so release
                strongSelf.putImageFileObject.putShowResultBlock = nil;
                //recycle send image info
                [strongSelf sendImageToPutFileClass];
            }];
            //put show image info
            [self.putImageFileObject putShowImageFile:[self.sendImageDictArray firstObject]];
        }
    });
}

/**
 *  send show RPC
 *
 *  @param imageInfoDict image data dictionary
 */
- (void)sendShowRPC:(NSMutableDictionary *)imageInfoDict withShowPosition:(NSInteger)position
{
    //init SDLImage
    SDLImage *showImage = [SDLImage new];
    showImage.value = imageInfoDict.imageNameOfMd5String;
    showImage.imageType = [SDLImageType DYNAMIC];//must use DYNAMIC
    
    //init SDLShow
    SDLShow *show = [SDLShow new];
    switch (position) {
        case 1:
            show.graphic = showImage;//first image
            break;
        case 2:
            show.secondaryGraphic = showImage;//second image
            break;
        default:
            break;
    }
    show.correlationID = [NSNumber numberWithInteger:imageInfoDict.imageShowCorrelationID];
    [self.putImageSyncProxy sendRPC:show];
}

/**
 *  implement app show response
 *
 *  @param response SDLShow Response
 */
- (void)onShowResponse:(SDLShowResponse *)response
{
    
}
@end
