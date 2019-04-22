//
//  AppDelegate.m
//  PsdReader
//
//  Created by huangkaizhan on 2017/12/11.
//  Copyright © 2017年 huangkaizhan. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
    [PsdSettingModel sharedModel].isEnableLayoutFactor = YES;
    [PsdSettingModel sharedModel].authorName = @"黄凯展";
    [PsdSettingModel sharedModel].prefix = @"BM";
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


@end
