//
//  FORDSendSoftButtonImage.m
//  ShowImagePackageDemo
//
//  Created by like on 16/2/24.
//  Copyright © 2016年 like. All rights reserved.
//

#import "FORDSendSoftButtonImage.h"
@interface FORDSendSoftButtonImage ()
{
    dispatch_queue_t sendSoftButtonSerialQueue;//softButton queue
}
@end
@implementation FORDSendSoftButtonImage
@synthesize sendImageDictArray = _sendImageDictArray;

/**
 *  release softButton of SendImage object
 */
- (void)releaseAllKindsOfSendImageObject
{
    sendSoftButtonSerialQueue = nil;
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
- (void)setSendImageDictArray:(NSMutableArray *)sendImageDictArray
{
    if (!sendSoftButtonSerialQueue) {
        sendSoftButtonSerialQueue = dispatch_queue_create("sendSoftButtonSerialQueue", DISPATCH_QUEUE_SERIAL);
    }
    _sendImageDictArray = sendImageDictArray;
    //if array count is 1, call send function
    if (self.sendImageDictArray) {
        [self sendImageToPutFileClass];
    }
}

/**
 *  to add softButton in the array
 *
 *  @param softButtonArray the value of softButton array
 */
- (void)setSoftButtonArray:(NSMutableArray *)softButtonArray
{
    _softButtonArray = softButtonArray;
}

/**
 *  to send RPC with only text
 *
 *  @param correlationIDOfText the only text softButton RPC's correlationID
 */
- (void)setCorrelationIDOfText:(NSInteger)correlationIDOfText
{
    _correlationIDOfText = correlationIDOfText;
    //softButton array and image array must valid
    SDLShow *show = [SDLRPCRequestFactory buildShowWithMainField1:nil mainField2:nil mainField3:nil mainField4:nil statusBar:nil mediaClock:nil mediaTrack:nil alignment:nil graphic:nil softButtons:self.softButtonArray customPresets:nil correlationID:[NSNumber numberWithInteger:correlationIDOfText]];
    [self.putImageSyncProxy sendRPC:show];
}

//put image
- (void)sendImageToPutFileClass
{
    dispatch_async(sendSoftButtonSerialQueue, ^{
        if ([self.sendImageDictArray count] > 0) {
            __weak __typeof(self)weakSelf = self;
            //block
            [self.putImageFileObject setPutSoftButtonResultBlock:^(SDLPutFileResponse *response, NSMutableDictionary *imageInfoDict) {
                __strong __typeof(weakSelf)strongSelf = weakSelf;
                //judge result if YES=sendRPC NO=fail
                if (response && response.resultCode == [SDLResult SUCCESS]) {
                    //sendRPC
                    [strongSelf sendSoftButtonRPC:imageInfoDict];
                }else {
                    //fail
                }
                //delete finish image info
                if ([strongSelf.sendImageDictArray count] > 0) {
                    [strongSelf.sendImageDictArray removeObjectAtIndex:0];
                }
                //the current block is finish, so release
                strongSelf.putImageFileObject.putSoftButtonResultBlock = nil;
                //recycle send image info
                [strongSelf sendImageToPutFileClass];
            }];
            //put softButton image info
            [self.putImageFileObject putSoftButtonImageFile:[self.sendImageDictArray firstObject]];
        }
    });
}

/**
 *  send softButton RPC
 *
 *  @param imageInfoDict image data dictionary
 */
- (void)sendSoftButtonRPC:(NSMutableDictionary *)imageInfoDict
{
    //get array count
    NSInteger imageArrayCount = [self.sendImageDictArray count];
    NSInteger softButtonCount = [self.softButtonArray count];
    //get softButton
    SDLSoftButton *softButton = (SDLSoftButton *)[self.softButtonArray objectAtIndex:softButtonCount-imageArrayCount];
    //change and replace the image info of softButton
    SDLImage *softButtonImage = [SDLImage new];
    softButtonImage.value = imageInfoDict.imageNameOfMd5String;
    softButtonImage.imageType = [SDLImageType DYNAMIC];
    softButton.image = softButtonImage;
    //send show RPC
    SDLShow *show = [SDLRPCRequestFactory buildShowWithMainField1:nil mainField2:nil mainField3:nil mainField4:nil statusBar:nil mediaClock:nil mediaTrack:nil alignment:nil graphic:nil softButtons:self.softButtonArray customPresets:nil correlationID:[NSNumber numberWithInteger:imageInfoDict.imageShowCorrelationID]];
    [self.putImageSyncProxy sendRPC:show];
}

/**
 *  implement app softButton response
 *
 *  @param response SDLSoftButton Response
 */
- (void)onShowResponse:(SDLShowResponse *)response
{
    
}
@end
