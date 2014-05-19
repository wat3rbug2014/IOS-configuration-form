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
#import "ConfigurationDataProtocol.h"
#import "AlterDeviceData.h"
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
@synthesize notifier;
@synthesize activeField;
@synthesize scrollView;
@synthesize keyboardSize;
@synthesize originalFrame;

#pragma mark -
#pragma mark Initialization Methods


-(id) initWithData:(id<ConfigurationDataProtocol>)newData {
    
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
    notifier = [NSNotificationCenter defaultCenter];
    [notifier addObserver:self selector:@selector(keyboardWillBeShown:) name:UIKeyboardDidShowNotification object:nil];
    [notifier addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardDidHideNotification object:nil];
    [currentIP setTextColor:[UIColor textColor]];
    UIBarButtonItem *toCommenter = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStylePlain target:self action:@selector(pushNextController)];
    [[self navigationItem] setRightBarButtonItem:toCommenter];
    NSArray *textFields = [NSArray arrayWithObjects:devPortOne, devPortTwo, devDestPortOne, devDestPortTwo, destTagOne, destTagTwo, vlan, currentIP, nil];
    for (UITextField *currentField in textFields) {
        [currentField setDelegate:self];
        [currentField setTextColor:[UIColor userTextColor]];
    }
    [self setUnusedUplinkOne];
    [self setUnusedUplinkTwo];
    [self setUnusedVlan];
    [self updateFormContents];
    [self changeLabelColorForMissingInfo];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    [self updateConfigurationDataStructure];
    [notifier removeObserver:self];
    NSLog(@"%@ is showing memory warning", [[self class] description]);
}

-(void) viewWillDisappear:(BOOL)animated {
    
    [self updateConfigurationDataStructure];
    [super viewWillDisappear:animated];
    [notifier removeObserver:self];
}

#pragma mark -
#pragma mark Class specific methods

-(void) updateFormContents {
    
    [devPortOne setText:[[self data] uplinkOneFrom]];
    [devPortTwo setText:[[self data] uplinkTwoFrom]];
    [devDestPortOne setText:[[self data] uplinkOneTo]];
    [devDestPortTwo setText:[[self data] uplinkTwoTo]];
    [vlan setText:[[NSNumber numberWithInteger:[data vlan]] stringValue]];
    [currentIP setText:[data ipAddress]];
    [destTagOne setText:[[self data] destOneTag]];
    [destTagTwo setText:[[self data] destTwoTag]];
}

-(void) pushNextController {
    
    [self updateConfigurationDataStructure];
    CommentsController *commenter = [[CommentsController alloc] initWithData:[self data]];
    [[self navigationController] pushViewController:commenter animated:YES];
}

-(void) updateConfigurationDataStructure {
    
    [self.data setVlanFromString:[vlan text]];
    [self.data setUplinkOneTo:[devDestPortOne text]];
    [self.data setUplinkOneFrom:[devPortOne text]];
    [self.data setUplinkTwoTo:[devDestPortTwo text]];
    [self.data setUplinkTwoFrom:[devPortTwo text]];
    [self.data setDestOneTag:[destTagOne text]];
    [self.data setDestTwoTag:[destTagTwo text]];
    [self.data setIpAddress:[currentIP text]];
}

-(void) setUnusedUplinkOne {
    
    [devPortOneLabel setTextColor:[UIColor textColor]];
    [devDestPortOneLabel setTextColor:[UIColor textColor]];
    [destTagOneLabel setTextColor:[UIColor textColor]];
}

-(void) setUnusedUplinkTwo {
    
    [devPortTwoLabel setTextColor:[UIColor textColor]];
    [devDestPortTwoLabel setTextColor:[UIColor textColor]];
    [destTagTwoLabel setTextColor:[UIColor textColor]];
}

-(void) setUnusedVlan {
    
    [vlanLabel setTextColor:[UIColor textColor]];
    [currentIPLabel setTextColor:[UIColor textColor]];
}

-(void) changeUpLinkOneColor {
    
    if ([[devDestPortOne text] length] > 0 || [[devPortOne text] length] > 0 || [[destTagOne text] length] > 0) {
        if ([[devDestPortOne text] length] > 0) {
            [devDestPortOneLabel setTextColor:[UIColor textColor]];
        } else {
            [devDestPortOneLabel setTextColor:[UIColor unFilledRequiredTextColor]];
        }
        if ([[devPortOne text] length] > 0) {
            [devPortOneLabel setTextColor:[UIColor textColor]];
        } else {
            [devPortOneLabel setTextColor:[UIColor unFilledRequiredTextColor]];
        }
        if ([[destTagOne text] length] > 0) {
            [destTagOneLabel setTextColor:[UIColor textColor]];
        } else {
            [destTagOneLabel setTextColor:[UIColor unFilledRequiredTextColor]];
        }
    } else {
        [devDestPortOneLabel setTextColor:[UIColor unFilledRequiredTextColor]];
        [devPortOneLabel setTextColor:[UIColor unFilledRequiredTextColor]];
        [destTagOneLabel setTextColor:[UIColor unFilledRequiredTextColor]];
    }
}

-(void) changeUpLinkTwoColor {
    
    if ([[devDestPortTwo text] length] > 0) {
        [devDestPortTwoLabel setTextColor:[UIColor textColor]];
    } else {
        [devDestPortTwoLabel setTextColor:[UIColor unFilledRequiredTextColor]];
    }
    if ([[devPortTwo text] length] > 0) {
        [devPortTwoLabel setTextColor:[UIColor textColor]];
    } else {
        [devPortTwoLabel setTextColor:[UIColor unFilledRequiredTextColor]];
    }
    if ([[destTagTwo text] length] > 0) {
        [destTagTwoLabel setTextColor:[UIColor textColor]];
    } else {
        [destTagTwoLabel setTextColor:[UIColor unFilledRequiredTextColor]];
    }
}

-(void)changeVlanInfoColor {
    
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

-(void) changeLabelColorForMissingInfo {
    
    // alter configuration portion here
    
    if ([[self data] isMemberOfClass:[AlterDeviceData class]]) {
        if ([[devDestPortOne text] length] > 0 || [[devPortOne text] length] > 0 || [[destTagOne text] length] > 0) {
            [self changeUpLinkOneColor];
        } else {
            [devDestPortOneLabel setTextColor:[UIColor textColor]];
            [devPortOneLabel setTextColor:[UIColor textColor]];
            [destTagOneLabel setTextColor:[UIColor textColor]];
        }

        // if uplink 2 started

        if ([[devDestPortTwo text] length] > 0 || [[devDestPortTwo text] length] > 0 || [[destTagTwo text] length] > 0) {
            [self changeUpLinkTwoColor];
        } else {
            [devDestPortTwoLabel setTextColor:[UIColor textColor]];
            [devPortTwoLabel setTextColor:[UIColor textColor]];
            [destTagTwoLabel setTextColor:[UIColor textColor]];
        }
        [self changeVlanInfoColor];
        if ([[vlan text] intValue] == 0) {
            [vlanLabel setTextColor:[UIColor textColor]];
        }
        [currentIPLabel setTextColor:[UIColor textColor]];
    } else {
        [self changeVlanInfoColor];
        [self changeUpLinkOneColor];
        if ([[devPortTwo text] length] > 0 || [[devDestPortTwo text] length] > 0 || [[destTagTwo text] length] > 0) {
            [self changeUpLinkTwoColor];
        } else {
            [devDestPortTwoLabel setTextColor:[UIColor textColor]];
            [devPortTwoLabel setTextColor:[UIColor textColor]];
            [destTagTwoLabel setTextColor:[UIColor textColor]];
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


-(void) textFieldDidBeginEditing:(UITextField *)textField {
    
    [self setActiveField:textField];
    [self updateConfigurationDataStructure];
    [self changeLabelColorForMissingInfo];
}

-(void) textFieldDidEndEditing:(UITextField *)textField {
    
    [self setActiveField:nil];
}

#pragma mark -
#pragma NSNofitication Center methods

-(void) keyboardWillBeShown: (NSNotification*) notice {

    NSDictionary *info = [notice userInfo];
    keyboardSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    CGRect background = activeField.superview.frame;
    originalFrame = activeField.superview.frame.origin;
    background.size.height += keyboardSize.height;
    [activeField.superview setFrame:background];
    [scrollView setContentOffset:CGPointMake(0.0, activeField.frame.origin.y - keyboardSize.height) animated:YES];
}

-(void) keyboardWillBeHidden:(NSNotification *)notice {
    
    CGRect background = activeField.superview.frame;
    background.size.height -= keyboardSize.height;
    [activeField.superview setFrame:background];
    [scrollView setContentOffset:CGPointMake(0.0, -(self.navigationController.navigationBar.frame.size.height + OFFSET)) animated:YES];
}
@end
