//
//  ConnectionsController.m
//  COnfiguration Change Form
//
//  Created by Douglas Gardiner on 9/24/13.
//  Copyright (c) 2013 Douglas Gardiner. All rights reserved.
//

#import "ConnectionsController.h"
#import "UIColor+ExtendedColor.h"
#import "CommentsController.h"
#import "AddDeviceData.h"

@interface ConnectionsController ()

@end

@implementation ConnectionsController

@synthesize data;
@synthesize destTagOne;
@synthesize destTagTwo;
@synthesize devDestPortOne;
@synthesize devDestPortTwo;
@synthesize devPortOne;
@synthesize devPortTwo;
@synthesize vlan;
@synthesize currentIP;
@synthesize currentIPLabel;
@synthesize vlanLabel;
@synthesize devDestPortOneLabel;
@synthesize devDestPortTwoLabel;
@synthesize destTagOneLabel;
@synthesize destTagTwoLabel;
@synthesize devPortOneLabel;
@synthesize devPortTwoLabel;

#pragma mark -
#pragma mark Initialization Methods


-(id) initWithData:(AddDeviceData *)newData {
    
    return [self initWithNibName:@"ConnectionsController" bundle:nil];
    [self setData:newData];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setTitle: @"Uplinks"];
    }
    return self;
}

#pragma mark -
#pragma mark Superclass methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    [currentIP setTextColor:[UIColor textColor]];
    UIBarButtonItem *toCommenter = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStylePlain target:self action:@selector(pushNextController)];
    [[self navigationItem] setRightBarButtonItem:toCommenter];
    NSArray *textFields = [NSArray arrayWithObjects:devPortOne, devPortTwo, devDestPortOne, devDestPortTwo, destTagOne, destTagTwo, vlan, currentIP, nil];
    for (UITextField *currentField in textFields) {
        [currentField setDelegate:self];
        [currentField setTextColor:[UIColor userTextColor]];
    }
    [self updateFormContents];
    [self changeLabelColorForMissingInfo];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    [self updateConfigurationDataStructure];
}

-(void) viewWillDisappear:(BOOL)animated {
    
    [self updateConfigurationDataStructure];
    [super viewWillDisappear:animated];
}

#pragma mark -
#pragma mark Class specific methods

-(void) updateFormContents {
    
    [devPortOne setText:[[self data] uplinkOneFrom]];
    [devPortTwo setText:[[self data] uplinkTwoFrom]];
    [devDestPortOne setText:[[self data] uplinkOneFrom]];
    [devDestPortTwo setText:[[self data] uplinkOneFrom]];
    [vlan setText:[[NSNumber numberWithInteger:[data vlan]] stringValue]];
    [currentIP setText:[data ipAddress]];
}

-(void) pushNextController {
    
    [self updateConfigurationDataStructure];
    CommentsController *commenter = [[CommentsController alloc] initWithData:[self data]];
    [[self navigationController] pushViewController:commenter animated:YES];
}

-(void) updateConfigurationDataStructure {
    
    if ([[vlan text] length] > 0) {
        [data setVlan:[[vlan text] integerValue]];
    }
    [data setUpLinkOneTo:[devDestPortOne text]];
    [data setUplinkOneFrom:[devPortOne text]];
    [data setUplinkTwoTo:[devDestPortTwo text]];
    [data setUplinkTwoFrom:[devPortTwo text]];
    [data setDestOneTag:[destTagOne text]];
    [data setDestTwoTag:[destTagTwo text]];
    [data setIpAddress:[currentIP text]];
}

-(void) changeLabelColorForMissingInfo {
    
        
    if ([[devPortOne text] length] > 0) {
        [devPortOneLabel setTextColor:[UIColor textColor]];
    } else {
        [devPortOneLabel setTextColor:[UIColor unFilledRequiredTextColor]];
    }
    if ([[devDestPortOne text] length] > 0) {
        [devDestPortOneLabel setTextColor:[UIColor textColor]];
    } else {
        [devDestPortOneLabel setTextColor:[UIColor unFilledRequiredTextColor]];
    }
    if ([[destTagOne text] length] > 0) {
        [destTagOneLabel setTextColor:[UIColor textColor]];
    } else {
        [destTagOneLabel setTextColor:[UIColor unFilledRequiredTextColor]];
    }
    if ([[vlan text] intValue] != 0) {
        [vlanLabel setTextColor:[UIColor textColor]];
    } else {
        [vlanLabel setTextColor:[UIColor unFilledRequiredTextColor]];
    }
    if ([[currentIP text] length] > 0) {
        [currentIPLabel setTextColor:[UIColor textColor]];
    } else {
        [currentIPLabel setTextColor:[UIColor unFilledRequiredTextColor]];
    }
}


#pragma mark -
#pragma MFMAilComposeViewControllerDelegate methods

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    
    [controller dismissViewControllerAnimated:YES completion:nil];
    if (error) {
        // do a popup for error message with a proper message
        // currently basic activity is being tested
        
        NSString *message = @"Failed to send the form.  Check Settings";
        UIAlertView *emailError = [[UIAlertView alloc] initWithTitle:@"Cannot Send Form" message:message delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [emailError show];
    }
}

#pragma mark -
#pragma UITextFieldDelegate methods

-(BOOL) textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    [self updateConfigurationDataStructure];
    [self changeLabelColorForMissingInfo];
    return YES;
}
@end
