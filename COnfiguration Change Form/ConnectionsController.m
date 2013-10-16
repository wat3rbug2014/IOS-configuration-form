//
//  ConnectionsController.m
//  COnfiguration Change Form
//
//  Created by Douglas Gardiner on 9/24/13.
//  Copyright (c) 2013 Douglas Gardiner. All rights reserved.
//

#import "ConnectionsController.h"
#import "ConfigurationData.h"

@interface ConnectionsController ()

@end

@implementation ConnectionsController

@synthesize connectionsNeeded;
@synthesize data;
@synthesize destTagOne;
@synthesize destTagTwo;
@synthesize devDestPortOne;
@synthesize devDestPortTwo;
@synthesize devPortOne;
@synthesize devPortTwo;
@synthesize vlan;
@synthesize oldIP;
@synthesize currentIP;
@synthesize oldIPLabel;
@synthesize currentIPLabel;
@synthesize vlanLabel;
@synthesize devDestPortOneLabel;
@synthesize devDestPortTwoLabel;
@synthesize destTagOneLabel;
@synthesize destTagTwoLabel;
@synthesize devPortOneLabel;
@synthesize devPortTwoLabel;

#pragma mark -
#pragma mark Initialization methods

-(id) initWithConnectionInfo: (NSInteger) infoType andCurrentData: (ConfigurationData*) currentData {
    
    self = [self initWithConnectionInfo:infoType];
    if (self) {
        [self setData:currentData];
    }
    return self;
}
-(id) initWithConnectionInfo: (NSInteger) infoType {
    
    self = [self initWithNibName:@"ConnectionsController" bundle:nil];
    if (self) {
        [self setConnectionsNeeded:infoType];
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setTitle:@"Connections"];
    }
    return self;
}

#pragma mark -
#pragma mark Superclass methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    [currentIP setTextColor:[UIColor textColor]];
    if ([self connectionsNeeded] == BOTH) {
        [oldIP setTextColor:[UIColor textColor]];
        [oldIPLabel setText:@"Old IP"];
        [oldIPLabel setTextColor:[UIColor textColor]];
    }
    if ([self connectionsNeeded] != BOTH) {
        [oldIP setHidden:YES];
        [oldIPLabel setHidden:YES];
    }
    if ([self connectionsNeeded] == REMOVE) {
        [currentIPLabel setText:@"Old IP"];
    } else {
        [currentIPLabel setText:@"New IP"];
    }
    UIBarButtonItem *sendForm = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(sendForm)];
    [[self navigationItem] setRightBarButtonItem:sendForm];
    [self changeLabelColorForMissingInfo];
    NSArray *textFields;
    if ([self connectionsNeeded] == BOTH) {
        textFields = [NSArray arrayWithObjects:devPortOne, devPortTwo, devDestPortOne, devDestPortTwo, destTagOne, destTagTwo, vlan, oldIP, currentIP, nil];
    } else {
        textFields = [NSArray arrayWithObjects:devPortOne, devPortTwo, devDestPortOne, devDestPortTwo, destTagOne, destTagTwo, vlan, currentIP, nil];
    }
    for (UITextField *currentField in textFields) {
        [currentField setDelegate:self];
    }
    [self updateFormContents];
}
- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    [self updateConfigurationDataStructure];
}

#pragma mark -
#pragma mark Class specific methods

-(void) updateFormContents {
    
    [devPortOne setText:[data currentUplinkOne]];
    [devPortTwo setText:[data currentUplinkTwo]];
    [devDestPortOne setText:[data destPortOne]];
    [devDestPortTwo setText:[data destPortTwo]];
    [vlan setText:[data vlan]];
    if ([self connectionsNeeded] == ADD) {
        [currentIP setText:[data currentIp]];
    }
    if ([self connectionsNeeded] == REMOVE) {
        [currentIP setText:[data oldIp]];
    }
    if ([self connectionsNeeded] == BOTH) {
        [oldIP setText:[data oldIp]];
    }
}

-(void) sendForm {
    
    // check to see if form is done
    
    [self updateConfigurationDataStructure];
    if (![[self data] isFormFilledOutForType:[self connectionsNeeded]]) {
        NSString *message = @"Incomplete Form.  See items in red";
        UIAlertView *emailError = [[UIAlertView alloc] initWithTitle:@"Cannot Send Form" message:message delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [emailError show];
        return;
    }
    // setup mailer and transfer control
    
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
        [mailer setMailComposeDelegate:self];
        [mailer setToRecipients:[data getMailingList]];
        [mailer setSubject:[data getSubjectForConnectionType:[self connectionsNeeded]]];
        [mailer setMessageBody:[data getMessageBodyForConnectionType:[self connectionsNeeded]] isHTML:NO];
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
        [data setVlan:[vlan text]];
    }
    // stuff only when adding a device or changing it
    
    if ([self connectionsNeeded] != REMOVE) {
        if ([[devDestPortOne text] length] > 0) {
            [data setDestPortOne: [devDestPortOne text]];
        }
        if ([[devDestPortTwo text] length] > 0) {
            [data setDestPortTwo: [devDestPortTwo text]];
        }
        if ([[devPortOne text] length] > 0) {
            [data setCurrentUplinkOne: [devPortOne text]];
        }
        if ([[destTagOne text] length] > 0) {
            [data setDestTagOne: [destTagOne text]];
        }
        if ([[destTagTwo text] length] > 0) {
            [data setDestTagTwo: [destTagTwo text]];
        }
        if ([[devPortTwo text] length] > 0) {
            [data setCurrentUplinkTwo: [devPortTwo text]];
        }
        if ([[currentIP text] length] > 0) {
            [data setCurrentIp:[currentIP text]];
        }
    }
    // a bit hairy because currentIP label is the only label unless a change form is done
    
    if ([self connectionsNeeded] == REMOVE) {
        if ([[currentIP text] length] > 0) {
            [data setOldIp:[currentIP text]];
        }
    }
    if ([self connectionsNeeded] == BOTH) {
        if ([[oldIP text] length] > 0) {
            [data setOldIp:[oldIP text]];
        }
    }
}

-(void) changeLabelColorForMissingInfo {
    
    if ([data vlan] == nil) {
        [vlanLabel setTextColor:[UIColor unFilledRequiredTextColor]];
    } else {
        [vlanLabel setTextColor:[UIColor textColor]];
    }
    if ([self connectionsNeeded] != REMOVE) {
        if ([data currentIp] == nil) {
            [currentIPLabel setTextColor:[UIColor unFilledRequiredTextColor]];
        } else {
            [currentIPLabel setTextColor:[UIColor textColor]];
        }
        if ([data currentUplinkOne] == nil) {
            [devPortOneLabel setTextColor:[UIColor unFilledRequiredTextColor]];
        } else {
            [devPortOneLabel setTextColor:[UIColor textColor]];
        }
        if ([data destPortOne] == nil) {
            [devDestPortOneLabel setTextColor:[UIColor unFilledRequiredTextColor]];
        } else {
            [devDestPortOneLabel setTextColor:[UIColor textColor]];
        }
        if ([data destTagOne] == nil) {
            [destTagOneLabel setTextColor:[UIColor unFilledRequiredTextColor]];
        } else {
            [destTagOneLabel setTextColor:[UIColor textColor]];
        }
    }
    if ([self connectionsNeeded] == REMOVE) {
        if ([data oldIp] == nil) {
            [currentIPLabel setTextColor:[UIColor unFilledRequiredTextColor]];
        } else {
            [currentIPLabel setTextColor:[UIColor textColor]];
        }
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
