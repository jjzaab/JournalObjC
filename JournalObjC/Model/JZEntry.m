//
//  JZEntry.m
//  JournalObjC
//
//  Created by XMS_JZhan on 2/11/19.
//  Copyright © 2019 XMS_JZhan. All rights reserved.
//

#import "JZEntry.h"

@implementation JZEntry

- (instancetype)initWithTitle:(NSString *)title text:(NSString *)text timestamp:(NSDate *)timestamp
{
    // Call super init
    self = [super init];
    if (self) {
        _title = title;
        _text = text;
        _timestamp = timestamp;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        _title = dictionary[@"title"];
        _text = dictionary[@"text"];
        _timestamp = dictionary[@"timestamp"];
    }
    return self;
}

- (NSDictionary *)dictionaryCopy
{
//    static NSString * const TitleKey = @"title";
//    static NSString * const TextKey = @"text";
//    static NSString * const TimeStampKey = @"timestamp";
//
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
//    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
//
//    NSString *dateString = [dateFormatter stringFromDate:_timestamp];
//
//    NSDictionary *dictionary = @{ TitleKey : _title, TextKey : _text, TimeStampKey : dateString};
//    return dictionary;
    return @{
             @"title": self.title,
             @"text": self.text,
             @"timestamp": self.timestamp
             };
}

@end
