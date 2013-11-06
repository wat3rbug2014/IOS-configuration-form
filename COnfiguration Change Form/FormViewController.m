//
//  FormViewController.m
//  COnfiguration Change Form
//
//  Created by Douglas Gardiner on 11/5/13.
//  Copyright (c) 2013 Douglas Gardiner. All rights reserved.
//

#import "FormViewController.h"

@interface FormViewController ()

@end


#import "FormViewController.h"
#import "UIColor+ExtendedColor.h"
#import "ConnectionsController.h"
#import "enumList.h"

@implementation FormViewController

@synthesize isAddView;
@synthesize currentTag;
@synthesize currentTagLabel;
@synthesize buildingEntry;
@synthesize closetEntry;
@synthesize deviceTypeSelResult;
@synthesize deviceTypeSelection;
@synthesize devices;
@synthesize data;
@synthesize buildingLabel;
@synthesize closetLabel;
@synthesize equipTypeLabel;
@synthesize connectionsNeeded;


int const DEF_ROW = 2;

#pragma mark -
#pragma mark Initialization Methods

-(id) init {
    
    if ((self = [super init])) {
        devices = [[PickerItems alloc] init];
    }
    return self;
    
}

#pragma mark -
#pragma mark Superclass methods

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // setup text and labels
    
    UIColor *textColor = [UIColor textColor];
    [currentTagLabel setTextColor:textColor];
    if ([self connectionsNeeded] != BOTH) {
        if ([self connectionsNeeded] == ADD) {
            [currentTagLabel setText:@"New tag"];
        } else {
            [currentTagLabel setText:@"Old tag"];
        }
    }
    deviceTypeSelection = [[UIPickerView alloc] initWithFrame:CGRectMake(0.0, 255.0, 320.0, 162.0)];
    [deviceTypeSelection setDelegate:self];
    [deviceTypeSelection selectRow: DEF_ROW inComponent:0 animated:NO];
    [deviceTypeSelection setShowsSelectionIndicator:YES];
    [self.view addSubview:deviceTypeSelection];
    [deviceTypeSelection selectRow:2 inComponent:0 animated:YES];
    [data setDeviceType:AS];
    [deviceTypeSelResult setText:[data getDeviceTypeString]];
    
    // setup textfields
    
    [currentTag setTextColor:[UIColor userTextColor]];
    [buildingEntry setTextColor:[UIColor userTextColor]];
    [closetEntry setTextColor:[UIColor userTextColor]];
    [deviceTypeSelResult setTextColor:[UIColor userTextColor]];
    data = [[ConfigurationData alloc] init];
    [currentTag setDelegate:self];
    [buildingEntry setDelegate:self];
    [closetEntry setDelegate:self];
    [self updateFormContents];
    [self changeLabelColorForMissingInfo];
    
    // add navigation buttons
    
    UIBarButtonItem *toConnection = [[UIBarButtonItem alloc] initWithTitle:@"Links" style:UIBarButtonItemStylePlain target:self action:@selector(pushConnectionsController)];
    [[self navigationItem] setRightBarButtonItem:toConnection];
    UIBarButtonItem *sendForm = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(sendForm)];
    [[self navigationItem] setLeftBarButtonItem:sendForm];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    [self updateConfigurationDataStructure];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Sublass specific methods

-(void) sendForm {
    
    // check to see if form is done
    
    
    if (![[self data] isReadyToSend]) {
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
    
    if([[buildingEntry text] length] > 0) {
        [data setBuilding:[buildingEntry text]];
    }
    if ([[closetEntry text] length] > 0) {
        [data setCloset:[closetEntry text]];
    }
    if ([[currentTag text] length] > 0) {
        if ([self connectionsNeeded] == ADD) {
            [data setCurrentTag:[currentTag text]];
        } else {
            [data setOldTag:[currentTag text]];
        }
    }
}

-(void) pushConnectionsController {
    
    ConnectionsController *updateConnectorController = [[ConnectionsController alloc] initWithConnectionInfo:[self connectionsNeeded] andCurrentData:data];
    [[self navigationController] pushViewController:updateConnectorController animated:YES];
}

-(void) changeLabelColorForMissingInfo {
    
    if ([data building] == nil) {
        [buildingLabel setTextColor:[UIColor unFilledRequiredTextColor]];
    } else {
        [buildingLabel setTextColor:[UIColor textColor]];
    }
    if ([data closet] == nil) {
        [closetLabel setTextColor:[UIColor unFilledRequiredTextColor]];
    } else {
        [closetLabel setTextColor:[UIColor textColor]];
    }
    //    } else { // remove portion
    //        if ([data oldTag] == nil) {
    //            [currentTagLabel setTextColor:[UIColor unFilledRequiredTextColor]];
    //        } else {
    //            [currentTagLabel setTextColor:[UIColor textColor]];
    //        }
    //    }
    if ([data deviceType] == UNDEFINED) {
        [equipTypeLabel setTextColor:[UIColor unFilledRequiredTextColor]];
    } else {
        [equipTypeLabel setTextColor:[UIColor textColor]];
    }
}

-(void) updateFormContents {
    
    [buildingEntry setText:[data building]];
    [closetEntry setText:[data closet]];
    [deviceTypeSelResult setText:[data getDeviceTypeString]];
    
    //    } else { // remove portion
    //        [currentTag setText:[data oldTag]];
    //    }
}

#pragma mark -
#pragma mark UIPickerViewDataSource methods

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 1;
}

-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return [devices count];
}

#pragma mark -
#pragma mark UIPickerViewDelegate methods

-(void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    [deviceTypeSelResult setText:[devices deviceAtIndex:row]];
    [equipTypeLabel setTextColor:[UIColor textColor]];
    [data setDeviceType:row];
}

-(NSString*) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    if (row < 0) {
        return [devices deviceAtIndex:0];
    }
    if (row >= [devices count]) {
        return [devices deviceAtIndex:[devices count] - 1];
    }
    [data setDeviceType:row + 1];
    return [devices deviceAtIndex:row];
}

-(CGFloat) pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    
    return 300.0;
}

#pragma mark -
#pragma mark MFMailComposeViewControllerDelegate methods

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
#pragma mark UITextFieldDelegate methods

-(BOOL) textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    return YES;
}
@end