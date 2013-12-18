//
//  ELVEvent.m
//  6-Home-Events
//
//  Created by Alexandar Drajev on 12/17/13.
//  Copyright (c) 2013 Alexander Drazhev. All rights reserved.
//

#import "ELVEvent.h"

@implementation ELVEvent

-(id)initWithTitle: (NSString*) title image: (UIImage*) image relatedPersonName: (NSString*) relatedPersonName duration: (NSTimeInterval) duration andDescription: (NSString*) description {
    if (self = [super init]) {
        _title = title;
        _image = image;
        _relatedPersonName = relatedPersonName;
        _duration = duration;
        _description = description;
    }
    return self;
}

-(id)init {
    return [self initWithTitle:@"" image:[UIImage imageNamed:@"defaultImage.png"] relatedPersonName:@"" duration:0 andDescription:@""];
}

@end
