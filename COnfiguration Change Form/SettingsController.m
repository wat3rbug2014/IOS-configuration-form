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

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        [self setTitle:@"Mail Settings"];
        appData = [[ConfigurationData alloc] init];
    }
    // load the contact info up
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIBarButtonItem *addContacts = [[UIBarButtonItem alloc] initWithTitle:@"Contacts" style:UIBarButtonItemStylePlain target:self action:@selector(addContacts)];
    [[self navigationItem] setRightBarButtonItem:addContacts];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) addContacts {
    ABPeoplePickerNavigationController *listOfContacts = [[ABPeoplePickerNavigationController alloc] init];
    [listOfContacts setPeoplePickerDelegate:self];
    [self presentViewController:listOfContacts animated:YES completion:nil];
    
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [appData emailCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
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

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];

    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
 
 */
#pragma mark - ABPeoplePickerNavigationControllerDelegate

-(BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person {
    
    NSMutableString *name = [NSMutableString stringWithString: (__bridge_transfer NSString*)ABRecordCopyValue(person, kABPersonFirstNameProperty)];
    [name appendString: @" "];
    [name appendString:(__bridge_transfer NSString*)ABRecordCopyValue(person, kABPersonLastNameProperty)];
    NSString *email;
    ABMultiValueRef emailAddress = ABRecordCopyValue(person, kABPersonEmailProperty);
    if (ABMultiValueGetCount(emailAddress) > 0) {
        for (int i = 0; i < ABMultiValueGetCount(emailAddress); i++) {
            NSString *testString = (__bridge_transfer NSString*) ABMultiValueCopyValueAtIndex(emailAddress, i);
            
            // unsure if memory leak here
            
            if ([testString hasSuffix:@"@nasa.gov"]) {
                email = [[NSString alloc] initWithString: testString];
            }
        }
        // may need to remove this is nasa only emails are allowed
        
        if (email == nil) {
            email = (__bridge_transfer NSString*) ABMultiValueCopyValueAtIndex(emailAddress, 0);
        }
        if (email != nil && name != nil) {
            [appData addEmailAddress:email withName:name];
        }
    }
    [peoplePicker dismissViewControllerAnimated:YES completion:nil];
    [[self tableView] reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
    return NO;
}

-(BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier {

    return NO;
}
-(void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker {
    
    [peoplePicker dismissViewControllerAnimated:YES completion:nil];
}
@end
