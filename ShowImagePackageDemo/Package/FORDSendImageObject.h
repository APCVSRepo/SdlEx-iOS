//
//  FORDSendImageObject.h
//  ShowImagePackageDemo
//
//  Created by like on 16/2/24.
//  Copyright © 2016年 like. All rights reserved.
//
//  Send the picture to TDK transfer classes (ICON|SHOW|SOFTBUTTON|COMMAND|CHOICE)

#import <Foundation/Foundation.h>
#import "FORDSendImageBaseClass.h"

@interface FORDSendImageObject : NSObject

/**
 *  get FORDSendImageObject
 *
 *  @param proxySync SDLProxy
 *
 *  @return FORDSendImageObject
 */
+ (FORDSendImageObject *)shareSendImageObjectWithSync:(SDLProxy *)proxySync;

#pragma mark <--------put image file start
/**
 *  put icon image
 *
 *  @param imageDict image data dictionary
 */
- (void)putIconImage:(NSMutableDictionary *)imageDict;

/**
 *  put show image
 *
 *  @param imageDict image data dictionary
 */
- (void)putShowImage:(NSMutableDictionary *)imageDict;

/**
 *  put softButton image
 *
 *  @param imageArray      image array
 *  @param softButtonArray softButton array
 *  @param correlationID the only text softButton RPC's correlationID
 */
- (void)putSoftButtonImage:(NSMutableArray *)imageArray withSoftButtonArray:(NSMutableArray *)softButtonArray withTextCorrelationID:(NSInteger)correlationID;

/**
 *  put Command image
 *
 *  @param imageDict image data dictionary
 *  @param command SDLAddCommand
 */
- (void)putCommandImage:(NSMutableDictionary *)imageDict withCommand:(SDLAddCommand *)command;

/**
 *  put PerformInteractionOfChoice image
 *
 *  @param imageDict image data dictionary
 */
- (void)putPerformInteractionOfChoiceImage:(NSMutableDictionary *)imageDict;
#pragma mark put image file end---------->
@end
