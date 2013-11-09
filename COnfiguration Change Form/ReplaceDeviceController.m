//
//  ChangeDeviceController.m
//  COnfiguration Change Form
//
//  Created by Douglas Gardiner on 9/24/13.
//  Copyright (c) 2013 Douglas Gardiner. All rights reserved.
//

#import "ReplaceDeviceController.h"
#import "ConnectionsController.h"
#import "ConfigurationDataFactory.h"

@interface ReplaceDeviceController ()

@end

@implementation ReplaceDeviceController

@synthesize oldTag;
@synthesize currentTag;
@synthesize oldTagLabel;

#pragma mark -
#pragma mark Superclass specific methods

-(id) init {
    
    return [self initWithNibName:@"ReplaceDeviceViewController" bundle:nil];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setTitle: @"Replace"];
        [super setData: [ConfigurationDataFactory create:REPLACE]];
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [[super currentTagLabel] setText:@"New tag"];
    [self updateFormContents];
    [self changeLabelColorForMissingInfo];
    [[super currentTag] setDelegate:self];
    [[super buildingEntry] setDelegate:self];
    [[self oldTag] setDelegate:self];
    [[super closetEntry] setDelegate:self];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    [self updateConfigurationDataStructure];
}

#pragma mark -
#pragma mark Sublass specific methods

-(void) sendForm {
    
    [self updateConfigurationDataStructure];
    [[self data] isFormFilledOut];
    [super sendForm];
}

//-(void) updateConfigurationDataStructure {
//    
//    [super updateConfigurationDataStructure];
//    [[super data] setTag:[currentTag text]];
//    [[super data] setOldTag:[oldTag text]];
//}



-(void) changeLabelColorForMissingInfo {
    
    [super changeLabelColorForMissingInfo];
    if ([[[super currentTag] text] length] > 0) {
        [[super currentTagLabel] setTextColor:[UIColor textColor]];
    } else {
        [[super currentTagLabel] setTextColor:[UIColor unFilledRequiredTextColor]];
    }
    if ([[oldTag text] length] > 0) {
        [oldTagLabel setTextColor:[UIColor textColor]];
    } else {
        [oldTagLabel setTextColor:[UIColor unFilledRequiredTextColor]];
    }
}

-(void) updateFormContents {
    
    [super updateFormContents];
    [[super currentTag] setText:[[super data] tag]];
    [[self oldTag] setText:[[super data] oldTag]];
}

#pragma mark -
#pragma mark UITextFieldDelegate methods

-(BOOL) textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    [self updateConfigurationDataStructure];
    [self changeLabelColorForMissingInfo];
    return YES;
}

#pragma mark -
#pragma mark UIResponder methods

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self updateConfigurationDataStructure];
    [self changeLabelColorForMissingInfo];
}

@end
