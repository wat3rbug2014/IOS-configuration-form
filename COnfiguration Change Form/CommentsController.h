//
//  CommentsController.h
//  COnfiguration Change Form
//
//  Created by Douglas Gardiner on 11/16/13.
//  Copyright (c) 2013 Douglas Gardiner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "BasicDeviceData.h"

@interface CommentsController : UIViewController <MFMailComposeViewControllerDelegate>


@property (retain, nonatomic) IBOutlet UITextView *commentSection;
@property (nonatomic) id<ConfigurationDataProtocol> data;
@property (retain, nonatomic) IBOutlet UILabel *commentLabel;

-(id) initWithData: (BasicDeviceData*) data;

-(void) sendForm;

-(void) readyToSendForm;
@end
