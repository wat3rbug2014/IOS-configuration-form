//
//  FormViewController.m
//  COnfiguration Change Form
//
//  Created by Douglas Gardiner on 10/20/13.
//  Copyright (c) 2013 Douglas Gardiner. All rights reserved.
//

#import "FormViewController.h"
#import "ConnectionsController.h"

@interface FormViewController ()

@end

@implementation FormViewController

@synthesize deviceTypeSelResult;
@synthesize oldTag;
@synthesize currentTag;
@synthesize buildingEntry;
@synthesize closetEntry;
@synthesize buildingLabel;
@synthesize closetLabel;
@synthesize currentTagLabel;
@synthesize oldTagLabel;
@synthesize equipTypeLabel;

@synthesize devices;
@synthesize deviceTypeSelection;
@synthesize data;
@synthesize connectionsNeeded;

int const DEF_ROW = 2;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id) initAsViewType:(NSInteger)typeType {
    
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // setup text and labels
    
    if ([self connectionsNeeded] != BOTH) {
        if ([self connectionsNeeded] == ADD) {
            [currentTagLabel setText:@"New tag"];
        } else {
            [currentTagLabel setText:@"Old tag"];
        }
    } else {
        [currentTagLabel setText:@"New tag"];
        [oldTagLabel setText:@"Old tag"];
    }
    [currentTag setTextColor:[UIColor userTextColor]];
    [currentTag setDelegate:self];
    [buildingEntry setTextColor:[UIColor userTextColor]];
    [closetEntry setTextColor:[UIColor userTextColor]];
    [buildingEntry setDelegate:self];
    [closetEntry setDelegate:self];
    [deviceTypeSelResult setTextColor:[UIColor userTextColor]];
    data = [[ConfigurationData alloc] init];
    [currentTag setDelegate:self];
    [buildingEntry setDelegate:self];
    [closetEntry setDelegate:self];

    [self changeLabelColorForMissingInfo];
    if ([self connectionsNeeded] == BOTH) {
        [oldTag setDelegate:self];
        [oldTag setTextColor:[UIColor userTextColor]];
    }
    // setup picker
    
    deviceTypeSelection = [[UIPickerView alloc] initWithFrame:CGRectMake(0.0, 255.0, 320.0, 162.0)];
    [deviceTypeSelection setDelegate:self];
    [deviceTypeSelection selectRow: DEF_ROW inComponent:0 animated:NO];
    [deviceTypeSelection setShowsSelectionIndicator:YES];
    [self.view addSubview:deviceTypeSelection];
    [deviceTypeSelection selectRow:2 inComponent:0 animated:YES];
    [data setDeviceType:AS];
    [deviceTypeSelResult setText:[data getDeviceTypeString]];

    [self updateFormContents];
    
    // add navigation buttons
    
    UIBarButtonItem *toConnection = [[UIBarButtonItem alloc] initWithTitle:@"Links" style:UIBarButtonItemStylePlain target:self action:@selector(pushConnectionsController)];
    [[self navigationItem] setRightBarButtonItem:toConnection];
    UIBarButtonItem *sendForm = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(sendForm)];
    [[self navigationItem] setLeftBarButtonItem:sendForm];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    [self updateConfigurationDataStructure];
}

#pragma mark -
#pragma mark ConfigurationFormController protocol methods

-(void) changeLabelColorForMissingInfo {
    
    if ([[data building]length] > 0) {
        [buildingLabel setTextColor:[UIColor textColor]];
    } else {
        [buildingLabel setTextColor:[UIColor unFilledRequiredTextColor]];
    }
    if ([[data closet] length] > 0) {
        [closetLabel setTextColor:[UIColor textColor]];
        
    } else {
        [closetLabel setTextColor:[UIColor unFilledRequiredTextColor]];
    }
    if ([self connectionsNeeded] != REMOVE) {
        if ([[data currentTag] length] > 0) {
            [currentTagLabel setTextColor:[UIColor textColor]];
        } else {
            [currentTagLabel setTextColor:[UIColor unFilledRequiredTextColor]];
        }
    }
    if ([self connectionsNeeded] == REMOVE) {
        if ([[data oldTag] length] > 0) {
            [currentTagLabel setTextColor:[UIColor textColor]];
        } else {
            [currentTagLabel setTextColor:[UIColor unFilledRequiredTextColor]];
        }
    }
    if ([self connectionsNeeded] == BOTH) {
        if ([[data oldTag] length] > 0) {
            [oldTagLabel setTextColor:[UIColor textColor]];
        } else {
            [oldTagLabel setTextColor:[UIColor unFilledRequiredTextColor]];
        }
    }
    if ([data deviceType] == UNDEFINED) {
        [equipTypeLabel setTextColor:[UIColor unFilledRequiredTextColor]];
    } else {
        [equipTypeLabel setTextColor:[UIColor textColor]];
    }
}

-(void) pushConnectionsController {
    
    [self updateConfigurationDataStructure];
    ConnectionsController *updateConnectorController = [[ConnectionsController alloc] initWithConnectionInfo:[self connectionsNeeded] andCurrentData:data];
    [[self navigationController] pushViewController:updateConnectorController animated:YES];
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
    
    [data setBuilding:[buildingEntry text]];
    [data setCloset:[closetEntry text]];
    if ([self connectionsNeeded] == ADD) {
        [data setCurrentTag:[currentTag text]];
    } else {
        [data setOldTag:[currentTag text]];
    }
    if ([self connectionsNeeded] != REMOVE) {
        [data setCurrentTag:[currentTag text]];
    }
    if ([self connectionsNeeded] == REMOVE) {
        [data setOldTag:[currentTag text]];
    }
    if ([self connectionsNeeded] == BOTH) {
        [data setOldTag:[oldTag text]];
    }
}


-(void) updateFormContents {
    
    [buildingEntry setText:[data building]];
    [closetEntry setText:[data closet]];
    [deviceTypeSelResult setText:[data getDeviceTypeString]];
    if ([self connectionsNeeded] != BOTH) {
        if ([self connectionsNeeded] == ADD) {
            [currentTag setText:[data currentTag]];
        } else {
            [currentTag setText:[data oldTag]];
        }
    } else {
        [currentTag setText:[data currentTag]];
        [oldTag setText:[data oldTag]];
    }
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
#pragma mark UIPickerViewDataSource methods

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 1;
}

-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return [devices count];
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
