//
//  ELVViewController.m
//  6-Home-Events
//
//  Created by Alexandar Drajev on 12/17/13.
//  Copyright (c) 2013 Alexander Drazhev. All rights reserved.
//

#import "ELVEventsViewController.h"

@interface ELVEventsViewController ()

@property (nonatomic, strong) ELVEventsBook* eventsInfo;
@property (nonatomic) NSInteger cellHeight;
@property (nonatomic) BOOL isLandscape;

@end

@implementation ELVEventsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.isLandscape = NO;
    self.cellHeight = 150;
    self.eventsInfo = [ELVEventsBook sharedBook];
    self.eventsCollectionView.dataSource = self;
    self.eventsCollectionView.delegate = self;
    self.navigationController.navigationBarHidden = YES;
	// Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.eventsInfo.eventsArray[section] count];
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [self.eventsInfo.datesArray count];
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* cellIdentifier = @"eventCell";
    ELVEventCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    ELVEvent* currentEvent = self.eventsInfo.eventsArray[indexPath.section][indexPath.row];
    cell.titleLabel.text = currentEvent.title;
    cell.eventImageView.image = currentEvent.image;
    cell.relatedPersonNameLabel.text = currentEvent.relatedPersonName;
    cell.durationHoursLabel.text = [NSString stringWithFormat:@"%.1fh",currentEvent.duration / 60 / 60];
    cell.descriptionLabel.text = [currentEvent.description componentsSeparatedByString:@"."][0];
    CGFloat ratio = 1.0;
    NSLayoutConstraint *constraint = [NSLayoutConstraint
                                      constraintWithItem:cell.eventImageView
                                      attribute:NSLayoutAttributeWidth
                                      relatedBy:NSLayoutRelationEqual
                                      toItem:cell.eventImageView
                                      attribute:NSLayoutAttributeHeight
                                      multiplier:ratio
                                      constant:0];
    constraint.priority = 1000;
    [cell.eventImageView.superview addConstraint:constraint];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout  *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.isLandscape) {
        return CGSizeMake(self.cellHeight + 50, self.cellHeight + 50);
    }
    else {
        return CGSizeMake(self.cellHeight, self.cellHeight);
    }
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (kind == UICollectionElementKindSectionHeader) {
        ELVEventHeaderView* headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"eventsHeader" forIndexPath:indexPath];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"EEE dd MMM"];
        headerView.mainTitleLabel.text = [formatter stringFromDate:self.eventsInfo.datesArray[indexPath.section]];
        return headerView;
    }
    else {
        return nil;
    }
}

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft || toInterfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        self.isLandscape = YES;
    }
    else {
        self.isLandscape = NO;
    }
    [self.eventsCollectionView reloadData];
}


- (IBAction)threePerRowButtonTapped:(id)sender {
    self.cellHeight = 150;
    [self.eventsCollectionView reloadData];

}

- (IBAction)twoPerRowButtonTapped:(id)sender {
    self.cellHeight = 100;
    [self.eventsCollectionView reloadData];
}



@end
