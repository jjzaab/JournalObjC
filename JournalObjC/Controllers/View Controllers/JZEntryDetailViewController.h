//
//  JZEntryDetailViewController.h
//  JournalObjC
//
//  Created by XMS_JZhan on 2/11/19.
//  Copyright © 2019 XMS_JZhan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class JZEntry;

@interface JZEntryDetailViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) JZEntry *entry;

- (void)updateViews;

@end

NS_ASSUME_NONNULL_END
