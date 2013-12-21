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
#import "CommentsController.h"

@interface ReplaceDeviceController ()

@end

@implementation ReplaceDeviceController

@synthesize oldTag;
@synthesize currentTag;
@synthesize oldTagLabel;

#pragma mark -
#pragma mark Superclass specific methods

-(id) init {
    
    return [self initWithNibName:@"ReplaceDeviceController" bundle:nil];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [super setTitle: @"Replace"];
        [super setData: [ConfigurationDataFactory create:REPLACE]];
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [[super deviceTypeSelection] setFrame:CGRectMake(0.0, 205.0, 320.0, 162.0)];
    [super setData: [ConfigurationDataFactory create:REPLACE]];
    [oldTag setTextColor:[UIColor userTextColor]];
    [currentTag setTextColor:[UIColor userTextColor]];
    [self updateFormContents];
    [self changeLabelColorForMissingInfo];
    
    // setup delegates to listen for touch events
    
    [currentTag setDelegate:self];
    [[super buildingEntry] setDelegate:self];
    [oldTag setDelegate:self];
    [[super closetEntry] setDelegate:self];
    
    // add naviagtion buttons
    [[super navigationItem] setRightBarButtonItem:nil];
    UIBarButtonItem *toCommenter = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStylePlain target:self action:@selector(pushNextController)];
    [[self navigationItem] setRightBarButtonItem:toCommenter];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    [self updateConfigurationDataStructure];
    NSLog(@"%@ is showing memory warning", [[self class] description]);
}

#pragma mark -
#pragma mark Sublass specific methods

-(void) updateConfigurationDataStructure {
    
    [super updateConfigurationDataStructure];
    [[super data] setTag:[currentTag text]];
    [[self data] setOldTag:[oldTag text]];
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

-(void) pushNextController {
    
    [self updateConfigurationDataStructure];
    CommentsController *commenter = [[CommentsController alloc] initWithData:[self data]];
    [[self navigationController] pushViewController:commenter animated:YES];
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
