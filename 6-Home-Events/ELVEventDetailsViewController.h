//
//  ELVEventDetailsViewController.h
//  6-Home-Events
//
//  Created by Alexandar Drajev on 12/18/13.
//  Copyright (c) 2013 Alexander Drazhev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ELVEvent.h"

@interface ELVEventDetailsViewController : UIViewController

@property (nonatomic, strong) ELVEvent* currentEvent;
@property (nonatomic, strong) NSDate* currentDate;

@end
