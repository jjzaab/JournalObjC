//
//  JZEntryController.m
//  JournalObjC
//
//  Created by XMS_JZhan on 2/11/19.
//  Copyright © 2019 XMS_JZhan. All rights reserved.
//

#import "JZEntryController.h"
#import "JZEntry.h"

@implementation JZEntryController

+ (JZEntryController *)shared
{
    static JZEntryController *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [JZEntryController new];
    });
    return shared;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _entries = [[NSMutableArray alloc] init];;
    }
    return self;
}

- (void)addEntry:(JZEntry *)entry
{
    [_entries addObject:entry];
    [self saveToPersistentStorage];
}

- (void)removeEntry:(JZEntry *)entry
{
    [_entries removeObject:entry];
    [self saveToPersistentStorage];
}

- (void)modifyEntry:(JZEntry *)entry withTitle:(NSString *)title body:(NSString *)body;
{
    entry.title = title;
    entry.text = body;
    [self saveToPersistentStorage];
}

- (void)saveToPersistentStorage
{
    NSMutableDictionary *allObjects = [[NSMutableDictionary alloc] init];
    for (JZEntry *entry in _entries) {
        [allObjects addEntriesFromDictionary:[entry dictionaryCopy]];
    }

    NSLog(@"Trying to save");
    @try {
        NSError *error = nil;
        if ([NSJSONSerialization isValidJSONObject:allObjects])
        {
            NSData *json = [NSJSONSerialization dataWithJSONObject:allObjects options:NSJSONWritingPrettyPrinted error:&error];
            [json writeToURL:self.fileURL atomically:NO];
            NSLog(@"%@", self.fileURL);
            if (json != nil && error == nil)
            {
                NSString *jsonString = [[NSString alloc] initWithData:json encoding:NSUTF8StringEncoding];
                NSLog(@"JSON: %@", jsonString);
            }
        }
    } @catch (NSException *exception) {
        NSLog(@"%@", exception);
    }
}

- (void)loadFromPersistentStorage
{
    @try {
        NSData *data = [NSData dataWithContentsOfURL:self.fileURL];
        NSError *error;
        NSArray *entries = [NSJSONSerialization JSONObjectWithData:data
                                                           options:NSJSONReadingMutableContainers
                                                             error:&error];
        
        for (NSDictionary *dict in entries) {
            JZEntry *entry = [[JZEntry new] initWithDictionary:dict];
            [self addEntry:entry];
        }
    } @catch (NSException *exception) {
        NSLog(@"%@", exception);
    }
}

- (NSURL *)fileURL
{
    NSArray *urls = [NSFileManager.defaultManager URLsForDirectory:(NSDocumentDirectory) inDomains:(NSUserDomainMask)];
    NSString *filename = @"entries.json";
    NSURL *finalURL = [urls[0] URLByAppendingPathComponent:filename];
    return finalURL;
}

@end
