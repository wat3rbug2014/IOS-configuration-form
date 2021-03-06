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

#pragma mark - Initialization Methods

-(id) init {
    
    if ((self = [super init])) {
        devices = [[PickerItems alloc] init];
    }
    return self;
    
}

-(id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        devices = [[PickerItems alloc] init];
    }
    return self;
}

#pragma mark - Overridden methods

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // setup text and labels
    
    UIColor *textColor = [UIColor textColor];
    [currentTagLabel setTextColor:textColor];
    
    // setup roller selector
    
    deviceTypeSelection = [[UIPickerView alloc] initWithFrame:CGRectMake(0.0, 185.0, 320.0, 162.0)];
    [deviceTypeSelection setDelegate:self];
    [deviceTypeSelection selectRow: DEF_ROW inComponent:0 animated:NO];
    [deviceTypeSelection setShowsSelectionIndicator:YES];
    [self.view addSubview:deviceTypeSelection];
    [deviceTypeSelection reloadAllComponents];
    [deviceTypeSelection selectRow:AS inComponent:0 animated:YES];
    [data setDeviceType:[deviceTypeSelection selectedRowInComponent:0]];
    [deviceTypeSelResult setText:[data getDeviceTypeString]];
    
    // setup textfields
    
    [currentTag setTextColor:[UIColor userTextColor]];
    [buildingEntry setTextColor:[UIColor userTextColor]];
    [closetEntry setTextColor:[UIColor userTextColor]];
    [deviceTypeSelResult setTextColor:[UIColor userTextColor]];
    [currentTag setDelegate:self];
    [buildingEntry setDelegate:self];
    [closetEntry setDelegate:self];
    
    // add navigation button
    
    UIBarButtonItem *toConnection = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStylePlain target:self action:@selector(pushNextController)];
    [[self navigationItem] setRightBarButtonItem:toConnection];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CurrentViewController" object:self userInfo:[NSDictionary dictionaryWithObjectsAndKeys:self, @"CurrentViewController", nil]];
}

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self updateConfigurationDataStructure];
    [self changeLabelColorForMissingInfo];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    [self updateConfigurationDataStructure];
    NSLog(@"%@ is showing memory warning", [[self class] description]);
}

#pragma mark - Class specific methods

-(void) updateConfigurationDataStructure {
    
    [data setBuilding:[buildingEntry text]];
    [data setCloset:[closetEntry text]];
    [data setDeviceType:[deviceTypeSelection selectedRowInComponent:0]];
}

-(void) pushNextController {
    
    ConnectionsController *updateConnectorController = [[ConnectionsController alloc] init];
    [updateConnectorController setData:[self data]];
    [[self navigationController] pushViewController:updateConnectorController animated:YES];
}

-(void) changeLabelColorForMissingInfo {
    
    if ([[buildingEntry text] length] > 0) {
        [buildingLabel setTextColor:[UIColor textColor]];
    } else {
        [buildingLabel setTextColor:[UIColor unFilledRequiredTextColor]];
    }
    if ([[closetEntry text] length] > 0) {
        [closetLabel setTextColor:[UIColor textColor]];
    } else {
        [closetLabel setTextColor:[UIColor unFilledRequiredTextColor]];
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
    [deviceTypeSelResult setText:[data getDeviceTypeString]];
}


#pragma mark - UIPickerViewDataSource methods


-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 1;
}

-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return [devices count];
}

#pragma mark - UIPickerViewDelegate methods


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

#pragma mark - UITextFieldDelegate methods


-(BOOL) textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    [self updateConfigurationDataStructure];
    [self changeLabelColorForMissingInfo];
    return YES;
}

-(void) textFieldDidBeginEditing:(UITextField *)textField {
    
    [self updateConfigurationDataStructure];
    [self changeLabelColorForMissingInfo];
}

@end