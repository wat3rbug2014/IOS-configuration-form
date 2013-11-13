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
#import "UIColor+ExtendedColor.h"
#import "ReplaceDeviceData.h"

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
    [self updateFormContents];
    [self changeLabelColorForMissingInfo];
    [[super currentTag] setDelegate:self];
    [[super buildingEntry] setDelegate:self];
    [[self oldTag] setDelegate:self];
    [[super closetEntry] setDelegate:self];
    UIBarButtonItem *toConnection = [[UIBarButtonItem alloc] initWithTitle:@"Links" style:UIBarButtonItemStylePlain target:self action:@selector(pushConnectionsController)];
     [[super navigationItem] setRightBarButtonItem:toConnection];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    [self updateConfigurationDataStructure];
}

#pragma mark -
#pragma mark Sublass specific methods

-(void) updateConfigurationDataStructure {
    
    [super updateConfigurationDataStructure];
    [(ReplaceDeviceData*)[super data] setCurrentTag:[currentTag text]];
    [(ReplaceDeviceData*)[super data] setOldTag:[oldTag text]];
}

-(void) changeLabelColorForMissingInfo {
    
    [super changeLabelColorForMissingInfo];
    if ([[currentTag text] length] > 0) {
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
    [currentTag setText:[(ReplaceDeviceData*)[super data] currentTag]];
    [oldTag setText:[(ReplaceDeviceData*)[super data] oldTag]];
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
