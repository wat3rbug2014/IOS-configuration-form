//
//  ChangeDeviceController.m
//  COnfiguration Change Form
//
//  Created by Douglas Gardiner on 9/24/13.
//  Copyright (c) 2013 Douglas Gardiner. All rights reserved.
//

#import "ChangeDeviceController.h"
#import "ConnectionsController.h"

@interface ChangeDeviceController ()

@end

@implementation ChangeDeviceController

@synthesize deviceTypeSelResult;
@synthesize oldTag;
@synthesize currentTag;
@synthesize buildingEntry;
@synthesize closetEntry;
@synthesize devices;
@synthesize deviceTypeSelection;
@synthesize data;
@synthesize connectionsNeeded;
@synthesize buildingLabel;
@synthesize closetLabel;
@synthesize currentTagLabel;
@synthesize oldTagLabel;
@synthesize equipTypeLabel;

#pragma mark -
#pragma mark Superclass specific methods

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        devices = [[PickerItems alloc] init];
        [self setTitle:@"Change"];
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [deviceTypeSelection setDelegate:self];
    [deviceTypeSelection selectRow: DEF_ROW inComponent:0 animated:NO];
    [deviceTypeSelection setShowsSelectionIndicator:YES];
    [self.view addSubview:deviceTypeSelection];
    [deviceTypeSelResult setTextColor:[UIColor userTextColor]];
    [self changeLabelColorForMissingInfo];
    
    // add navigation items
    
    UIBarButtonItem *sendForm = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(sendForm)];
    [[self navigationItem] setLeftBarButtonItem:sendForm];
    UIBarButtonItem *toConnection = [[UIBarButtonItem alloc] initWithTitle:@"Links" style:UIBarButtonItemStylePlain target:self action:@selector(pushConnectionsController)];
    [[self navigationItem] setRightBarButtonItem:toConnection];
    
    // setup entry fields and labels
    
    [oldTag setDelegate:self];
    [oldTag setTextColor:[UIColor userTextColor]];
    [currentTag setDelegate:self];
    [currentTag setTextColor:[UIColor userTextColor]];
    [buildingEntry setDelegate:self];
    [buildingEntry setTextColor:[UIColor userTextColor]];
    [closetEntry setDelegate:self];
    [closetEntry setTextColor:[UIColor userTextColor]];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    [self updateConfigurationDataStructure];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Sublass specific methods

-(void) sendForm {
    
    [self updateConfigurationDataStructure];
    [[self data] isFormFilledOutForType:BOTH];
    [super sendForm];
}

-(void) updateConfigurationDataStructure {
    
    [data setBuilding:[buildingEntry text]];
    [data setCloset:[closetEntry text]];
    [data setCurrentTag:[currentTag text]];
    [data setOldTag:[oldTag text]];
}

-(void) pushConnectionsController {
    
    [self updateConfigurationDataStructure];
    ConnectionsController *updateConnectorController = [[ConnectionsController alloc] initWithConnectionInfo:BOTH andCurrentData:data];
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
    if ([data currentTag] == nil) {
            [currentTagLabel setTextColor:[UIColor unFilledRequiredTextColor]];
    } else {
        [currentTagLabel setTextColor:[UIColor textColor]];
    }
    if ([data oldTag] == nil) {
        [oldTagLabel setTextColor:[UIColor unFilledRequiredTextColor]];
    } else {
        [oldTagLabel setTextColor:[UIColor textColor]];
    }
    if ([data deviceType] == UNDEFINED) {
        [equipTypeLabel setTextColor:[UIColor unFilledRequiredTextColor]];
    } else {
        [equipTypeLabel setTextColor:[UIColor textColor]];
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
    
    [deviceTypeSelResult setText:[devices deviceAtIndex:row]];
}

-(NSString*) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    if (row < 0) {
        return [devices deviceAtIndex:0];
    }
    if (row >= [devices count]) {
        return [devices deviceAtIndex:[devices count] - 1];
    }
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
