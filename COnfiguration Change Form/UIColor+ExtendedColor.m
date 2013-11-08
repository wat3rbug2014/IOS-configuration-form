//
//  UIColor+ExtendedColor.m
//  COnfiguration Change Form
//
//  Created by Douglas Gardiner on 9/26/13.
//  Copyright (c) 2013 Douglas Gardiner. All rights reserved.
//

#import "UIColor+ExtendedColor.h"

@implementation UIColor (ExtendedColor)

#pragma mark -
#pragma mark Application specific methods

+(UIColor*) textColor {
    
    return  [UIColor colorByHex:@"0x3216b0"];
}

+(UIColor*) unFilledRequiredTextColor {
    
    return [UIColor redColor];
}

+(UIColor*) userTextColor {
    
    return  [UIColor colorByHex:@"0x00a08a"];
}

#pragma mark -
#pragma mark Category methods

+(UIColor*) colorByHex:(NSString *)hexValue {
    
    UIColor *result;
    CGFloat red = 0.0;
    CGFloat green = 0;
    CGFloat blue = 0;
    int intRed = 0;
    int intGreen = 0;
    int intBlue = 0;
    if ([hexValue length] == 6 || [hexValue length] == 8) {
        int offset = 0;
        if ([hexValue length] == 8) {
            offset = 2;
        }
        intRed = [UIColor convertHexToInt:[hexValue substringWithRange:NSMakeRange(0 + offset, 2)]];
        intGreen = [UIColor convertHexToInt:[hexValue substringWithRange:NSMakeRange(2 + offset, 2)]];
        intBlue = [UIColor convertHexToInt:[hexValue substringWithRange:NSMakeRange(4 + offset, 2)]];
        red = [UIColor colorIntToFloat:intRed];
        green = [UIColor colorIntToFloat:intGreen];
        blue = [UIColor colorIntToFloat:intBlue];
    }
    result = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    return result;
}

+(CGFloat) colorIntToFloat: (int) color {
    
    CGFloat result = (CGFloat)(color / 255.0);
    return result;
}

+(int) convertHexToInt:(NSString *)hexValue {
    
    NSString *temp = [hexValue lowercaseString];
    int result = 0;
    if ([temp length] == 2) {
        if ([temp characterAtIndex:0] >= '0' && [temp characterAtIndex:0] <= '9') {
            result += 16 * (short)([temp characterAtIndex:0] - '0');
        } else {
            result += 16 * (short)[UIColor convertUpperHexNumToInt:[hexValue characterAtIndex:0]];
        }
        if ([temp characterAtIndex:1] >= '0' && [temp characterAtIndex:0] <= '9') {
            result += (short)([temp characterAtIndex:1] - '0');
        } else {
            result += (short)[UIColor convertUpperHexNumToInt:[hexValue characterAtIndex:0]];
        }
    }
    return result;
}
/* This should be one line of calculation but..unichar */

+(int) convertUpperHexNumToInt: (char) currentLetter {
    
    switch (currentLetter) {
        case 'a': return 10;
            break;
        case 'b': return 11;
            break;
        case 'c': return 12;
            break;
        case 'd': return 13;
            break;
        case 'e': return 14;
            break;
        default: return 15;
            break;
    }
}
@end
