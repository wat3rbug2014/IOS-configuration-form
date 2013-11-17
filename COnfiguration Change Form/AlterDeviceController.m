//
//  ChangeDeviceViewController.m
//  COnfiguration Change Form
//
//  Created by Douglas Gardiner on 11/5/13.
//  Copyright (c) 2013 Douglas Gardiner. All rights reserved.
//

#import "AlterDeviceController.h"
#import "ConfigurationDataFactory.h"
#import "UIColor+ExtendedColor.h"

@interface AlterDeviceController ()

@end

@implementation AlterDeviceController


-(id) init {
    
    return [self initWithNibName:@"ReplaceDeviceController" bundle:nil];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setTitle:@"Alter"];
        [super setData:[ConfigurationDataFactory create:OTHER]];
    }
    return self;
}

@end
