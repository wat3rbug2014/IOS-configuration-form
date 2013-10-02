//
//  MailController.h
//  COnfiguration Change Form
//
//  Created by Douglas Gardiner on 10/2/13.
//  Copyright (c) 2013 Douglas Gardiner. All rights reserved.
//

#import <MessageUI/MessageUI.h>
#import "ConfigurationData.h"

@interface MailController : MFMailComposeViewController

@property (retain, nonatomic) ConfigurationData *formData;
@property NSInteger formType;

-(id) initWithData: (ConfigurationData*) data andFormType: (NSInteger) type;

@end
