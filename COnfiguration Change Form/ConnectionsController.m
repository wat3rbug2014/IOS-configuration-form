//
//  ConnectionsController.m
//  COnfiguration Change Form
//
//  Created by Douglas Gardiner on 9/24/13.
//  Copyright (c) 2013 Douglas Gardiner. All rights reserved.
//

#import "ConnectionsController.h"
#import "UIColor+ExtendedColor.h"
#import "ConfigurationDataFactory.h"
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


-(id) init {
    
    return [self initWithNibName:@"ConnectionsController" bundle:nil];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setTitle: @"Uplinks"];
        [self setData:[ConfigurationDataFactory create:ADD]];
    }
    return self;
}

#pragma mark -
#pragma mark Superclass methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    [currentIP setTextColor:[UIColor textColor]];
    UIBarButtonItem *sendForm = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(sendForm)];
    [[self navigationItem] setRightBarButtonItem:sendForm];
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
    
    [devPortOne setText:[(AddDeviceData*)[self data] uplinkOneFrom]];
    [devPortTwo setText:[(AddDeviceData*)[self data] uplinkTwoFrom]];
    [devDestPortOne setText:[(AddDeviceData*)[self data] uplinkOneFrom]];
    [devDestPortTwo setText:[(AddDeviceData*)[self data] uplinkOneFrom]];
    [vlan setText:[[NSNumber numberWithInteger:[data vlan]] stringValue]];
    [currentIP setText:[data ipAddress]];
}

-(void) sendForm {
    
    // check to see if form is done
    
    [self updateConfigurationDataStructure];
//    if (![[self data] isReadyToSend]) {
//        NSString *message = @"Incomplete Form.  See items in red";
//        UIAlertView *emailError = [[UIAlertView alloc] initWithTitle:@"Cannot Send Form" message:message delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
//        [emailError show];
//        return;
//    }
    // setup mailer and transfer control
    
    if ([MFMailComposeViewController canSendMail]) {
        [self updateConfigurationDataStructure];
        MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
        [mailer setMailComposeDelegate:self];
        [mailer setToRecipients:[data getMailingList]];
        [mailer setSubject:[data getEmailSubject]];
        [mailer setMessageBody:[data getEmailMessageBody] isHTML:NO];
        [self presentViewController:mailer animated:YES completion:nil];
        [data clear];
    } else {
        NSString *message = @"Unable to send email.  Please check your settings";
        UIAlertView *emailError = [[UIAlertView alloc] initWithTitle:@"EMail Not Setup" message:message delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [emailError show];
    }
}

-(void) updateConfigurationDataStructure {
    
    if ([[vlan text] length] > 0) {
        [data setVlan:[[vlan text] integerValue]];
    }
    [(AddDeviceData*)data setUpLinkOneTo:[devDestPortOne text]];
    [(AddDeviceData*)data setUplinkOneFrom:[devPortOne text]];
    [(AddDeviceData*)data setUplinkTwoTo:[devDestPortTwo text]];
    [(AddDeviceData*)data setUplinkTwoFrom:[devPortTwo text]];
    [(AddDeviceData*)data setDestOneTag:[destTagOne text]];
    [(AddDeviceData*)data setDestTwoTag:[destTagTwo text]];
}

-(void) changeLabelColorForMissingInfo {
    
    
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
