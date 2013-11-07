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

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [super.currentTagLabel setText:@"New tag"];
    [self updateFormContents];
    [self changeLabelColorForMissingInfo];
    [super.currentTag setDelegate:self];
    [super.buildingEntry setDelegate:self];
    [super.closetEntry setDelegate:self];
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
    
    [super updateConfigurationDataStructure];
    [super.data setCurrentTag:[super.currentTag text]];
}

-(void) pushConnectionsController {
    
    [self updateConfigurationDataStructure];
    [super pushConnectionsController];
}

-(void) changeLabelColorForMissingInfo {
 
    if ([[super.currentTag text] length] > 0) {
        [super.currentTagLabel setTextColor:[UIColor textColor]];
    } else {
        [super.currentTagLabel setTextColor:[UIColor unFilledRequiredTextColor]];
    }
    [super changeLabelColorForMissingInfo];
}

-(void) updateFormContents {
    
    [super updateFormContents];
    [super.currentTag setText:[super.data currentTag]];
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
