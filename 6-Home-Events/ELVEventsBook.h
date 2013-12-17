//
//  ELVEventsBook.h
//  6-Home-Events
//
//  Created by Alexandar Drajev on 12/17/13.
//  Copyright (c) 2013 Alexander Drazhev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ELVEvent.h"

@interface ELVEventsBook : NSObject

@property (nonatomic, strong) NSMutableArray* eventsArray;
@property (nonatomic, strong) NSMutableArray* datesArray;

+(id)sharedBook;
-(void)addEvent: (ELVEvent*) event;

@end
