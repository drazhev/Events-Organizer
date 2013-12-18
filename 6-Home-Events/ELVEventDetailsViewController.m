//
//  ELVEventDetailsViewController.m
//  6-Home-Events
//
//  Created by Alexandar Drajev on 12/18/13.
//  Copyright (c) 2013 Alexander Drazhev. All rights reserved.
//

#import "ELVEventDetailsViewController.h"

@interface ELVEventDetailsViewController ()

@end

@implementation ELVEventDetailsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.toolbarHidden = YES;
    
    UILabel* titleLabel = [[UILabel alloc] init];
    UILabel* relatedPersonLabel = [[UILabel alloc] init];
    UILabel* dateLabel = [[UILabel alloc] init];
    UIImageView* mainImageView = [[UIImageView alloc] init];
    UITextView* descriptionTextView = [[UITextView alloc] init];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"EEE dd MMM HH:mm"];
    
    titleLabel.text = self.currentEvent.title;
    relatedPersonLabel.text = self.currentEvent.relatedPersonName;
    dateLabel.text = [formatter stringFromDate:self.currentDate];
    mainImageView.image = self.currentEvent.image;
    descriptionTextView.text = self.currentEvent.description;
    
    
    
    
    [self.view addSubview:titleLabel];
    [self.view addSubview:relatedPersonLabel];
    [self.view addSubview:dateLabel];
    [self.view addSubview:mainImageView];
    [self.view addSubview:descriptionTextView];
    
    [relatedPersonLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [titleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [dateLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [mainImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [descriptionTextView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    id topGuide = self.topLayoutGuide;
    
    
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"V:[titleLabel]-[dateLabel]-[mainImageView(<=100)]-[descriptionTextView(>=50)]-|"
                               options:0
                               metrics:nil
                               views:NSDictionaryOfVariableBindings(titleLabel, dateLabel, mainImageView, descriptionTextView)]];
    
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"V:[topGuide]-[relatedPersonLabel]"
                               options:0
                               metrics:nil
                               views:NSDictionaryOfVariableBindings(relatedPersonLabel, topGuide)]];
    
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"H:|-[titleLabel]-30-[relatedPersonLabel]"
                               options:NSLayoutFormatAlignAllTop | NSLayoutFormatAlignAllBottom
                               metrics:nil
                               views:NSDictionaryOfVariableBindings(titleLabel, relatedPersonLabel)]];
    
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"H:|-[dateLabel]"
                               options:0
                               metrics:nil
                               views:NSDictionaryOfVariableBindings(dateLabel)]];
    
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"H:|-[mainImageView]"
                               options:0
                               metrics:nil
                               views:NSDictionaryOfVariableBindings(mainImageView)]];
    
    [self.view addConstraint:[NSLayoutConstraint
                              constraintWithItem:mainImageView
                              attribute:NSLayoutAttributeWidth
                              relatedBy:NSLayoutRelationEqual
                              toItem:mainImageView
                              attribute:NSLayoutAttributeHeight
                              multiplier:mainImageView.image.size.width / mainImageView.image.size
                              .height
                              constant:0]];
    
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"H:|-[descriptionTextView]-|"
                               options:0
                               metrics:nil
                               views:NSDictionaryOfVariableBindings(descriptionTextView)]];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
