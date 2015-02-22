//
//  CommentsController.h
//  COnfiguration Change Form
//
//  Created by Douglas Gardiner on 11/16/13.
//  Copyright (c) 2013 Douglas Gardiner. All rights reserved.
//

/**
 * This class of view controller allows the entry of comments so that
 * extra notes can be used to describe the equipment changes.  It also
 * uses the MFMailComposeViewControllerDelegate so that the email can be created
 * and sent out from this view.
 */

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "BasicDeviceData.h"

@interface CommentsController : UIViewController <MFMailComposeViewControllerDelegate>


/**
 * The UITextView that is used for writing the comments.
 */

@property (retain, nonatomic) IBOutlet UITextView *commentSection;


/**
 * The data model that is used for storing the comments and creating the email.
 */

@property (nonatomic) id<ConfigurationDataProtocol> data;


/**
 * The UILabel that is used for giviong the user an indication of the purpose
 * of the textview.
 */

@property (retain, nonatomic) IBOutlet UILabel *commentLabel;


/**
 * This initialization method is a wrapper to initWithBundle: in that it allows
 * the data model to be stored after creation throught the super class init method.
 *
 * @param data is a DeviceData class of some sort that is required to conform to the
 * ConfigurationDataProtocol protocol.
 *
 * @return An instance of the CommentsController is returned.
 */

-(id) initWithData: (id<ConfigurationDataProtocol>) data;


/**
 * This methods creates a MFMAilComposeViewController and populates the fields
 * based on the data stored in the data ivar.
 */

-(void) sendForm;


/**
 * This method goes to the data model and does a check to see if all the necessary data
 * is present before trying to present the mail composer view.  
 */

-(void) readyToSendForm;

@end
