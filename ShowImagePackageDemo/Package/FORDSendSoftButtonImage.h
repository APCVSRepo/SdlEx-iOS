//
//  FORDSendSoftButtonImage.h
//  ShowImagePackageDemo
//
//  Created by like on 16/2/24.
//  Copyright © 2016年 like. All rights reserved.
//
//  send SDLSoftButton image class

#import <Foundation/Foundation.h>
#import "FORDSendImageBaseClass.h"

@interface FORDSendSoftButtonImage : FORDSendImageBaseClass

@property (strong, nonatomic) NSMutableArray *softButtonArray;//softButton array
@property (assign, nonatomic) NSInteger correlationIDOfText;//the only text softButton RPC's correlationID
@end
