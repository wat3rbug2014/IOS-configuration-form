//
//  ConnectionsController.m
//  COnfiguration Change Form
//
//  Created by Douglas Gardiner on 9/24/13.
//  Copyright (c) 2013 Douglas Gardiner. All rights reserved.
//

#import "ConnectionsController.h"
#import "ConfigurationData.h"

@interface ConnectionsController ()

@end

@implementation ConnectionsController

@synthesize connectionsNeeded;
@synthesize data;
@synthesize destTagOne;
@synthesize destTagTwo;
@synthesize devDestPortOne;
@synthesize devDestPortTwo;
@synthesize devPortOne;
@synthesize devPortTwo;
@synthesize vlan;
@synthesize oldIP;
@synthesize currentIP;
@synthesize oldIPLabel;
@synthesize currentIPLabel;

-(id) initWithConnectionInfo: (NSInteger) infoType andCurrentData: (ConfigurationData*) currentData {
    
    self = [self initWithConnectionInfo:infoType];
    if (self) {
        [self setData:currentData];
    }
    return self;
}
-(id) initWithConnectionInfo: (NSInteger) infoType {
    
    self = [self initWithNibName:@"ConnectionsController" bundle:nil];
    if (self) {
        [self setConnectionInfoRequired:infoType];
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    currentIP = [[UITextField alloc] init];
    [currentIP setTextColor:[UIColor textColor]];
    if ([self connectionsNeeded] == BOTH) {
        oldIP = [[UITextField alloc] init];
        [oldIP setTextColor:[UIColor textColor]];
        oldIPLabel = [[UILabel alloc] init];
        [oldIPLabel setText:@"Old IP"];
        [oldIPLabel setTextColor:[UIColor textColor]];
    }
    if ([self connectionsNeeded] != BOTH) {
        [oldIP setHidden:YES];
        [oldIPLabel setHidden:YES];
    }
    if ([self connectionsNeeded] == REMOVE) {
        [currentIPLabel setText:@"Old IP"];
    } else {
        [currentIPLabel setText:@"New IP"];
    }
    UIBarButtonItem *sendForm = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(sendForm)];
    [[self navigationItem] setRightBarButtonItem:sendForm];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) setConnectionInfoRequired:(NSInteger)infoType {
    
    // this is brittle because enum
    
    [self setConnectionsNeeded:infoType];
    if (infoType < BOTH || infoType > REMOVE) {
        [self setConnectionsNeeded:BOTH];
    }
    
}
-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    BOOL stillInTextField = NO;
    NSArray *views = [NSArray arrayWithObjects:devPortOne, devPortTwo, devDestPortOne, devDestPortTwo, destTagOne, destTagTwo, vlan, oldIP, currentIP, nil];
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

-(void) sendForm {
    
    if (![[self data] isFormFilledOutForType:[self connectionsNeeded]]) {
        // do alertbox -want this to go to the form section and turn everything red that is missing
        return;
    }
    MailController *mailer = [[MailController alloc] initWithData:[self data] andFormType:[self connectionsNeeded]];
    [mailer setMailComposeDelegate:self];
    [self presentViewController:mailer animated:YES completion:nil];
}
@end
