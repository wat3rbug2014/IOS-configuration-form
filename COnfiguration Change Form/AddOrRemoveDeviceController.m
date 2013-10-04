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
@synthesize tagEntry;
@synthesize tagLabel;
@synthesize buildingEntry;
@synthesize closetEntry;
@synthesize equipTypeSelResult;
@synthesize deviceTypeSelection;
@synthesize devices;
@synthesize data;

int const DEF_ROW = 2;

#pragma mark -
#pragma mark Initialization Methods

-(id) initAsAddView: (BOOL) addView {
    
    self = [super initWithNibName:@"AddOrRemoveDeviceController" bundle:nil];
    if (self) {
        [self setIsAddView:addView];
        if ([self isAddView]) {
            [self setTitle: @"Add Device"];
        } else {
            [self setTitle:@"Remove Device"];
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
    if ([self isAddView]) {
        [tagLabel setText:@"New tag"];
    } else {
        [tagLabel setText:@"Old tag"];
    }
    deviceTypeSelection = [[UIPickerView alloc] initWithFrame:CGRectMake(0.0, 255.0, 320.0, 162.0)];
    [deviceTypeSelection setDelegate:self];
    [deviceTypeSelection selectRow: DEF_ROW inComponent:0 animated:NO];
    [deviceTypeSelection setShowsSelectionIndicator:YES];
    [self.view addSubview:deviceTypeSelection];
    [tagEntry setTextColor:[UIColor userTextColor]];
    [buildingEntry setTextColor:[UIColor userTextColor]];
    [closetEntry setTextColor:[UIColor userTextColor]];
    [equipTypeSelResult setTextColor:[UIColor userTextColor]];
    
    // add navigation buttons
    
    UIBarButtonItem *toConnection = [[UIBarButtonItem alloc] initWithTitle:@"Links" style:UIBarButtonItemStylePlain target:self action:@selector(updateConnections)];
    [[self navigationItem] setRightBarButtonItem:toConnection];
    UIBarButtonItem *sendForm = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(sendForm)];
    [[self navigationItem] setLeftBarButtonItem:sendForm];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Sublass specific methods

-(void) updateConfigurationDataStructure {
    
    [data setBuilding:[buildingEntry text]];
    [data setCloset:[closetEntry text]];
    if ([self isAddView]) {
        [data setCurrentTag:[tagEntry text]];
    } else {
        [data setCurrentTag:[tagEntry text]];
    }
}

-(void) sendForm {
    
    // check to see if form is done
    
    if (![[self data] isFormFilledOutForType:[self connectionsNeeded]]) {
        NSString *message = @"Incomplete Form.  See items in red";
        UIAlertView *emailError = [[UIAlertView alloc] initWithTitle:@"Cannot Send Form" message:message delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [emailError show];
        return;
    }
    // setup mailer and transfer control
    
    MailController *mailer = [[MailController alloc] initWithData:[self data] andFormType:[self connectionsNeeded]];
    [mailer setMailComposeDelegate:self];
    [self presentViewController:mailer animated:YES completion:nil];
    [data clear];
}

-(void) updateConnections {
    
    int addOrRemove;
    if ([self isAddView]) {
        addOrRemove = ADD;
    } else {
        addOrRemove = REMOVE;
    }
    [self updateConfigurationDataStructure];
    ConnectionsController *updateConnectorController = [[ConnectionsController alloc] initWithConnectionInfo:addOrRemove andCurrentData:data];
    [[self navigationController] pushViewController:updateConnectorController animated:YES];
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    // check which textfield needs to dismiss keyboard if none are touched
    
    UITouch *touch = [[event allTouches] anyObject];
    BOOL stillInTextField = NO;
    NSArray *views = [NSArray arrayWithObjects:tagEntry, buildingEntry, closetEntry, nil];
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
    [data setDeviceType:row];
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

@end
