//
//  ViewController.m
//  ShowImagePackageDemo
//
//  Created by like on 15/8/27.
//  Copyright (c) 2015年 like. All rights reserved.
//
#define MORE_ICON_BUNDLE 20001
#define MORE_ICON_SANDBOX 20002
#define MORE_ICON_NETWORK 20003

#define MORE_SHOW_BUNDLE 20004
#define MORE_SHOW_SANDBOX 20005
#define MORE_SHOW_NETWORK 20006

#define MORE_SHOW_BUNDLE_JPG 20007
#define MORE_SHOW_SANDBOX_JPG 20008
#define MORE_SHOW_NETWORK_JPG 20009

#define MORE_ICON_BUNDLE_JPG 20010
#define MORE_ICON_SANDBOX_JPG 20011
#define MORE_ICON_NETWORK_JPG 20012

#define MORE_SHOW_BUNDLE_BMP 20013
#define MORE_SHOW_SANDBOX_BMP 20014
#define MORE_SHOW_NETWORK_BMP 20015

#define MORE_SHOW_LAYOUT_DOUBLE_GRAPHIC 20016
#define MORE_SHOW_LAYOUT_LARGE_GRAPHIC 20017

#define MORE_SHOW_SOFTBUTTON 20018
#define MORE_SHOW_ADDCOMMAND 20019
#define MORE_SHOW_PERFORMINTERACTION 20020

#import "ViewController.h"
#import <SmartDeviceLink/SmartDeviceLink.h>
/**
 *  send image class
 *
 *  @return <#return value description#>
 */
#import "FORDSendImageObject.h"

@interface ViewController ()<SDLProxyListener,NSURLSessionDataDelegate>
{
    SDLProxy *_syncProxy;//
    NSInteger _autoIncCorrID;//id 按钮menu等的id值 ++
    BOOL _syncInitialized;//判断第一次加载
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupProxy];
    
    //remind choice's notification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getSendChoiceImageState:) name:@"FORDSendChoiceImageNotification" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  注册APPLink
 */
- (void)setupProxy
{
    _syncProxy = [SDLProxyFactory buildSDLProxyWithListener:self];
    _autoIncCorrID = 101;
    [SDLDebugTool logInfo:@"Created SyncProxy instance"];
}

/**
 *  注册更多列表按钮 用于测试不同图片的添加
 */
- (void)registerMoreCommand
{
    /**
     *  添加‘测试图片’按钮（icon、show）
     */
    SDLAddCommand *iconBundleCommand = [SDLRPCRequestFactory buildAddCommandWithID:[NSNumber numberWithInt:MORE_ICON_BUNDLE] menuName:@"icon-工程内" parentID:0 position:[NSNumber numberWithInt:0] vrCommands:nil iconValue:nil iconType:nil correlationID:[NSNumber numberWithInteger:_autoIncCorrID++]];
    [_syncProxy sendRPC:iconBundleCommand];
    SDLAddCommand *iconSandboxCommand = [SDLRPCRequestFactory buildAddCommandWithID:[NSNumber numberWithInt:MORE_ICON_SANDBOX] menuName:@"icon-沙盒" parentID:0 position:[NSNumber numberWithInt:1] vrCommands:nil iconValue:nil iconType:nil correlationID:[NSNumber numberWithInteger:_autoIncCorrID++]];
    [_syncProxy sendRPC:iconSandboxCommand];
    SDLAddCommand *iconNetworkCommand = [SDLRPCRequestFactory buildAddCommandWithID:[NSNumber numberWithInt:MORE_ICON_NETWORK] menuName:@"icon-网络" parentID:0 position:[NSNumber numberWithInt:2] vrCommands:nil iconValue:nil iconType:nil correlationID:[NSNumber numberWithInteger:_autoIncCorrID++]];
    [_syncProxy sendRPC:iconNetworkCommand];
    
    SDLAddCommand *showBundleCommand = [SDLRPCRequestFactory buildAddCommandWithID:[NSNumber numberWithInt:MORE_SHOW_BUNDLE] menuName:@"show-工程内" parentID:0 position:[NSNumber numberWithInt:3] vrCommands:nil iconValue:nil iconType:nil correlationID:[NSNumber numberWithInteger:_autoIncCorrID++]];
    [_syncProxy sendRPC:showBundleCommand];
    SDLAddCommand *showSandboxCommand = [SDLRPCRequestFactory buildAddCommandWithID:[NSNumber numberWithInt:MORE_SHOW_SANDBOX] menuName:@"show-沙盒" parentID:0 position:[NSNumber numberWithInt:4] vrCommands:nil iconValue:nil iconType:nil correlationID:[NSNumber numberWithInteger:_autoIncCorrID++]];
    [_syncProxy sendRPC:showSandboxCommand];
    SDLAddCommand *showNetworkCommand = [SDLRPCRequestFactory buildAddCommandWithID:[NSNumber numberWithInt:MORE_SHOW_NETWORK] menuName:@"show-网络" parentID:0 position:[NSNumber numberWithInt:5] vrCommands:nil iconValue:nil iconType:nil correlationID:[NSNumber numberWithInteger:_autoIncCorrID++]];
    [_syncProxy sendRPC:showNetworkCommand];
    
    SDLAddCommand *showBundleCommand_jpg = [SDLRPCRequestFactory buildAddCommandWithID:[NSNumber numberWithInt:MORE_SHOW_BUNDLE_JPG] menuName:@"show-工程内_jpg" parentID:0 position:[NSNumber numberWithInt:6] vrCommands:nil iconValue:nil iconType:nil correlationID:[NSNumber numberWithInteger:_autoIncCorrID++]];
    [_syncProxy sendRPC:showBundleCommand_jpg];
    
    SDLAddCommand *showSandboxCommand_jpg = [SDLRPCRequestFactory buildAddCommandWithID:[NSNumber numberWithInt:MORE_SHOW_SANDBOX_JPG] menuName:@"show-沙盒中_jpg" parentID:0 position:[NSNumber numberWithInt:7] vrCommands:nil iconValue:nil iconType:nil correlationID:[NSNumber numberWithInteger:_autoIncCorrID++]];
    [_syncProxy sendRPC:showSandboxCommand_jpg];
    
    SDLAddCommand *showNetworkCommand_jpg = [SDLRPCRequestFactory buildAddCommandWithID:[NSNumber numberWithInt:MORE_SHOW_NETWORK_JPG] menuName:@"show-网络_jpg" parentID:0 position:[NSNumber numberWithInt:8] vrCommands:nil iconValue:nil iconType:nil correlationID:[NSNumber numberWithInteger:_autoIncCorrID++]];
    [_syncProxy sendRPC:showNetworkCommand_jpg];
    
    SDLAddCommand *iconBundleCommand_jpg = [SDLRPCRequestFactory buildAddCommandWithID:[NSNumber numberWithInt:MORE_ICON_BUNDLE_JPG] menuName:@"icon-工程内_jpg" parentID:0 position:[NSNumber numberWithInt:9] vrCommands:nil iconValue:nil iconType:nil correlationID:[NSNumber numberWithInteger:_autoIncCorrID++]];
    [_syncProxy sendRPC:iconBundleCommand_jpg];
    
    SDLAddCommand *iconSandboxCommand_jpg = [SDLRPCRequestFactory buildAddCommandWithID:[NSNumber numberWithInt:MORE_ICON_SANDBOX_JPG] menuName:@"icon-沙盒中_jpg" parentID:0 position:[NSNumber numberWithInt:10] vrCommands:nil iconValue:nil iconType:nil correlationID:[NSNumber numberWithInteger:_autoIncCorrID++]];
    [_syncProxy sendRPC:iconSandboxCommand_jpg];
    
    SDLAddCommand *iconNetworkCommand_jpg = [SDLRPCRequestFactory buildAddCommandWithID:[NSNumber numberWithInt:MORE_ICON_NETWORK_JPG] menuName:@"icon-网络_jpg" parentID:0 position:[NSNumber numberWithInt:11] vrCommands:nil iconValue:nil iconType:nil correlationID:[NSNumber numberWithInteger:_autoIncCorrID++]];
    [_syncProxy sendRPC:iconNetworkCommand_jpg];
    
    
    SDLAddCommand *showBundleCommand_bmp = [SDLRPCRequestFactory buildAddCommandWithID:[NSNumber numberWithInt:MORE_SHOW_BUNDLE_BMP] menuName:@"show-工程内_bmp" parentID:0 position:[NSNumber numberWithInt:12] vrCommands:nil iconValue:nil iconType:nil correlationID:[NSNumber numberWithInteger:_autoIncCorrID++]];
    [_syncProxy sendRPC:showBundleCommand_bmp];
    
    SDLAddCommand *showSandboxCommand_bmp = [SDLRPCRequestFactory buildAddCommandWithID:[NSNumber numberWithInt:MORE_SHOW_SANDBOX_BMP] menuName:@"show-沙盒中_bmp" parentID:0 position:[NSNumber numberWithInt:13] vrCommands:nil iconValue:nil iconType:nil correlationID:[NSNumber numberWithInteger:_autoIncCorrID++]];
    [_syncProxy sendRPC:showSandboxCommand_bmp];
    
    SDLAddCommand *showNetworkCommand_bmp = [SDLRPCRequestFactory buildAddCommandWithID:[NSNumber numberWithInt:MORE_SHOW_NETWORK_BMP] menuName:@"show-网络_bmp" parentID:0 position:[NSNumber numberWithInt:14] vrCommands:nil iconValue:nil iconType:nil correlationID:[NSNumber numberWithInteger:_autoIncCorrID++]];
    [_syncProxy sendRPC:showNetworkCommand_bmp];
    
    
    /**
     *  添加‘测试两种Layout的模式下的图片展示’按钮
     *  DOUBLE_GRAPHIC_WITH_SOFTBUTTONS|LARGE_GRAPHIC_ONLY
     */
    
    SDLAddCommand *showLayoutOfDOUBLE_GRAPHIC = [SDLRPCRequestFactory buildAddCommandWithID:[NSNumber numberWithInt:MORE_SHOW_LAYOUT_DOUBLE_GRAPHIC] menuName:@"show-layout-两张图片" parentID:0 position:[NSNumber numberWithInt:15] vrCommands:nil iconValue:nil iconType:nil correlationID:[NSNumber numberWithInteger:_autoIncCorrID++]];
    [_syncProxy sendRPC:showLayoutOfDOUBLE_GRAPHIC];
    SDLAddCommand *showLayoutOfLARGE_GRAPHIC = [SDLRPCRequestFactory buildAddCommandWithID:[NSNumber numberWithInt:MORE_SHOW_LAYOUT_LARGE_GRAPHIC] menuName:@"show-layout-一张大图片" parentID:0 position:[NSNumber numberWithInt:16] vrCommands:nil iconValue:nil iconType:nil correlationID:[NSNumber numberWithInteger:_autoIncCorrID++]];
    [_syncProxy sendRPC:showLayoutOfLARGE_GRAPHIC];
    
    
    /**
     *  添加'测试softButton按钮上的图片'按钮
     *
     */
    SDLAddCommand *showSoftButton = [SDLRPCRequestFactory buildAddCommandWithID:[NSNumber numberWithInt:MORE_SHOW_SOFTBUTTON] menuName:@"showSoftButton" parentID:0 position:[NSNumber numberWithInt:17] vrCommands:nil iconValue:nil iconType:nil correlationID:[NSNumber numberWithInteger:_autoIncCorrID++]];
    [_syncProxy sendRPC:showSoftButton];
    SDLAddCommand *showAddCommand = [SDLRPCRequestFactory buildAddCommandWithID:[NSNumber numberWithInt:MORE_SHOW_ADDCOMMAND] menuName:@"showAddCommand" parentID:0 position:[NSNumber numberWithInt:18] vrCommands:nil iconValue:nil iconType:nil correlationID:[NSNumber numberWithInteger:_autoIncCorrID++]];
    [_syncProxy sendRPC:showAddCommand];
    SDLAddCommand *showPerforminteraction = [SDLRPCRequestFactory buildAddCommandWithID:[NSNumber numberWithInt:MORE_SHOW_PERFORMINTERACTION] menuName:@"showPerforminteraction" parentID:0 position:[NSNumber numberWithInt:19] vrCommands:nil iconValue:nil iconType:nil correlationID:[NSNumber numberWithInteger:_autoIncCorrID++]];
    [_syncProxy sendRPC:showPerforminteraction];
}
/**
 *  添加APP展示的名称
 */
- (void)onProxyOpened
{
    [SDLDebugTool logInfo:@"onProxyOpened"];
    //这里的名称是选择应用列表中 显示的名称
    SDLRegisterAppInterface* raiRequest = [SDLRPCRequestFactory buildRegisterAppInterfaceWithAppName:@"测试图片" languageDesired:[SDLLanguage EN_US] appID:@"123456"];//APPID是必须的，是唯一的
    raiRequest.isMediaApplication = [NSNumber numberWithBool:YES];
    [_syncProxy sendRPC:raiRequest];
    
}

/**
 *  手动关闭或意外断开
 */
- (void)onProxyClosed
{
    //release sendImageObject
    [FORDSendImageObject shareSendImageObjectWithSync:nil];
    [SDLDebugTool logInfo:@"onProxyClosed"];
    //设置为NO
    _syncInitialized = NO;
    //重新建立起一个新的
    [self setupProxy];
}

-(void) onOnDriverDistraction:(SDLOnDriverDistraction*) notification
{
    
}

/**
 *  应用程序已正确连接致AppLink，可以添加真正的功能
 *
 *  @param notification <#notification description#>
 */
-(void) onOnHMIStatus:(SDLOnHMIStatus*) notification
{
    //判断四种状态 执行顺序：HMI_NONE->HMI_BACKGROUND->HMI_LIMITED->HMI_FULL
    if (notification.hmiLevel == SDLHMILevel.NONE) {//已经连接上，但是用户没有操作 | 选择“更多”里面的“退出应用”
        [SDLDebugTool logInfo:@"NONE"];
    }else if (notification.hmiLevel == SDLHMILevel.FULL) {//进入了此APP，并开始有了操作
        [SDLDebugTool logInfo:@"FULL"];
        //这个是用来判断是不是第一次，如果不是就不在执行了
        if (!_syncInitialized) {
//            [[SendImageObject shareSendImageObject] showAlertViewWithMsg:@"第一次"];
            //放在里面，因为会有拔掉usb 没有退出app的情况
            _syncInitialized = YES;
            [self registerMoreCommand];
        }
        //SDLShow
    }else if (notification.hmiLevel == SDLHMILevel.BACKGROUND) {//applink 切换了其他app
        [SDLDebugTool logInfo:@"HMI_BACKGROUND"];
    }else if (notification.hmiLevel == SDLHMILevel.LIMITED) {//离开了当前app，但是没有启动其他app
        [SDLDebugTool logInfo:@"HMI_LIMITED"];
    }
}

/**
 *  展示屏幕下方的按钮点击产生的回调, 在这里使用此来添加不同的图片
 *
 *  @param notification <#notification description#>
 */
-(void) onOnCommand:(SDLOnCommand*) notification
{
    //sandbox
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];//Documents目录
    
    int buttonTag = [notification.cmdID intValue];
    //twenty
    for (int i = 0; i < 1; i ++) {
        switch (buttonTag) {
            case MORE_ICON_BUNDLE:
            {
                //show icon of png format image of bundle
                NSMutableDictionary *iconDict = [[NSMutableDictionary alloc]init];
                iconDict.imageNameOfLocalString = @"logo.png";
                iconDict.imageLocalOfNetworkPathString = @"logo.png";
                iconDict.imageSourceType = SendImageOfSourceTypeOfBundle;
                iconDict.imageShowType = SendImageShowTypeOfIcon;
                iconDict.imagePutFileCorrelationID = _autoIncCorrID++;
                iconDict.imageShowCorrelationID = _autoIncCorrID++;
                [[FORDSendImageObject shareSendImageObjectWithSync:_syncProxy] putIconImage:iconDict];
            }
                break;
            case MORE_ICON_SANDBOX:
            {
                //show icon of png format image of sandbox
                NSMutableDictionary *iconDict = [[NSMutableDictionary alloc]init];
                iconDict.imageNameOfLocalString = @"image5.png";
                iconDict.imageLocalOfNetworkPathString = [documentsDirectory stringByAppendingPathComponent:@"image5.png"];
                iconDict.imageSourceType = SendImageOfSourceTypeOfSandbox;
                iconDict.imageShowType = SendImageShowTypeOfIcon;
                iconDict.imagePutFileCorrelationID = _autoIncCorrID++;
                iconDict.imageShowCorrelationID = _autoIncCorrID++;
                [[FORDSendImageObject shareSendImageObjectWithSync:_syncProxy] putIconImage:iconDict];
            }
                break;
            case MORE_ICON_NETWORK:
            {
                //show icon of png format image of network
                NSMutableDictionary *iconDict = [[NSMutableDictionary alloc]init];
                iconDict.imageNameOfLocalString = @"ninja.png";
                iconDict.imageLocalOfNetworkPathString = @"http://d.lanrentuku.com/down/png/1507/34yuanxing-icon/ninja.png";
                iconDict.imageSourceType = SendImageOfSourceTypeOfNetwork;
                iconDict.imageShowType = SendImageShowTypeOfIcon;
                iconDict.imagePutFileCorrelationID = _autoIncCorrID++;
                iconDict.imageShowCorrelationID = _autoIncCorrID++;
                [[FORDSendImageObject shareSendImageObjectWithSync:_syncProxy] putIconImage:iconDict];
            }
                break;
            case MORE_SHOW_BUNDLE:
            {
                //show png format image of bundle
                NSMutableDictionary *showDict = [[NSMutableDictionary alloc]init];
                showDict.imageNameOfLocalString = @"image5.png";
                showDict.imageLocalOfNetworkPathString = @"image5.png";
                showDict.imageSourceType = SendImageOfSourceTypeOfBundle;
                showDict.imageShowType = SendImageShowTypeOfShow;
                showDict.imagePutFileCorrelationID = _autoIncCorrID++;
                showDict.imageShowCorrelationID = _autoIncCorrID++;
                [[FORDSendImageObject shareSendImageObjectWithSync:_syncProxy] putShowImage:showDict];
            }
                break;
            case MORE_SHOW_SANDBOX:
            {
                //show png format image of sandbox
                NSMutableDictionary *showDict = [[NSMutableDictionary alloc]init];
                showDict.imageNameOfLocalString = @"image5.png";
                showDict.imageLocalOfNetworkPathString = [documentsDirectory stringByAppendingPathComponent:@"image5.png"];
                showDict.imageSourceType = SendImageOfSourceTypeOfSandbox;
                showDict.imageShowType = SendImageShowTypeOfShow;
                showDict.imagePutFileCorrelationID = _autoIncCorrID++;
                showDict.imageShowCorrelationID = _autoIncCorrID++;
                [[FORDSendImageObject shareSendImageObjectWithSync:_syncProxy] putShowImage:showDict];
            }
                break;
            case MORE_SHOW_NETWORK:
            {
                //show png format image of network
                NSMutableDictionary *showDict = [[NSMutableDictionary alloc]init];
                showDict.imageNameOfLocalString = @"ninja.png";
                showDict.imageLocalOfNetworkPathString = @"http://d.lanrentuku.com/down/png/1507/34yuanxing-icon/ninja.png";
                showDict.imageSourceType = SendImageOfSourceTypeOfNetwork;
                showDict.imageShowType = SendImageShowTypeOfShow;
                showDict.imagePutFileCorrelationID = _autoIncCorrID++;
                showDict.imageShowCorrelationID = _autoIncCorrID++;
                [[FORDSendImageObject shareSendImageObjectWithSync:_syncProxy] putShowImage:showDict];
            }
                break;
            case MORE_SHOW_BUNDLE_JPG:
            {
                //show jpg format image of bundle
                NSMutableDictionary *showDict = [[NSMutableDictionary alloc]init];
                showDict.imageNameOfLocalString = @"image2.jpg";
                showDict.imageLocalOfNetworkPathString = @"image2.jpg";
                showDict.imageSourceType = SendImageOfSourceTypeOfBundle;
                showDict.imageShowType = SendImageShowTypeOfShow;
                showDict.imagePutFileCorrelationID = _autoIncCorrID++;
                showDict.imageShowCorrelationID = _autoIncCorrID++;
                [[FORDSendImageObject shareSendImageObjectWithSync:_syncProxy] putShowImage:showDict];
            }
                break;
            case MORE_SHOW_SANDBOX_JPG:
            {
                //show jpg format image of sandbox
                NSMutableDictionary *showDict = [[NSMutableDictionary alloc]init];
                showDict.imageNameOfLocalString = @"image2.jpg";
                showDict.imageLocalOfNetworkPathString = [documentsDirectory stringByAppendingPathComponent:@"image2.jpg"];
                showDict.imageSourceType = SendImageOfSourceTypeOfSandbox;
                showDict.imageShowType = SendImageShowTypeOfShow;
                showDict.imagePutFileCorrelationID = _autoIncCorrID++;
                showDict.imageShowCorrelationID = _autoIncCorrID++;
                [[FORDSendImageObject shareSendImageObjectWithSync:_syncProxy] putShowImage:showDict];
            }
                break;
            case MORE_SHOW_NETWORK_JPG:
            {
                //show jpg format image of network
                NSMutableDictionary *showDict = [[NSMutableDictionary alloc]init];
                showDict.imageNameOfLocalString = @"a17647860.jpg";
                showDict.imageLocalOfNetworkPathString = @"http://k.zol-img.com.cn/dcbbs/17648/a17647860.jpg";
                showDict.imageSourceType = SendImageOfSourceTypeOfNetwork;
                showDict.imageShowType = SendImageShowTypeOfShow;
                showDict.imagePutFileCorrelationID = _autoIncCorrID++;
                showDict.imageShowCorrelationID = _autoIncCorrID++;
                [[FORDSendImageObject shareSendImageObjectWithSync:_syncProxy] putShowImage:showDict];
            }
                break;
            case MORE_ICON_BUNDLE_JPG:
            {
                //show icon of jpg format image of bundle
                NSMutableDictionary *iconDict = [[NSMutableDictionary alloc]init];
                iconDict.imageNameOfLocalString = @"image2.jpg";
                iconDict.imageLocalOfNetworkPathString = @"image2.jpg";
                iconDict.imageSourceType = SendImageOfSourceTypeOfBundle;
                iconDict.imageShowType = SendImageShowTypeOfIcon;
                iconDict.imagePutFileCorrelationID = _autoIncCorrID++;
                iconDict.imageShowCorrelationID = _autoIncCorrID++;
                [[FORDSendImageObject shareSendImageObjectWithSync:_syncProxy] putIconImage:iconDict];
            }
                break;
            case MORE_ICON_SANDBOX_JPG:
            {
                //show icon of jpg format image of sandbox
                NSMutableDictionary *iconDict = [[NSMutableDictionary alloc]init];
                iconDict.imageNameOfLocalString = @"image2.jpg";
                iconDict.imageLocalOfNetworkPathString = [documentsDirectory stringByAppendingPathComponent:@"image2.jpg"];
                iconDict.imageSourceType = SendImageOfSourceTypeOfSandbox;
                iconDict.imageShowType = SendImageShowTypeOfIcon;
                iconDict.imagePutFileCorrelationID = _autoIncCorrID++;
                iconDict.imageShowCorrelationID = _autoIncCorrID++;
                [[FORDSendImageObject shareSendImageObjectWithSync:_syncProxy] putIconImage:iconDict];
            }
                break;
            case MORE_ICON_NETWORK_JPG:
            {
                //show icon of jpg format image of network
                NSMutableDictionary *iconDict = [[NSMutableDictionary alloc]init];
                iconDict.imageNameOfLocalString = @"a17647860.jpg";
                iconDict.imageLocalOfNetworkPathString = @"http://k.zol-img.com.cn/dcbbs/17648/a17647860.jpg";
                iconDict.imageSourceType = SendImageOfSourceTypeOfNetwork;
                iconDict.imageShowType = SendImageShowTypeOfIcon;
                iconDict.imagePutFileCorrelationID = _autoIncCorrID++;
                iconDict.imageShowCorrelationID = _autoIncCorrID++;
                [[FORDSendImageObject shareSendImageObjectWithSync:_syncProxy] putIconImage:iconDict];
            }
                break;
            case MORE_SHOW_BUNDLE_BMP:
            {
                //show bmp format image of bundle
                NSMutableDictionary *showDict = [[NSMutableDictionary alloc]init];
                showDict.imageNameOfLocalString = @"image7.bmp";
                showDict.imageLocalOfNetworkPathString = @"image7.bmp";
                showDict.imageSourceType = SendImageOfSourceTypeOfBundle;
                showDict.imageShowType = SendImageShowTypeOfShow;
                showDict.imagePutFileCorrelationID = _autoIncCorrID++;
                showDict.imageShowCorrelationID = _autoIncCorrID++;
                [[FORDSendImageObject shareSendImageObjectWithSync:_syncProxy] putShowImage:showDict];
            }
                break;
            case MORE_SHOW_SANDBOX_BMP:
            {
                //show bmp format image of sandbox
                NSMutableDictionary *showDict = [[NSMutableDictionary alloc]init];
                showDict.imageNameOfLocalString = @"image7.bmp";
                showDict.imageLocalOfNetworkPathString = [documentsDirectory stringByAppendingPathComponent:@"image7.bmp"];
                showDict.imageSourceType = SendImageOfSourceTypeOfSandbox;
                showDict.imageShowType = SendImageShowTypeOfShow;
                showDict.imagePutFileCorrelationID = _autoIncCorrID++;
                showDict.imageShowCorrelationID = _autoIncCorrID++;
                [[FORDSendImageObject shareSendImageObjectWithSync:_syncProxy] putShowImage:showDict];
            }
                break;
            case MORE_SHOW_NETWORK_BMP:
            {
                //show bmp format image of network
                NSMutableDictionary *showDict = [[NSMutableDictionary alloc]init];
                showDict.imageNameOfLocalString = @"";
                showDict.imageLocalOfNetworkPathString = @"";
                showDict.imageSourceType = SendImageOfSourceTypeOfNetwork;
                showDict.imageShowType = SendImageShowTypeOfShow;
                showDict.imagePutFileCorrelationID = _autoIncCorrID++;
                showDict.imageShowCorrelationID = _autoIncCorrID++;
                [[FORDSendImageObject shareSendImageObjectWithSync:_syncProxy] putShowImage:showDict];
            }
                break;
            case MORE_SHOW_LAYOUT_DOUBLE_GRAPHIC:
            {
                //DOUBLE_GRAPHIC_WITH_SOFTBUTTONS
                SDLSetDisplayLayout *displayLayout = [[SDLSetDisplayLayout alloc]init];
                displayLayout.displayLayout = @"DOUBLE_GRAPHIC_WITH_SOFTBUTTONS";
                [_syncProxy sendRPC:displayLayout];
                
                //show image on 'DOUBLE_GRAPHIC_WITH_SOFTBUTTONS' layout screen
                NSMutableDictionary *firstGraphicDict = [[NSMutableDictionary alloc]init];
                firstGraphicDict.imageNameOfLocalString = @"logo.png";
                firstGraphicDict.imageLocalOfNetworkPathString = @"logo.png";
                firstGraphicDict.displayLayout = @"DOUBLE_GRAPHIC_WITH_SOFTBUTTONS";
                firstGraphicDict.imagePositionOnScreen = 1;
                firstGraphicDict.imageSourceType = SendImageOfSourceTypeOfBundle;
                firstGraphicDict.imageShowType = SendImageShowTypeOfShow;
                firstGraphicDict.imagePutFileCorrelationID = _autoIncCorrID++;
                firstGraphicDict.imageShowCorrelationID = _autoIncCorrID++;
                [[FORDSendImageObject shareSendImageObjectWithSync:_syncProxy] putShowImage:firstGraphicDict];
                
                NSMutableDictionary *secondGraphicDict = [[NSMutableDictionary alloc]init];
                secondGraphicDict.imageNameOfLocalString = @"a17647860.jpg";
                secondGraphicDict.imageLocalOfNetworkPathString = @"http://k.zol-img.com.cn/dcbbs/17648/a17647860.jpg";
                secondGraphicDict.displayLayout = @"DOUBLE_GRAPHIC_WITH_SOFTBUTTONS";
                secondGraphicDict.imagePositionOnScreen = 2;
                secondGraphicDict.imageSourceType = SendImageOfSourceTypeOfNetwork;
                secondGraphicDict.imageShowType = SendImageShowTypeOfShow;
                secondGraphicDict.imagePutFileCorrelationID = _autoIncCorrID++;
                secondGraphicDict.imageShowCorrelationID = _autoIncCorrID++;
                [[FORDSendImageObject shareSendImageObjectWithSync:_syncProxy] putShowImage:secondGraphicDict];
            }
                break;
            case MORE_SHOW_LAYOUT_LARGE_GRAPHIC:
            {
                //LARGE_GRAPHIC_ONLY
                SDLSetDisplayLayout *displayLayout = [[SDLSetDisplayLayout alloc]init];
                displayLayout.displayLayout = @"LARGE_GRAPHIC_ONLY";
                [_syncProxy sendRPC:displayLayout];
                
                //show image on 'DOUBLE_GRAPHIC_WITH_SOFTBUTTONS' layout screen
                NSMutableDictionary *firstGraphicDict = [[NSMutableDictionary alloc]init];
                firstGraphicDict.imageNameOfLocalString = @"image5.png";
                firstGraphicDict.imageLocalOfNetworkPathString = @"image5.png";
                firstGraphicDict.imageSourceType = SendImageOfSourceTypeOfBundle;
                firstGraphicDict.imageShowType = SendImageShowTypeOfShow;
                firstGraphicDict.imagePutFileCorrelationID = _autoIncCorrID++;
                firstGraphicDict.imageShowCorrelationID = _autoIncCorrID++;
                [[FORDSendImageObject shareSendImageObjectWithSync:_syncProxy] putShowImage:firstGraphicDict];
            }
                break;
            case MORE_SHOW_SOFTBUTTON:
            {
                //crate softButton image array
                NSMutableArray *showSoftButtonImageArray = [[NSMutableArray alloc]init];
                //first image
                NSMutableDictionary *firstImageDict = [[NSMutableDictionary alloc]init];
                firstImageDict.imageNameOfLocalString = @"softButtonImage.png";
                firstImageDict.imageLocalOfNetworkPathString = @"softButtonImage.png";
                firstImageDict.imageSourceType = SendImageOfSourceTypeOfBundle;
                firstImageDict.imageShowType = SendImageShowTypeOfShow;
                firstImageDict.imagePutFileCorrelationID = _autoIncCorrID++;
                firstImageDict.imageShowCorrelationID = _autoIncCorrID++;
                [showSoftButtonImageArray addObject:firstImageDict];
                //second image
                NSMutableDictionary *secondImageDict = [[NSMutableDictionary alloc]init];
                secondImageDict.imageNameOfLocalString = @"image2.jpg";
                secondImageDict.imageLocalOfNetworkPathString = @"image2.jpg";
                secondImageDict.imageSourceType = SendImageOfSourceTypeOfBundle;
                secondImageDict.imagePutFileCorrelationID = _autoIncCorrID++;
                secondImageDict.imageShowCorrelationID = _autoIncCorrID++;
                [showSoftButtonImageArray addObject:secondImageDict];
                //third image
                NSMutableDictionary *thirdImageDict = [[NSMutableDictionary alloc]init];
                thirdImageDict.imageNameOfLocalString = @"image7.bmp";
                thirdImageDict.imageLocalOfNetworkPathString = @"image7.bmp";
                thirdImageDict.imageSourceType = SendImageOfSourceTypeOfBundle;
                thirdImageDict.imagePutFileCorrelationID = _autoIncCorrID++;
                thirdImageDict.imageShowCorrelationID = _autoIncCorrID++;
                [showSoftButtonImageArray addObject:thirdImageDict];
                
                NSMutableArray *showSoftButtonArray = [[NSMutableArray alloc]init];
                SDLSoftButton *playbutton = [[SDLSoftButton alloc] init];
                playbutton.type = [SDLSoftButtonType IMAGE];
                playbutton.text = @"play";
                playbutton.isHighlighted = [NSNumber numberWithBool:NO];
                playbutton.softButtonID = [NSNumber numberWithInt:7110];
                playbutton.systemAction = [SDLSystemAction DEFAULT_ACTION];
                [showSoftButtonArray addObject:playbutton];
                SDLSoftButton *pausebutton = [[SDLSoftButton alloc] init];
                pausebutton.type = [SDLSoftButtonType BOTH];
                pausebutton.text = @"pause";
                pausebutton.isHighlighted = [NSNumber numberWithBool:NO];
                pausebutton.softButtonID = [NSNumber numberWithInt:7111];
                pausebutton.systemAction = [SDLSystemAction DEFAULT_ACTION];
                [showSoftButtonArray addObject:pausebutton];
                SDLSoftButton *likeButton = [[SDLSoftButton alloc] init];
                likeButton.type = [SDLSoftButtonType BOTH];
                likeButton.text = @"like";
                likeButton.isHighlighted = [NSNumber numberWithBool:NO];
                likeButton.softButtonID = [NSNumber numberWithInt:7112];
                likeButton.systemAction = [SDLSystemAction DEFAULT_ACTION];
                [showSoftButtonArray addObject:likeButton];
                
                //send
                [[FORDSendImageObject shareSendImageObjectWithSync:_syncProxy] putSoftButtonImage:showSoftButtonImageArray withSoftButtonArray:showSoftButtonArray withTextCorrelationID:_autoIncCorrID++];
            }
                break;
            case MORE_SHOW_ADDCOMMAND:
            {
                SDLAddCommand *hostCommand = [SDLRPCRequestFactory buildAddCommandWithID:[NSNumber numberWithInt:7210] menuName:@"热门" parentID:0 position:[NSNumber numberWithInt:2] vrCommands:[NSArray arrayWithObjects:@"热门", nil] iconValue:nil iconType:nil correlationID:[NSNumber numberWithInteger:_autoIncCorrID++]];
                //command image
                NSMutableDictionary *hostCommandImageDict = [[NSMutableDictionary alloc]init];
                hostCommandImageDict.imageNameOfLocalString = @"image7.bmp";
                hostCommandImageDict.imageLocalOfNetworkPathString = @"image7.bmp";
                hostCommandImageDict.imageSourceType = SendImageOfSourceTypeOfBundle;
                hostCommandImageDict.imagePutFileCorrelationID = _autoIncCorrID++;
                hostCommandImageDict.imageShowCorrelationID = _autoIncCorrID++;
                //send
                [[FORDSendImageObject shareSendImageObjectWithSync:_syncProxy] putCommandImage:hostCommandImageDict withCommand:hostCommand];
                
                //喜欢
                SDLAddCommand *likeCommand = [SDLRPCRequestFactory buildAddCommandWithID:[NSNumber numberWithInt:7211] menuName:@"喜欢" parentID:0 position:[NSNumber numberWithInt:1] vrCommands:[NSArray arrayWithObjects:@"喜欢", nil] iconValue:nil iconType:nil correlationID:[NSNumber numberWithInteger:_autoIncCorrID++]];
                //command image
                NSMutableDictionary *likeCommandImageDict = [[NSMutableDictionary alloc]init];
                likeCommandImageDict.imageNameOfLocalString = @"image2.jpg";
                likeCommandImageDict.imageLocalOfNetworkPathString = @"image2.jpg";
                likeCommandImageDict.imageSourceType = SendImageOfSourceTypeOfBundle;
                likeCommandImageDict.imagePutFileCorrelationID = _autoIncCorrID++;
                likeCommandImageDict.imageShowCorrelationID = _autoIncCorrID++;
                //send
                [[FORDSendImageObject shareSendImageObjectWithSync:_syncProxy] putCommandImage:likeCommandImageDict withCommand:likeCommand];
            }
                break;
            case MORE_SHOW_PERFORMINTERACTION:
            {
                //first choice image
                NSMutableDictionary *firstChoiceImageDict = [[NSMutableDictionary alloc]init];
                firstChoiceImageDict.imageNameOfLocalString = @"image2.jpg";
                firstChoiceImageDict.imageLocalOfNetworkPathString = @"image2.jpg";
                firstChoiceImageDict.imagePositionOnScreen = 1;
                firstChoiceImageDict.imageSourceType = SendImageOfSourceTypeOfBundle;
                firstChoiceImageDict.imagePutFileCorrelationID = _autoIncCorrID++;
                firstChoiceImageDict.imageShowCorrelationID = _autoIncCorrID++;
                //send
                [[FORDSendImageObject shareSendImageObjectWithSync:_syncProxy] putPerformInteractionOfChoiceImage:firstChoiceImageDict];
                
                //second choice image
                NSMutableDictionary *secondChoiceImageDict = [[NSMutableDictionary alloc]init];
                secondChoiceImageDict.imageNameOfLocalString = @"logo.png";
                secondChoiceImageDict.imageLocalOfNetworkPathString = @"logo.png";
                secondChoiceImageDict.imagePositionOnScreen = 2;
                secondChoiceImageDict.imageSourceType = SendImageOfSourceTypeOfBundle;
                secondChoiceImageDict.imagePutFileCorrelationID = _autoIncCorrID++;
                secondChoiceImageDict.imageShowCorrelationID = _autoIncCorrID++;
                //send
                [[FORDSendImageObject shareSendImageObjectWithSync:_syncProxy] putPerformInteractionOfChoiceImage:secondChoiceImageDict];
                
                //third choice image
                NSMutableDictionary *thirdChoiceImageDict = [[NSMutableDictionary alloc]init];
                thirdChoiceImageDict.imageNameOfLocalString = @"image2.jpg";
                thirdChoiceImageDict.imageLocalOfNetworkPathString = @"image2.jpg";
                thirdChoiceImageDict.imagePositionOnScreen = 3;
                thirdChoiceImageDict.imageSourceType = SendImageOfSourceTypeOfBundle;
                thirdChoiceImageDict.imagePutFileCorrelationID = _autoIncCorrID++;
                thirdChoiceImageDict.imageShowCorrelationID = _autoIncCorrID++;
                //send
                [[FORDSendImageObject shareSendImageObjectWithSync:_syncProxy] putPerformInteractionOfChoiceImage:thirdChoiceImageDict];
                
                //fourth choice image
                NSMutableDictionary *fourthChoiceImageDict = [[NSMutableDictionary alloc]init];
                fourthChoiceImageDict.imageNameOfLocalString = @"image5.png";
                fourthChoiceImageDict.imageLocalOfNetworkPathString = @"image5.png";
                fourthChoiceImageDict.imagePositionOnScreen = 4;
                fourthChoiceImageDict.imageSourceType = SendImageOfSourceTypeOfBundle;
                fourthChoiceImageDict.imagePutFileCorrelationID = _autoIncCorrID++;
                fourthChoiceImageDict.imageShowCorrelationID = _autoIncCorrID++;
                //send
                [[FORDSendImageObject shareSendImageObjectWithSync:_syncProxy] putPerformInteractionOfChoiceImage:fourthChoiceImageDict];
            }
                break;
            default:
                break;
        }
    }
}

/**
 *  choice's image putfile state (success|fail)
 *
 *  @param notification NSNotification
 */
- (void)getSendChoiceImageState:(NSNotification *)notification
{
    NSMutableDictionary *imageDict = (NSMutableDictionary *)notification.userInfo;
    if (imageDict.imagePositionOnScreen == 2) {
        //单独的选项
        SDLChoice *firstChoice = [[SDLChoice alloc] init];
        firstChoice.choiceID = [NSNumber numberWithInt:7410];
        firstChoice.menuName = @"选择1";
        firstChoice.vrCommands = [NSMutableArray arrayWithObjects:@"选择1", nil];
        SDLImage *firstChoiceImage = [[SDLImage alloc]init];
        firstChoiceImage.value = imageDict.imageNameOfMd5String;
        firstChoiceImage.imageType = [SDLImageType DYNAMIC];
        firstChoice.image = firstChoiceImage;
        
        SDLChoice *secondChoice = [[SDLChoice alloc] init];
        secondChoice.choiceID = [NSNumber numberWithInt:7411];
        secondChoice.menuName = @"选择2";
        secondChoice.vrCommands = [NSMutableArray arrayWithObjects:@"选择2", nil];
        SDLImage *secondChoiceImage = [[SDLImage alloc]init];
        secondChoiceImage.value = imageDict.imageNameOfMd5String;
        secondChoiceImage.imageType = [SDLImageType DYNAMIC];
        secondChoice.image = secondChoiceImage;
        
        SDLCreateInteractionChoiceSet *choiceSet = [SDLRPCRequestFactory buildCreateInteractionChoiceSetWithID:[NSNumber numberWithInt:7510] choiceSet:[NSArray arrayWithObjects:firstChoice,secondChoice,nil] correlationID:[NSNumber numberWithInteger:_autoIncCorrID++]];
        [_syncProxy sendRPC:choiceSet];
    }else if (imageDict.imagePositionOnScreen == 4) {
        SDLChoice *thirdChoice = [[SDLChoice alloc] init];
        thirdChoice.choiceID = [NSNumber numberWithInt:7413];
        thirdChoice.menuName = @"选择3";
        thirdChoice.vrCommands = [NSMutableArray arrayWithObjects:@"选择3", nil];
        SDLImage *thirdChoiceImage = [[SDLImage alloc]init];
        thirdChoiceImage.value = imageDict.imageNameOfMd5String;
        thirdChoiceImage.imageType = [SDLImageType DYNAMIC];
        thirdChoice.image = thirdChoiceImage;
        
        SDLChoice *fourthChoice = [[SDLChoice alloc] init];
        fourthChoice.choiceID = [NSNumber numberWithInt:7414];
        fourthChoice.menuName = @"选择4";
        fourthChoice.vrCommands = [NSMutableArray arrayWithObjects:@"选择4", nil];
        SDLImage *fourthChoiceImage = [[SDLImage alloc]init];
        fourthChoiceImage.value = imageDict.imageNameOfMd5String;
        fourthChoiceImage.imageType = [SDLImageType DYNAMIC];
        fourthChoice.image = fourthChoiceImage;
        
        SDLCreateInteractionChoiceSet *choiceSet1 = [SDLRPCRequestFactory buildCreateInteractionChoiceSetWithID:[NSNumber numberWithInt:7511] choiceSet:[NSArray arrayWithObjects:thirdChoice,fourthChoice,nil] correlationID:[NSNumber numberWithInteger:_autoIncCorrID++]];
        [_syncProxy sendRPC:choiceSet1];
        SDLPerformInteraction *PerformInteraction = [SDLRPCRequestFactory buildPerformInteractionWithInitialPrompt:nil initialText:@"请选择播放列表:" interactionChoiceSetIDList:[NSMutableArray arrayWithObjects:[NSNumber numberWithInt:7510],[NSNumber numberWithInt:7511], nil] helpPrompt:nil timeoutPrompt:nil interactionMode:[SDLInteractionMode MANUAL_ONLY] timeout:[NSNumber numberWithInt:5000] vrHelp:nil correlationID:[NSNumber numberWithInteger:_autoIncCorrID++]];
        [_syncProxy sendRPC:PerformInteraction];
    }
}

/**
 *  choiceSet response
 *
 *  @param response ChoiceSetResponse
 */
- (void)onCreateInteractionChoiceSetResponse:(SDLCreateInteractionChoiceSetResponse *)response
{
}

@end
