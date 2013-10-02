//
//  PickerItems.h
//  COnfiguration Change Form
//
//  Created by Douglas Gardiner on 10/1/13.
//  Copyright (c) 2013 Douglas Gardiner. All rights reserved.
//
// Just a basic data structure because these items are common
// among the three views

#import <Foundation/Foundation.h>

@interface PickerItems : NSObject

@property (retain, readonly) NSArray *items;

-(NSInteger) count;
-(NSString*) deviceAtIndex: (NSInteger) index;

@end
