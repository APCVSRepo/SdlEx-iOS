//
//  FORDPutImageFile.m
//  ShowImagePackageDemo
//
//  Created by like on 16/2/24.
//  Copyright © 2016年 like. All rights reserved.
//

#import "FORDPutImageFile.h"
#import <CommonCrypto/CommonDigest.h>//md5

@interface FORDPutImageFile ()<SDLProxyListener, NSURLConnectionDataDelegate>
{
    NSMutableDictionary *iconImageDict;//icon
    NSMutableDictionary *showImageDict;//show
    NSMutableDictionary *softButtonImageDict;//softButton
    NSMutableDictionary *addCommandImageDict;//addCommand
    NSMutableDictionary *choiceImageDict;//choice
    
    NSMutableData *imageDataOfNetwork;//network image data receive
}
@end
@implementation FORDPutImageFile
/**
 *  init
 *
 *  @param proxySync SDLProxy
 *
 *  @return id self
 */
- (id)initWithSync:(SDLProxy *)proxySync
{
    self = [super init];
    if (self) {
        self.putImageSyncProxy = proxySync;
        [self.putImageSyncProxy addDelegate:self];
    }
    return self;
}

/**
 *  release PutImageFile object
 */
- (void)releasePutImageFile
{
    self.putIconResultBlock = nil;
    self.putShowResultBlock = nil;
    self.putSoftButtonResultBlock = nil;
    self.putCommandResultBlock = nil;
    self.putPerformInteractionResultBlock = nil;
    self.getNetworkImageDataBlcok = nil;
    self.putImageSyncProxy = nil;
}

/**
 *  send kind of icon's image info dict to array
 *
 *  @param imageFileDict image file info's dict
 */
- (void)putIconImageFile:(NSDictionary *)imageFileDict
{
    iconImageDict = nil;
    iconImageDict = [[NSMutableDictionary alloc] initWithDictionary:imageFileDict];
    //put icon image
    [self sendRPCOfPutFile:iconImageDict];
}

/**
 *  send kind of show's image info dict to array
 *
 *  @param imageFileDict image file info's dict
 */
- (void)putShowImageFile:(NSDictionary *)imageFileDict
{
    showImageDict = nil;
    showImageDict = [[NSMutableDictionary alloc] initWithDictionary:imageFileDict];
    //put show image
    [self sendRPCOfPutFile:showImageDict];
}

/**
 *  send kind of softButton's image info dict to array
 *
 *  @param imageFileDict image file info's dict
 */
- (void)putSoftButtonImageFile:(NSDictionary *)imageFileDict
{
    softButtonImageDict = nil;
    softButtonImageDict = [[NSMutableDictionary alloc] initWithDictionary:imageFileDict];
    //put softButton image
    [self sendRPCOfPutFile:softButtonImageDict];
}

/**
 *  send kind of addCommand's image info dict to array
 *
 *  @param imageFileDict image file info's dict
 */
- (void)putAddCommandImageFile:(NSDictionary *)imageFileDict
{
    addCommandImageDict = nil;
    addCommandImageDict = [[NSMutableDictionary alloc] initWithDictionary:imageFileDict];
    //put addCommand image
    [self sendRPCOfPutFile:addCommandImageDict];
}

/**
 *  send kind of choice's image info dict to array
 *
 *  @param imageFileDict image file info's dict
 */
- (void)putChoiceImageFile:(NSDictionary *)imageFileDict
{
    choiceImageDict = nil;
    choiceImageDict = [[NSMutableDictionary alloc] initWithDictionary:imageFileDict];
    //put choice image
    [self sendRPCOfPutFile:choiceImageDict];
}

/**
 *  get the name of the image through the md5 encryption and image data
 *
 *  @param imageFileDict image data dictionary
 */
- (void)sendRPCOfPutFile:(NSMutableDictionary *)imageFileDict
{
    //lock up: one by one
    @synchronized(self) {
        //if the value of local path is valid
        if (imageFileDict.imageLocalOfNetworkPathString && imageFileDict.imageLocalOfNetworkPathString.length > 0) {
            //image's data
            NSData *imageData = nil;
            
            //get image's type (png|jpg|bmp) default is png
            SDLFileType *fileType = [SDLFileType GRAPHIC_PNG];
            if ([imageFileDict.imageLocalOfNetworkPathString rangeOfString:@".jpg"].location != NSNotFound || [imageFileDict.imageLocalOfNetworkPathString rangeOfString:@".jpeg"].location != NSNotFound) {
                fileType = [SDLFileType GRAPHIC_JPEG];
            }else if ([imageFileDict.imageLocalOfNetworkPathString rangeOfString:@".bmp"].location != NSNotFound) {
                fileType = [SDLFileType GRAPHIC_BMP];
            }
            //judge image's source and deal with itSelf style
            switch (imageFileDict.imageSourceType) {
                case SendImageOfSourceTypeOfBundle:
                {
                    //get image from bundle
                    UIImage *sendImage = [UIImage imageNamed:imageFileDict.imageNameOfLocalString];
                    //judge image type
                    if (fileType == [SDLFileType GRAPHIC_PNG]) {
                        imageData = UIImagePNGRepresentation(sendImage);
                    }else if (fileType == [SDLFileType GRAPHIC_JPEG]) {
                        imageData = UIImageJPEGRepresentation(sendImage, 0.01);
                    }else if (fileType == [SDLFileType GRAPHIC_BMP]) {
                        if ([imageFileDict.imageNameOfLocalString rangeOfString:@".bmp"].location != NSNotFound) {
                            NSString *bmpBundlePath = [[NSBundle mainBundle] pathForResource:[imageFileDict.imageNameOfLocalString substringToIndex:imageFileDict.imageNameOfLocalString.length-4] ofType:@"bmp"];
                            imageData = [NSData dataWithContentsOfFile:bmpBundlePath];
                        }
                    }
                }
                    break;
                case SendImageOfSourceTypeOfSandbox:
                {
                    //get image data from sandbox
                    imageData = [NSData dataWithContentsOfFile:imageFileDict.imageLocalOfNetworkPathString];
                }
                    break;
                case SendImageOfSourceTypeOfNetwork:
                {
                    //get image data from network
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSURL *imageUrl = [NSURL URLWithString:imageFileDict.imageLocalOfNetworkPathString];
                        NSURLRequest* request = [NSURLRequest requestWithURL:imageUrl cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
                        [NSURLConnection connectionWithRequest:request delegate:self];
                        //get image data block
                        __weak __typeof(self)weakSelf = self;
                        [self setGetNetworkImageDataBlcok:^(NSData *imageData) {
                            __strong __typeof(weakSelf) strongSelf = weakSelf;
                            //send RPC
                            [strongSelf sendRPCOfPutFile:imageFileDict withFileType:fileType withImageData:imageData];
                        }];
                        //don't need to perform
                    });
                    return;
                }
                    break;
                default:
                    break;
            }
            //send RPC
            [self sendRPCOfPutFile:imageFileDict withFileType:fileType withImageData:imageData];
        }
    }
}

#pragma mark <!-----------network image data receive start
//image data receive start
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    imageDataOfNetwork = nil;
    imageDataOfNetwork = [[NSMutableData alloc] init];
//    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}
//image data receive
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    //append data
    if (imageDataOfNetwork) {
        [imageDataOfNetwork appendData:data];
    }
}
//image data download finish
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if (self.getNetworkImageDataBlcok) {
        self.getNetworkImageDataBlcok(imageDataOfNetwork);
    }
//    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}
//image data download fail
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    if (self.getNetworkImageDataBlcok) {
        self.getNetworkImageDataBlcok(nil);
    }
//    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    NSLog(@"image data download fail");
}
#pragma mark network image receive end-------->

/**
 *  send RPC of SDLPutFile
 *
 *  @param imageFileDict image data dictionary
 *  @param fileType      SDLFileType
 *  @param imageData     image data
 */
- (void)sendRPCOfPutFile:(NSMutableDictionary *)imageFileDict withFileType:(SDLFileType *)fileType withImageData:(NSData *)imageData
{
    //if imageData is nil, block
    if (!imageData) {
        //judge correlationID and block isn't nil
        if (imageFileDict.imagePutFileCorrelationID == iconImageDict.imagePutFileCorrelationID && self.putIconResultBlock) {
            //SDLSetAppIcon
            self.putIconResultBlock(nil, iconImageDict);
        }else if (imageFileDict.imagePutFileCorrelationID == showImageDict.imagePutFileCorrelationID && self.putShowResultBlock) {
            //SDLShow
            self.putShowResultBlock(nil, showImageDict);
        }else if (imageFileDict.imagePutFileCorrelationID == softButtonImageDict.imagePutFileCorrelationID && self.putSoftButtonResultBlock) {
            //SDLSoftButton
            self.putSoftButtonResultBlock(nil, softButtonImageDict);
        }else if (imageFileDict.imagePutFileCorrelationID == addCommandImageDict.imagePutFileCorrelationID && self.putCommandResultBlock) {
            //SDLAddCommand
            self.putCommandResultBlock(nil, addCommandImageDict);
        }else if (imageFileDict.imagePutFileCorrelationID == choiceImageDict.imagePutFileCorrelationID && self.putPerformInteractionResultBlock) {
            //SDLChoice
            self.putPerformInteractionResultBlock(nil, choiceImageDict);
        }
    }else {
        //get image's md5 name through image data
        imageFileDict.imageNameOfMd5String = [FORDPutImageFile getMD5WithData:imageData];
        //send image to sync
        SDLPutFile *putFile = [[SDLPutFile alloc] init];
        putFile.fileType = fileType;
        putFile.syncFileName = imageFileDict.imageNameOfMd5String;
        putFile.bulkData = imageData;
        putFile.length = [NSNumber numberWithInteger:imageData.length];
        putFile.offset = [NSNumber numberWithInt:0];
        putFile.persistentFile = [NSNumber numberWithBool:NO];
        putFile.correlationID = [NSNumber numberWithInteger:imageFileDict.imagePutFileCorrelationID];
        //send
        [self.putImageSyncProxy sendRPC:putFile];
    }
}

/**
 *  put file response
 *
 *  @param response nil
 */
- (void)onPutFileResponse:(SDLPutFileResponse *)response
{
    //judge correlationID and block isn't nil
    if ([response.correlationID integerValue] == iconImageDict.imagePutFileCorrelationID && self.putIconResultBlock) {
        //SDLSetAppIcon
        self.putIconResultBlock(response, iconImageDict);
    }else if ([response.correlationID integerValue] == showImageDict.imagePutFileCorrelationID && self.putShowResultBlock) {
        //SDLShow
        self.putShowResultBlock(response, showImageDict);
    }else if ([response.correlationID integerValue] == softButtonImageDict.imagePutFileCorrelationID && self.putSoftButtonResultBlock) {
        //SDLSoftButton
        self.putSoftButtonResultBlock(response, softButtonImageDict);
    }else if ([response.correlationID integerValue] == addCommandImageDict.imagePutFileCorrelationID && self.putCommandResultBlock) {
        //SDLAddCommand
        self.putCommandResultBlock(response, addCommandImageDict);
    }else if ([response.correlationID integerValue] == choiceImageDict.imagePutFileCorrelationID && self.putPerformInteractionResultBlock) {
        //SDLChoice
        self.putPerformInteractionResultBlock(response, choiceImageDict);
    }
}

/**
 *  get md5 value
 *
 *  @param data info data
 *
 *  @return md5 value
 */
+ (NSString*)getMD5WithData:(NSData *)data
{
    CC_MD5_CTX md5;
    CC_MD5_Init(&md5);
    CC_MD5_Update(&md5, [data bytes], [data length]);
    unsigned char digist[CC_MD5_DIGEST_LENGTH];
    CC_MD5_Final(digist, &md5);
    NSMutableString* outPutStr = [NSMutableString stringWithCapacity:10];
    for(int i =0; i<CC_MD5_DIGEST_LENGTH;i++){
        [outPutStr appendFormat:@"%02x",digist[i]];// 小写 x 表示输出的是小写 MD5 ，大写 X 表示输出的是大写 MD5
    }
    outPutStr = (NSMutableString *)[outPutStr substringToIndex:25];
    return [outPutStr lowercaseString];
}
@end
