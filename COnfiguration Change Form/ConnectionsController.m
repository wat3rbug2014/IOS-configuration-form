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
        [self setConnectionInfoRequired:infoType];
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
    currentIP = [[UITextField alloc] init];
    [currentIP setTextColor:[UIColor textColor]];
    if ([self connectionsNeeded] == BOTH) {
        oldIP = [[UITextField alloc] init];
        [oldIP setTextColor:[UIColor textColor]];
        oldIPLabel = [[UILabel alloc] init];
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
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    BOOL stillInTextField = NO;
    NSArray *views = [NSArray arrayWithObjects:devPortOne, devPortTwo, devDestPortOne, devDestPortTwo, destTagOne, destTagTwo, vlan, oldIP, currentIP, nil];
    for (int i = 0; i < [views count]; i++) {
        if ([touch view] == [views objectAtIndex:i]) {
            stillInTextField = YES;
        }
    }
    if (stillInTextField == NO) {
        for (int i = 0; i < [views count]; i++) {
            if ([[views objectAtIndex:i] isFirstResponder]) {
                [[views objectAtIndex:i] resignFirstResponder];
            }
        }
    }
    [self updateConfigurationDataStructure];
}

#pragma mark -
#pragma mark Class specific methods

-(void) sendForm {
    
    if (![[self data] isFormFilledOutForType:[self connectionsNeeded]]) {
        NSString *message = @"Incomplete Form.  See items in red";
        UIAlertView *emailError = [[UIAlertView alloc] initWithTitle:@"Cannot Send Form" message:message delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [emailError show];
        return;
    }
    MailController *mailer = [[MailController alloc] initWithData:[self data] andFormType:[self connectionsNeeded]];
    [mailer setMailComposeDelegate:self];
    [self presentViewController:mailer animated:YES completion:nil];
}

-(void) setConnectionInfoRequired:(NSInteger)infoType {
    
    // this is brittle because enum
    
    [self setConnectionsNeeded:infoType];
    if (infoType < BOTH || infoType > REMOVE) {
        [self setConnectionsNeeded:BOTH];
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
    NSLog(@"old ip is %@\tnew IP is %@", [data oldIp], [data currentIp]);
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
@end
