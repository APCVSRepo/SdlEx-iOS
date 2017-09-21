//
//  SendImageBaseClass.m
//  ShowImagePackageDemo
//
//  Created by like on 16/2/24.
//  Copyright © 2016年 like. All rights reserved.
//

#import "FORDSendImageBaseClass.h"
@implementation FORDSendImageBaseClass

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
        self.sendImageDict = [[NSMutableDictionary alloc]init];
        self.sendImageDictArray = [[NSMutableArray alloc]init];
        self.putImageSyncProxy = proxySync;
        [self.putImageSyncProxy addDelegate:self];
        self.putImageFileObject = [[FORDPutImageFile alloc] initWithSync:proxySync];
    }
    return self;
}
@end
