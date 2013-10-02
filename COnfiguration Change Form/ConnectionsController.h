//
//  ConnectionsController.h
//  COnfiguration Change Form
//
//  Created by Douglas Gardiner on 9/24/13.
//  Copyright (c) 2013 Douglas Gardiner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "enumList.h"
#import "ConfigurationData.h"
#import "UIColor+ExtendedColor.h"

@interface ConnectionsController : UIViewController

-(void) setConnectionInfoRequired: (NSInteger) infoType;

@property (nonatomic) NSInteger connectionsNeeded;
@property (retain, nonatomic) ConfigurationData *data;
@property (retain, nonatomic) IBOutlet UITextField *devPortOne;
@property (retain, nonatomic) IBOutlet UITextField *devPortTwo;
@property (retain, nonatomic) IBOutlet UITextField *devDestPortOne;
@property (retain, nonatomic) IBOutlet UITextField *devDestPortTwo;
@property (retain, nonatomic) IBOutlet UITextField *destTagOne;
@property (retain, nonatomic) IBOutlet UITextField *destTagTwo;
@property (retain, nonatomic) IBOutlet UITextField *vlan;
@property (retain, nonatomic) IBOutlet UITextField *oldIP;
@property (retain, nonatomic) IBOutlet UITextField *currentIP;
@property (retain, nonatomic) IBOutlet UILabel *oldIPLabel;
@property (retain, nonatomic) IBOutlet UILabel *currentIPLabel;

-(id) initWithConnectionInfo: (NSInteger) infoType andCurrentData: (ConfigurationData*) currentData;
-(id) initWithConnectionInfo: (NSInteger) infoType;

@end
