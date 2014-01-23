//
//  SettingsController.m
//  COnfiguration Change Form
//
//  Created by Douglas Gardiner on 9/24/13.
//  Copyright (c) 2013 Douglas Gardiner. All rights reserved.
//

#import "SettingsController.h"
#import "UIColor+ExtendedColor.h"

@interface SettingsController ()

@end

@implementation SettingsController

@synthesize appData;

#pragma mark -
#pragma mark Initialization methods

- (id)initWithStyle:(UITableViewStyle)style {
    
    self = [super initWithStyle:style];
    if (self) {
        [self setTitle:@"Mail Settings"];
        appData = [[BasicDeviceData alloc] init];
    }
    return self;
}

#pragma mark -
#pragma mark Superclass methods

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *addContacts = [[UIBarButtonItem alloc] initWithTitle:@"Contacts" style:UIBarButtonItemStylePlain target:self action:@selector(addContacts)];
    [[self navigationItem] setRightBarButtonItem:addContacts];
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) addContacts {
    
    ABPeoplePickerNavigationController *listOfContacts = [[ABPeoplePickerNavigationController alloc] init];
    [listOfContacts setPeoplePickerDelegate:self];
    NSArray *itemsToDisplay = [NSArray arrayWithObjects:[NSNumber numberWithInt: kABPersonFirstNameProperty]
                               ,[NSNumber numberWithInt: kABPersonLastNameProperty], [NSNumber numberWithInt: kABPersonEmailProperty], nil];
    [listOfContacts setDisplayedProperties:itemsToDisplay];
    [self presentViewController:listOfContacts animated:YES completion:nil];
    
}

#pragma mark -
#pragma mark TableViewDataSource methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [appData emailCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    [[cell textLabel] setText:[appData getNameAtIndex:indexPath.row]];
    [[cell textLabel] setTextColor:[UIColor textColor]];
    [[cell detailTextLabel] setTextColor:[UIColor userTextColor]];
    [[cell detailTextLabel] setText:[appData getEmailAtIndex:indexPath.row]];
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [appData removeEntryAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

#pragma mark -
#pragma mark - TableViewDelegate methods

//* Added so that the app doesn't hang up just cause it is selected. */

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark - ABPeoplePickerNavigationControllerDelegate

-(BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person {
    
    return YES;
}

-(BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier {

    bool tryAgain = YES;

    // make name title for the email dictionary entry
        
    NSMutableString *name = [NSMutableString stringWithString:(__bridge_transfer NSString*)ABRecordCopyCompositeName(person)];
    if (property == kABPersonEmailProperty) {
        tryAgain = NO;
    }

    // make email address for dictionary entry
        
    NSString *email;
    ABMultiValueRef emailAddress = ABRecordCopyValue(person, kABPersonEmailProperty);
    if (ABMultiValueGetCount(emailAddress) > 1) {
        int index = ABMultiValueGetIndexForIdentifier(emailAddress, identifier);
        email = (__bridge_transfer NSString*) ABMultiValueCopyValueAtIndex(emailAddress, index);
    }
    if (ABMultiValueGetCount(emailAddress) == 1) {
        email = (__bridge_transfer NSString*)ABMultiValueCopyValueAtIndex(emailAddress, 0);
    }
    // do popup if no email otherwise add to dictionary
        
    if (email != nil && name != nil) {
        [appData addEmailAddress:email withName:name];
    } else {
        NSString *message = [NSString stringWithFormat:@"%@ does not have an email address", name];
        UIAlertView *emailSelectError = [[UIAlertView alloc] initWithTitle:@"No Email Address" message:message delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [emailSelectError show];
    }

    [peoplePicker dismissViewControllerAnimated:YES completion:nil];
    [[self tableView] reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
    return tryAgain;
}

-(void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker {
    
    [peoplePicker dismissViewControllerAnimated:YES completion:nil];
}

@end
