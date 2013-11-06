//
//  AddOrRemoveDeviceController.m
//  COnfiguration Change Form
//
//  Created by Douglas Gardiner on 9/24/13.
//  Copyright (c) 2013 Douglas Gardiner. All rights reserved.
//

#import "RemoveDeviceViewController.h"
#import "UIColor+ExtendedColor.h"

@interface RemoveDeviceViewController ()

@end

@implementation RemoveDeviceViewController

@synthesize currentTag;
@synthesize currentTagLabel;
@synthesize buildingEntry;
@synthesize closetEntry;
@synthesize deviceTypeSelResult;
@synthesize deviceTypeSelection;
@synthesize devices;
@synthesize data;
@synthesize buildingLabel;
@synthesize closetLabel;
@synthesize equipTypeLabel;
@synthesize connectionsNeeded;

int const DEF_ROW = 2;

#pragma mark -
#pragma mark Initialization Methods

-(id) init {
    
    return [self initWithNibName:@"RemoveDeviceViewController" bundle:nil];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setTitle: @"Remove"];
    }
    return self;
}

#pragma mark -
#pragma mark Superclass methods

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // setup text and labels
    
    UIColor *textColor = [UIColor textColor];
    [currentTagLabel setTextColor:textColor];
    [currentTagLabel setText:@"Old tag"];
    [self updateFormContents];
    [self changeLabelColorForMissingInfo];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    [self updateConfigurationDataStructure];
}

#pragma mark -
#pragma mark Sublass specific methods

-(void) sendForm {
    
    [self updateConfigurationDataStructure];
    [[self data] isFormFilledOutForType:REMOVE];
    [super sendForm];
}

-(void) updateConfigurationDataStructure {
    
    [super updateConfigurationDataStructure];
    [data setOldTag:[currentTag text]];
}

-(void) pushConnectionsController {
    
    [self updateConfigurationDataStructure];
    [super pushConnectionsController];
}

-(void) changeLabelColorForMissingInfo {
    
    [super changeLabelColorForMissingInfo];
    if ([data oldTag] == nil) {
        [currentTagLabel setTextColor:[UIColor unFilledRequiredTextColor]];
    } else {
        [currentTagLabel setTextColor:[UIColor textColor]];
    }
}

-(void) updateFormContents {
    
    [super updateFormContents];
    [currentTag setText:[data oldTag]];
}
#pragma mark -
#pragma mark UITextFieldDelegate methods

-(BOOL) textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    [self updateConfigurationDataStructure];
    [self changeLabelColorForMissingInfo];
    return YES;
}

@end
