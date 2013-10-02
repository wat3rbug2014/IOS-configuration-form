//
//  UIColor+ExtendedColor.h
//  COnfiguration Change Form
//
//  Created by Douglas Gardiner on 9/26/13.
//  Copyright (c) 2013 Douglas Gardiner. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (ExtendedColor)

+(UIColor*) colorByHex: (NSString*) hexValue;
+(int) convertHexToInt: (NSString*) hexValue;
+(CGFloat) colorIntToFloat: (int) color;
+(int) convertUpperHexNumToInt: (char) currentLetter;
+(UIColor*) textColor;
+(UIColor*) userTextColor;
@end
