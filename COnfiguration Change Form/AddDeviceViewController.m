//
//  AddDeviceViewController.m
//  COnfiguration Change Form
//
//  Created by Douglas Gardiner on 11/5/13.
//  Copyright (c) 2013 Douglas Gardiner. All rights reserved.
//

#import "AddDeviceViewController.h"
#import "UIColor+ExtendedColor.h"

@interface AddDeviceViewController ()

@end

@implementation AddDeviceViewController

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

-(id) init {
    
    return [self initWithNibName:@"AddDeviceViewController" bundle:nil];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setTitle: @"Add"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIColor *textColor = [UIColor textColor]; // -these need to be moved to super?
    [currentTagLabel setTextColor:textColor]; // -these need to be moved to super?
    [currentTagLabel setText:@"New tag"];
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
    [[self data] isFormFilledOutForType:ADD];
    [super sendForm];
}

-(void) updateConfigurationDataStructure {
    
    if([[buildingEntry text] length] > 0) {
        [data setBuilding:[buildingEntry text]];
    }
    if ([[closetEntry text] length] > 0) {
        [data setCloset:[closetEntry text]];
    }
    if ([[currentTag text] length] > 0) {
        if ([self connectionsNeeded] == ADD) {
            [data setCurrentTag:[currentTag text]];
        } else {
            [data setOldTag:[currentTag text]];
        }
    }
}

-(void) pushConnectionsController {
    
    [self updateConfigurationDataStructure];
    [super pushConnectionsController];
}

-(void) changeLabelColorForMissingInfo {
 
    if ([data currentTag] == nil) {
        [currentTagLabel setTextColor:[UIColor unFilledRequiredTextColor]];
    } else {
        [currentTagLabel setTextColor:[UIColor textColor]];
    }
    [super changeLabelColorForMissingInfo];
}

-(void) updateFormContents {
    
    [currentTag setText:[data currentTag]];
    [super updateFormContents];
}

#pragma mark -
#pragma mark UITextFieldDelegate methods

-(BOOL) textFieldShouldReturn:(UITextField *)textField {
    
    [super textFieldShouldReturn:textField];
    [self updateConfigurationDataStructure];
    [self changeLabelColorForMissingInfo];
    return YES;
}

@end
