//
//  ELVNewEventTableViewController.m
//  6-Home-Events
//
//  Created by Alexandar Drajev on 12/18/13.
//  Copyright (c) 2013 Alexander Drazhev. All rights reserved.
//

#import "ELVNewEventTableViewController.h"

@interface ELVNewEventTableViewController ()

@property (nonatomic, strong) ELVEventsBook* eventsBook;
@property (nonatomic, strong) ELVEvent* currentEvent;
@property (nonatomic, strong) NSDate* selectedDate;

@end

@implementation ELVNewEventTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"New event";
    self.currentEvent = [[ELVEvent alloc] init];
    self.selectedDate = [NSDate date];
    self.eventsBook = [ELVEventsBook sharedBook];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addButtonTapped:)];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


-(void)addButtonTapped: (id) sender {
    [self.eventsBook addEvent:self.currentEvent withDate:self.selectedDate];
    
    // add notification for table update so the other collection view is updated accordingly
    NSNotification* notification = [NSNotification notificationWithName:@"updateCollection" object:nil];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch(section) {
        case 0:
            return 4;
            break;
        default:
            return 1;
            break;
    }
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return @"Main";
            break;
        case 1:
            return @"Image";
            break;
        case 2:
            return @"Date";
            break;
        default:
            return @"";
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            return indexPath.row == 3 ? 200 : 70;
            break;
        case 1:
            return 200;
            break;
        case 2:
            return 200;
            break;
        default:
            return 100;
            break;
    }
}
- (IBAction)datePickerChanged:(id)sender {
    UIDatePicker* picker = (UIDatePicker*) sender;
    self.selectedDate = picker.date;
}


- (IBAction)choosePictureButtonTapped:(id)sender {
    UIImagePickerController *imgPicker = [[UIImagePickerController alloc] init];
    imgPicker.delegate = self;
    imgPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:imgPicker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)img editingInfo:(NSDictionary *)editInfo {
    self.currentEvent.image = img;
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.tableView reloadData];
}

-(void)textViewDidChange:(UITextView *)textView {
    self.currentEvent.description = textView.text;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 3) {
            static NSString* cellIdentifier = @"descriptionCell";
            ELVEventDescriptionTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
            cell.mainTextView.layer.borderWidth = 1.0f;
            cell.mainTextView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
            return cell;
            
        }
        static NSString* cellIdentifier = @"textCell";
        ELVEventTextTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        cell.mainTextField.tag = indexPath.row;
        cell.mainTextField.delegate = self;
        
        switch (indexPath.row) {
            case 0:
                cell.mainTextField.placeholder = @"Title...";
                break;
            case 1:
                cell.mainTextField.placeholder = @"Related person...";
                break;
            case 2:
                cell.mainTextField.placeholder = @"Duration in hours...";
                break;
        }
        return cell;
    }
    if (indexPath.section == 1) {
        static NSString* cellIdentifier = @"imageCell";
        ELVEventImageTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        cell.mainImageView.image = self.currentEvent.image;
        return cell;
    }
    if (indexPath.section == 2) {
        static NSString* cellIdentifier = @"dateCell";
        ELVEventDateTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        return cell;
    }
    return nil;
}

- (IBAction)textFieldDidChange:(id)sender {
    UITextField* currentField = (UITextField*) sender;
    switch (currentField.tag) {
        case 0:
            self.currentEvent.title = currentField.text;
            break;
        case 1:
            self.currentEvent.relatedPersonName = currentField.text;
            break;
        case 2:
            self.currentEvent.duration = (NSTimeInterval) ([currentField.text doubleValue] * 60 * 60);
            break;
        case 3:
            self.currentEvent.description = currentField.text;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}


@end
