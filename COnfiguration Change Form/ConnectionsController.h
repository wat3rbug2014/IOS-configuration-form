//
//  ConnectionsController.h
//  COnfiguration Change Form
//
//  Created by Douglas Gardiner on 9/24/13.
//  Copyright (c) 2013 Douglas Gardiner. All rights reserved.
//

/**
 * This view controller is used to add all the connection information for the
 * particular data model.
 */

#import <Foundation/Foundation.h>
#import "ConfigurationDataProtocol.h"
#import <MessageUI/MessageUI.h>
#import "FormViewProtocol.h"
#define OFFSET 20.0

@interface ConnectionsController : UIViewController<UITextFieldDelegate, MFMailComposeViewControllerDelegate, FormViewProtocol>


/**
 * The data model that is used to store the information.
 */

@property (retain, nonatomic) id<ConfigurationDataProtocol> data;


/**
 * This textfield is for entering the port on the device that is used to 
 * connect to the first distant end device.
 */

@property (retain, nonatomic) IBOutlet UITextField *devPortOne;


/**
 * This textfield is for entering the port on the device that is used to
 * connect to the second distant end device.
 */

@property (retain, nonatomic) IBOutlet UITextField *devPortTwo;


/**
 * This textfield is for entering the port on the first distant end device
 * for which the current device is now connected.
 */

@property (retain, nonatomic) IBOutlet UITextField *devDestPortOne;


/**
 * This textfield is for entering the port on the second distant end device
 * for which the current device is now connected.
 */

@property (retain, nonatomic) IBOutlet UITextField *devDestPortTwo;


/**
 * This textfield is for entering the tag on the first distant end device
 * for which the current device is now connected.
 */

@property (retain, nonatomic) IBOutlet UITextField *destTagOne;


/**
 * This textfield is for entering the tag on the second distant end device
 * for which the current device is now connected.
 */

@property (retain, nonatomic) IBOutlet UITextField *destTagTwo;


/**
 * The textfield for entering the VLAN that the current device is using.
 */

@property (retain, nonatomic) IBOutlet UITextField *vlan;


/**
 * The textfield for enting the current IP address or symbolic representation
 * for the address.
 */

@property (retain, nonatomic) IBOutlet UITextField *currentIP;


/**
 * This label is for entering the port on the device that is used to
 * connect to the first distant end device.
 */

@property (retain, nonatomic) IBOutlet UILabel *devPortOneLabel;


/**
 * This label is for entering the port on the device that is used to
 * connect to the second distant end device.
 */

@property (retain, nonatomic) IBOutlet UILabel *devPortTwoLabel;


/**
 * This label is for entering the first port on the distant end device that 
 * is used to connect the current device.
 */

@property (retain, nonatomic) IBOutlet UILabel *devDestPortOneLabel;


/**
 * This label is for entering the second port on the distant end device that
 * is used to connect the current device.
 */

@property (retain, nonatomic) IBOutlet UILabel *devDestPortTwoLabel;


/**
 * This label is for entering the first tag on the distant end device that
 * is used to connect the current device.
 */

@property (retain, nonatomic) IBOutlet UILabel *destTagOneLabel;


/**
 * This label is for entering the second port on the distant end device that
 * is used to connect the current device.
 */

@property (retain, nonatomic) IBOutlet UILabel *destTagTwoLabel;


/**
 * This label is for entering the VLAN on the current device.
 */

@property (retain, nonatomic) IBOutlet UILabel *vlanLabel;


/**
 * This label is for entering the IP address on the current device.
 */

@property (retain, nonatomic) IBOutlet UILabel *currentIPLabel;


/**
 * The instance of the notification center that is used to listen
 * for special events and determine how the keyboard should react.
 */

@property (retain) NSNotificationCenter *notifier;


/**
 * This variable stores the current textfield so that it can be checked
 * with touch events to determine if it should be dismissed or released.
 */

@property (retain, nonatomic) UITextField *activeField;


/**
 * This view is manipulated based on which textfield is being edited and
 * when the keyboard is dismissed or raised.
 */

@property (retain,nonatomic) IBOutlet UIScrollView *scrollView;


/**
 * System size that is used for the keyboard based on dynamic keyboard
 * sizes.
 */

@property (nonatomic) CGSize keyboardSize;


/**
 * Coordinates used by the superview so that they can be adjusted for keyboard
 * animations.
 */

@property (nonatomic) CGPoint originalFrame;


/**
 * Initialization wrapper that uses the super class initWithBundle: method and
 * then sets the data model.
 *
 * @param newData The data model that conforms to ConfigurationDataProtocol
 *
 * @return A viewcontroller that has the data model already set.
 */

-(id) initWithData: (id<ConfigurationDataProtocol>) newData;


/**
 * This method will change the color of label for the first uplink based on whether
 * it is filled out properly or not.
 */

-(void) changeUpLinkOneColor;


/**
 * This method will change the color of label for the second uplink based on whether
 * it is filled out properly or not.
 */

-(void) changeUpLinkTwoColor;


/**
 * This method will change the color of label for the VLAN based on whether
 * it is filled out properly or not.
 */

-(void) changeVlanInfoColor;


/**
 * This method sets the color of the labels for the first link to default because it is
 * not used for this form.
 */

-(void) setUnusedUplinkOne;


/**
 * This method sets the color of the labels for the second link to default because it is
 * not used for this form.
 */

-(void) setUnusedUplinkTwo;


/**
 * This method sets the color of the labels for the VLAN to default because it is not used
 * for this form.
 */

-(void) setUnusedVlan;

/**
 * This method is called by the notification center because the view is observing the calls.
 * It performs the calculations for the keyboard and then animates the scrollview so that
 * what is being edited will be viewable when the keyboard is shown.
 *
 * @param notice The notification that the notification center passes to the method.  Currently
 * not used.
 */

-(void) keyboardWillBeShown: (NSNotification*) notice;

/**
 * This method is called by the notification center because the view is observing the calls.
 * It performs the calculations for the keyboard and then animates the scrollview so that
 * what is being edited will be viewable when the keyboard is dismissed.
 *
 * @param notice The notification that the notification center passes to the method.  Currently
 * not used.
 */

-(void) keyboardWillBeHidden: (NSNotification*) notice;

@end
