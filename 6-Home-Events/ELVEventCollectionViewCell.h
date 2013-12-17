//
//  ELVEventCollectionViewCell.h
//  6-Home-Events
//
//  Created by Alexandar Drajev on 12/17/13.
//  Copyright (c) 2013 Alexander Drazhev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ELVEventCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *eventImageView;
@property (weak, nonatomic) IBOutlet UILabel *relatedPersonNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *durationHoursLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@end
