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
        // Do any additional setup after loading the view from its nib.
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
@end
