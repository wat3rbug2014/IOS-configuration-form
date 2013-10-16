//
//  AddOrRemoveDeviceController.m
//  COnfiguration Change Form
//
//  Created by Douglas Gardiner on 9/24/13.
//  Copyright (c) 2013 Douglas Gardiner. All rights reserved.
//

#import "AddOrRemoveDeviceController.h"
#import "UIColor+ExtendedColor.h"
#import "ConnectionsController.h"
#import "enumList.h"


@interface AddOrRemoveDeviceController ()

@end

@implementation AddOrRemoveDeviceController

@synthesize isAddView;
@synthesize currentTag;
@synthesize tagLabel;
@synthesize buildingEntry;
@synthesize closetEntry;
@synthesize equipTypeSelResult;
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

-(id) initAsViewType:(int)typeType {
    
    if (typeType != BOTH) {
        self = [super initWithNibName:@"AddOrRemoveDeviceController" bundle:nil];
    } else {
        self = [super initWithNibName:@"ChangeDeviceController" bundle:nil];
    }
    if (self) {
        [self setConnectionsNeeded:typeType];
        if ([self connectionsNeeded] == ADD) {
            [self setTitle: @"Add"];
        }
        if ([self connectionsNeeded] == REMOVE) {
            [self setTitle:@"Remove"];
        }
        if ([self connectionsNeeded] == BOTH) {
            [self setTitle:@"Change"];
        }
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
    [tagLabel setTextColor:textColor];
    if ([self connectionsNeeded] != BOTH) {
        if ([self connectionsNeeded] == ADD) {
            [tagLabel setText:@"New tag"];
        } else {
            [tagLabel setText:@"Old tag"];
        }
    }
    deviceTypeSelection = [[UIPickerView alloc] initWithFrame:CGRectMake(0.0, 255.0, 320.0, 162.0)];
    [deviceTypeSelection setDelegate:self];
    [deviceTypeSelection selectRow: DEF_ROW inComponent:0 animated:NO];
    [deviceTypeSelection setShowsSelectionIndicator:YES];
    [self.view addSubview:deviceTypeSelection];
    
    // setup textfields
    
    [currentTag setTextColor:[UIColor userTextColor]];
    [buildingEntry setTextColor:[UIColor userTextColor]];
    [closetEntry setTextColor:[UIColor userTextColor]];
    [equipTypeSelResult setTextColor:[UIColor userTextColor]];
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
    
    [self updateConfigurationDataStructure];
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
    if ([self connectionsNeeded] == ADD) {
        if ([data currentTag] == nil) {
            [tagLabel setTextColor:[UIColor unFilledRequiredTextColor]];
        } else {
            [tagLabel setTextColor:[UIColor textColor]];
        }
    } else {
        if ([data oldTag] == nil) {
            [tagLabel setTextColor:[UIColor unFilledRequiredTextColor]];
        } else {
            [tagLabel setTextColor:[UIColor textColor]];
        }
    }
    if ([data deviceType] == UNDEFINED) {
        [equipTypeLabel setTextColor:[UIColor unFilledRequiredTextColor]];
    } else {
        [equipTypeLabel setTextColor:[UIColor textColor]];
    }
}

-(void) updateFormContents {
    
    [buildingEntry setText:[data building]];
    [closetEntry setText:[data closet]];
    [equipTypeSelResult setText:[data getDeviceTypeString]];
    if ([self connectionsNeeded] == ADD) {
        [currentTag setText:[data currentTag]];
    } else {
        [currentTag setText:[data oldTag]];
    }
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
    
    [equipTypeSelResult setText:[devices deviceAtIndex:row]];
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
    [self updateConfigurationDataStructure];
    [self changeLabelColorForMissingInfo];
    return YES;
}

@end
