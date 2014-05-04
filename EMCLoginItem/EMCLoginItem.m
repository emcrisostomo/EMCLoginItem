//
//  EMCLoginItem.m
//  EMCLoginItem
//
//  Created by Enrico Maria Crisostomo on 04/05/14.
//  Copyright (c) 2014 Enrico M. Crisostomo. All rights reserved.
//
//  License: BSD 3-Clause License
//  (http://opensource.org/licenses/BSD-3-Clause)
//

#import "EMCLoginItem.h"

@implementation EMCLoginItem

CFURLRef url;

- (id)init
{
    self = [super init];
    
    if (self)
    {
        NSString * appPath = [[NSBundle mainBundle] bundlePath];
        [self initHelper:appPath];
    }
    
    return self;
}

- (instancetype)initWithBundle:(NSBundle *)bundle
{
    if (!bundle)
    {
        NSException* nullException = [NSException
                                      exceptionWithName:@"NullPointerException"
                                      reason:@"Bundle cannot be null."
                                      userInfo:nil];
        @throw nullException;
    }
    
    self = [super init];
    
    if (self)
    {
        NSString * appPath = [bundle bundlePath];
        [self initHelper:appPath];
    }
    
    return self;
}

- (instancetype)initWithPath:(NSString *)appPath
{
    if (!appPath)
    {
        NSException* nullException = [NSException
                                      exceptionWithName:@"NullPointerException"
                                      reason:@"Path cannot be null."
                                      userInfo:nil];
        @throw nullException;
    }
    
    self = [super init];
    
    if (self)
    {
        [self initHelper:appPath];
    }
    
    return self;
}

- (void)initHelper:(NSString *)appPath
{
    url = (CFURLRef)CFBridgingRetain([NSURL fileURLWithPath:appPath]);
}

+ (instancetype)loginItem
{
    return [[EMCLoginItem alloc] initWithBundle:[NSBundle mainBundle]];
}

+ (instancetype)loginItemWithBundle:(NSBundle *)bundle
{
    return [[EMCLoginItem alloc] initWithBundle:bundle];
}

+ (instancetype)loginItemWithPath:(NSString *)path
{
    return [[EMCLoginItem alloc] initWithPath:path];
}

- (BOOL)isLoginItem
{
    LSSharedFileListRef loginItems = LSSharedFileListCreate(NULL,
                                                            kLSSharedFileListSessionLoginItems,
                                                            NULL);
    
    if (loginItems)
    {
        UInt32 seed;
        CFArrayRef loginItemsArray = LSSharedFileListCopySnapshot(loginItems, &seed);
        
        for (id item in (__bridge NSArray *)loginItemsArray)
        {
            LSSharedFileListItemRef loginItem = (__bridge LSSharedFileListItemRef)item;
            CFURLRef itemUrl;
            
            if (LSSharedFileListItemResolve(loginItem, 0, &itemUrl, NULL) == noErr)
            {
                if (CFEqual(itemUrl, url))
                {
                    return YES;
                }
            }
            else
            {
                NSLog(@"Error: LSSharedFileListItemResolve failed.");
            }
        }
    }
    else
    {
        NSLog(@"Warning: LSSharedFileListCreate failed, could not get list of login items.");
    }
    
    return NO;
}

- (void)addLoginItem
{
    LSSharedFileListRef loginItems = LSSharedFileListCreate(NULL,
                                                            kLSSharedFileListSessionLoginItems,
                                                            NULL);
    
    if (!loginItems)
    {
        NSLog(@"Error: LSSharedFileListCreate failed, could not get list of login items.");
        return;
    }
    
    if(!LSSharedFileListInsertItemURL(loginItems,
                                      kLSSharedFileListItemLast,
                                      NULL,
                                      NULL,
                                      url,
                                      NULL,
                                      NULL))
    {
        NSLog(@"Error: LSSharedFileListInsertItemURL failed, could not create login item.");
    }
}

- (void)removeLoginItem
{
    LSSharedFileListRef loginItems = LSSharedFileListCreate(NULL,
                                                            kLSSharedFileListSessionLoginItems,
                                                            NULL);
    if (loginItems)
    {
        BOOL removed = NO;
        UInt32 seed;
        CFArrayRef loginItemsArray = LSSharedFileListCopySnapshot(loginItems, &seed);
        
        for (id item in (__bridge NSArray *)loginItemsArray)
        {
            LSSharedFileListItemRef loginItem = (__bridge LSSharedFileListItemRef)item;
            CFURLRef itemUrl;
            
            if (LSSharedFileListItemResolve(loginItem, 0, &itemUrl, NULL) == noErr)
            {
                if (CFEqual(itemUrl, url))
                {
                    if (LSSharedFileListItemRemove(loginItems, loginItem) == noErr)
                    {
                        removed = YES;
                        break;
                    }
                    else
                    {
                        NSLog(@"Error: Unknown error while removing login item.");
                    }
                }
            }
        }
        
        if (!removed)
        {
            NSLog(@"Error: could not find login item to remove.");
        }
    }
    else
    {
        NSLog(@"Warning: could not get list of login items.");
    }
}

@end
