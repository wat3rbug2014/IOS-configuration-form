//
//  UIColor+ExtendedColor.h
//  COnfiguration Change Form
//
//  Created by Douglas Gardiner on 9/26/13.
//  Copyright (c) 2013 Douglas Gardiner. All rights reserved.
//

/**
 * This extension to the UIColor class to allow colors to be determined using hexidecimal
 * values.  It includes helper method for determining colors as well as a few methods
 * that predefined colors can be used to help keep a theme to the app.  Opacity was chosen 
 * because it provides a performance enhancement and because the app had no need for tarnsparency
 * effects.
 */

#import <UIKit/UIKit.h>

@interface UIColor (ExtendedColor)


/**
 * This method takes a hexidecimal value expressed in the format of 0xabcdef or abcdef and returns
 * a RGB version of the color with opaque properties.
 *
 * @param hexValue A string with the composite hexidecimal value in RGB format.
 *
 * @return A color that uses RGB values from the hexideciaml string passed to it.  The color is NOT 
 * transparent, but opaque.
 */

+(UIColor*) colorByHex: (NSString*) hexValue;


/**
 * This method takes a 2 character hexidecimal string and produces an integer value.  The assumption
 * is that the string has already been parsed and the characters range from 0-9a-f.  This method is 
 * meant to be a private method ONLY.
 *
 * @param hexValue A string with 2 characters that represents a hexidecimal value.
 *
 * @return An integer value from 0-255 that is used for RGB color creation.
 */

+(int) convertHexToInt: (NSString*) hexValue;


/**
 * This method method converts an integer value from 0-255 to a float value that the UIColor class 
 * can use for its RGB initialization methods.
 *
 * @param color An integer value from 0-255 that can represent a portion of an RGB color selection.
 *
 * @return The float value used by the UIColor library.
 */

+(CGFloat) colorIntToFloat: (int) color;


/**
 * Performs integer and integer calculation for hexidecimal lower case characters above 9.  Its a 
 * bad hack cause I was in a hurry, as is half of the class.
 *
 * @param currentLetter The letter that is to be converted to an integer equivalent.
 *
 * @return The integer value of the character that was sent.
 */

+(int) convertLowerHexNumToInt: (char) currentLetter;


/**
 * This class method returns the color used for labels and other things for a uniform color 
 * throughout the application.
 *
 * @return UIColor for the labels on the forms.
 */

+(UIColor*) textColor;


/**
 * This class method returns a color that is for the text the user is entering.
 *
 * @return UIColor for the user entry text.
 */

+(UIColor*) userTextColor;


/**
 * This class method returns UIColor to indicate that something
 * is not complete.
 *
 * @return UIColor to signify some text is not filled in properly.
 */

+(UIColor*) unFilledRequiredTextColor;


/**
 * A UIColor that is used in the navigation bars for the text.
 *
 * @return UIColor for the text in the navigation items.
 */

+(UIColor*) navigatorItemColor;

@end
