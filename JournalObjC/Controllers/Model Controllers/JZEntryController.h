//
//  JZEntryController.h
//  JournalObjC
//
//  Created by XMS_JZhan on 2/11/19.
//  Copyright © 2019 XMS_JZhan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class JZEntry;

@interface JZEntryController : NSObject

@property (nonatomic) NSMutableArray *entries;

// Shared instance/ Singelton
+ (JZEntryController *)shared;

- (void)addEntry:(JZEntry *)entry;
- (void)removeEntry:(JZEntry *)entry;
- (void)modifyEntry:(JZEntry *)entry withTitle:(NSString *)title body:(NSString *)body;

- (void)saveToPersistentStorage;
- (void)loadFromPersistentStorage;

@end

NS_ASSUME_NONNULL_END
