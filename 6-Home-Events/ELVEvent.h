//
//  ELVEvent.h
//  6-Home-Events
//
//  Created by Alexandar Drajev on 12/17/13.
//  Copyright (c) 2013 Alexander Drazhev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ELVEvent : NSObject

@property (nonatomic, copy) NSString* title;
@property (nonatomic, strong) UIImage* image;
@property (nonatomic, copy) NSString* relatedPersonName;
@property (nonatomic) NSTimeInterval duration;
@property (nonatomic, copy) NSString* description;

// designated initializer

-(id)initWithTitle: (NSString*) title image: (UIImage*) image relatedPersonName: (NSString*) relatedPersonName duration: (NSTimeInterval) duration andDescription: (NSString*) description;

@end
