//
//  CommentsController.m
//  COnfiguration Change Form
//
//  Created by Douglas Gardiner on 11/16/13.
//  Copyright (c) 2013 Douglas Gardiner. All rights reserved.
//

#import "CommentsController.h"
#import "UIColor+ExtendedColor.h"

@interface CommentsController ()

@end

@implementation CommentsController


@synthesize commentSection;
@synthesize commentLabel;

-(id) initWithData:(BasicDeviceData *)data {
    
    self = [self initWithNibName:@"CommentsController" bundle:nil];
    [self setData: data];
    return  self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIBarButtonItem *sendForm = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(sendForm)];
    [[self navigationItem] setRightBarButtonItem:sendForm];
    [commentLabel setTextColor:[UIColor textColor]];
    [commentLabel setText:@"Tap below to comment"];
    [commentSection setTextColor:[UIColor userTextColor]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) sendForm {
 
    [[self data] setComments:[commentSection text]];
    // check to see if form is done
    
    //    if (![[self data] isReadyToSend]) {
    //        NSString *message = @"Incomplete Form.  See items in red";
    //        UIAlertView *emailError = [[UIAlertView alloc] initWithTitle:@"Cannot Send Form" message:message delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    //        [emailError show];
    //        return;
    //    }
    // setup mailer and transfer control
    
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
        [mailer setMailComposeDelegate:self];
        [mailer setToRecipients:[[self data] getMailingList]];
        [mailer setSubject:[[self data] getEmailSubject]];
        [mailer setMessageBody:[[self data] getEmailMessageBody] isHTML:NO];
        [self presentViewController:mailer animated:YES completion:nil];
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        NSString *message = @"Unable to send email.  Please check your settings";
        UIAlertView *emailError = [[UIAlertView alloc] initWithTitle:@"EMail Not Setup" message:message delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [emailError show];
    }
}
@end
