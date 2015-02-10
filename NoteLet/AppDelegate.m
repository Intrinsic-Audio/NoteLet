//
//  AppDelegate.m
//  NoteLet
//
//  Created by Connor Taylor on 2/8/15.
//  Copyright (c) 2015 Intrinsic Audio. All rights reserved.
//

#import <CoreData+MagicalRecord.h>
#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    _audioController = [[PdAudioController alloc] init];
    
    if ([_audioController configureAmbientWithSampleRate:44100
                                          numberChannels:2
                                           mixingEnabled:YES] != PdAudioOK) {
        NSLog(@"failed to initialize PD audio components");
    }
    PdDispatcher *dispatcher = [PdDispatcher new];
    [PdBase setDelegate:dispatcher];
    [MagicalRecord setupCoreDataStackWithStoreNamed:@"NoteLet"];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    _audioController.active = NO;
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    _audioController.active = YES;
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
}

@end
