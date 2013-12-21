//
//  ConnectionsController.h
//  COnfiguration Change Form
//
//  Created by Douglas Gardiner on 9/24/13.
//  Copyright (c) 2013 Douglas Gardiner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConfigurationDataProtocol.h"
#import <MessageUI/MessageUI.h>
#import "FormViewProtocol.h"

@interface ConnectionsController : UIViewController<UITextFieldDelegate, MFMailComposeViewControllerDelegate, FormViewProtocol>

@property (retain, nonatomic) id<ConfigurationDataProtocol> data;
@property (retain, nonatomic) IBOutlet UITextField *devPortOne;
@property (retain, nonatomic) IBOutlet UITextField *devPortTwo;
@property (retain, nonatomic) IBOutlet UITextField *devDestPortOne;
@property (retain, nonatomic) IBOutlet UITextField *devDestPortTwo;
@property (retain, nonatomic) IBOutlet UITextField *destTagOne;
@property (retain, nonatomic) IBOutlet UITextField *destTagTwo;
@property (retain, nonatomic) IBOutlet UITextField *vlan;
@property (retain, nonatomic) IBOutlet UITextField *currentIP;

@property (retain, nonatomic) IBOutlet UILabel *devPortOneLabel;
@property (retain, nonatomic) IBOutlet UILabel *devPortTwoLabel;
@property (retain, nonatomic) IBOutlet UILabel *devDestPortOneLabel;
@property (retain, nonatomic) IBOutlet UILabel *devDestPortTwoLabel;
@property (retain, nonatomic) IBOutlet UILabel *destTagOneLabel;
@property (retain, nonatomic) IBOutlet UILabel *destTagTwoLabel;
@property (retain, nonatomic) IBOutlet UILabel *vlanLabel;
@property (retain, nonatomic) IBOutlet UILabel *currentIPLabel;

-(id) initWithData: (id<ConfigurationDataProtocol>) newData;

@end
