//
//  AddDeviceViewController.m
//  COnfiguration Change Form
//
//  Created by Douglas Gardiner on 11/5/13.
//  Copyright (c) 2013 Douglas Gardiner. All rights reserved.
//

#import "AddDeviceController.h"
#import "UIColor+ExtendedColor.h"
#import "ConfigurationDataFactory.h"

@interface AddDeviceController ()

@end

@implementation AddDeviceController

-(id) init {
    
    return [self initWithNibName:@"AddDeviceController" bundle:nil];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setTitle: @"Add"];
        [super setData:[ConfigurationDataFactory create:ADD]];
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
    [[super closetEntry] setDelegate:self];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    [self updateConfigurationDataStructure];
}

-(void) updateConfigurationDataStructure {
    
    [super updateConfigurationDataStructure];
    [[super data] setTag:[[super currentTag] text]];
}

-(void) pushConnectionsController {
    
    [self updateConfigurationDataStructure];
    [super pushConnectionsController];
}

-(void) changeLabelColorForMissingInfo {
 
    if ([[[super currentTag] text] length] > 0) {
        [[super currentTagLabel] setTextColor:[UIColor textColor]];
    } else {
        [[super currentTagLabel] setTextColor:[UIColor unFilledRequiredTextColor]];
    }
    [super changeLabelColorForMissingInfo];
}

-(void) updateFormContents {
    
    [super updateFormContents];
    [[super currentTag] setText:[super.data tag]];
}

#pragma mark -
#pragma mark UITextFieldDelegate methods

-(BOOL) textFieldShouldReturn:(UITextField *)textField {
    
    [super textFieldShouldReturn:textField];
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
