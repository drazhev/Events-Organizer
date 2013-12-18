//
//  ELVViewController.h
//  6-Home-Events
//
//  Created by Alexandar Drajev on 12/17/13.
//  Copyright (c) 2013 Alexander Drazhev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ELVEventsBook.h"
#import "ELVEventCollectionViewCell.h"
#import "ELVEventHeaderView.h"
#import "ELVEventDetailsViewController.h"

@interface ELVEventsViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *eventsCollectionView;

@end
