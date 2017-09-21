//
//  SendImageBaseClass.h
//  ShowImagePackageDemo
//
//  Created by like on 16/2/24.
//  Copyright © 2016年 like. All rights reserved.
//
//  The base class for all classes display pictures

#import <Foundation/Foundation.h>
#import "FORDPutImageFile.h"

@interface FORDSendImageBaseClass : NSObject<SDLProxyListener>

@property (strong, nonatomic)NSMutableDictionary *sendImageDict;//save image info dict
@property (strong, nonatomic)NSMutableArray *sendImageDictArray;//save image info dict's array
@property (strong, nonatomic)SDLProxy *putImageSyncProxy;//sync
@property (assign, nonatomic)NSInteger putImageAutoIncCorrID;//id
@property (strong, nonatomic)FORDPutImageFile *putImageFileObject;//put file

/**
 *  init
 *
 *  @param proxySync SDLProxy
 *
 *  @return id self
 */
- (id)initWithSync:(SDLProxy *)proxySync;

/**
 *  release all kinds of SendImage object
 */
- (void)releaseAllKindsOfSendImageObject;
@end
