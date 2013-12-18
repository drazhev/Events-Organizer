//
//  ELVEventsBook.m
//  6-Home-Events
//
//  Created by Alexandar Drajev on 12/17/13.
//  Copyright (c) 2013 Alexander Drazhev. All rights reserved.
//

#import "ELVEventsBook.h"

@implementation ELVEventsBook

-(NSString *) genRandStringLength: (int) len {
    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    for (int i=0; i<len; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random() % [letters length]]];
    }
    return randomString;
}

+(id) sharedBook {
    static ELVEventsBook *sharedBook = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedBook = [[ELVEventsBook alloc] init];
    });
    return sharedBook;
}

-(id) init {
    if (self = [super init]) {
        _eventsArray = [NSMutableArray arrayWithObjects:[NSMutableArray array], [NSMutableArray array], [NSMutableArray array], nil];
        _datesArray = [NSMutableArray arrayWithObjects:[NSDate dateWithTimeIntervalSinceNow:60*60*24], [NSDate dateWithTimeIntervalSinceNow:60*60*24*2], [NSDate dateWithTimeIntervalSinceNow:60*60*24*3], nil];
        for (int i=0; i < 30; i++) {
            NSString* randomTitle = [self genRandStringLength:10];
            NSString* randomRelatedPerson = [self genRandStringLength:10];
            NSTimeInterval randomDuration = (NSTimeInterval) (arc4random() % 60*60*10);
            NSString* randomDescription = @"This is a test description. This is a test description. This is a test description. This is a test description. This is a test description. This is a test description. This is a test description. This is a test description. This is a test description. This is a test description. This is a test description. This is a test description. This is a test description. This is a test description. This is a test description. ";
            int randomDate = arc4random() % 3;
            [_eventsArray[randomDate] addObject:[[ELVEvent alloc] initWithTitle:randomTitle image:[UIImage imageNamed:@"defaultImage.png"] relatedPersonName:randomRelatedPerson duration:randomDuration andDescription:randomDescription]];
        }
    }
    return self;
}

- (BOOL)isSameDay:(NSDate*)date1 otherDay:(NSDate*)date2 {
    NSCalendar* calendar = [NSCalendar currentCalendar];
    
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    NSDateComponents* comp1 = [calendar components:unitFlags fromDate:date1];
    NSDateComponents* comp2 = [calendar components:unitFlags fromDate:date2];
    
    return [comp1 day]   == [comp2 day] &&
    [comp1 month] == [comp2 month] &&
    [comp1 year]  == [comp2 year];
}

-(void)addEvent:(ELVEvent *)event withDate: (NSDate*) date{
    // do the appropriate validation here (if needed)
    for (NSDate* currentDate in self.datesArray) {
        if ([self isSameDay:currentDate otherDay:date]) {
            [self.eventsArray[[self.datesArray indexOfObject:currentDate]] addObject:event];
            return;
        }
    }
    [self.datesArray addObject:date];
    [self.eventsArray addObject:[NSMutableArray array]];
    int currentDateIndex = [self.datesArray indexOfObject:date];
    [self.eventsArray[currentDateIndex] addObject:event];
    
}

@end
