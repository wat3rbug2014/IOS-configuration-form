//
//  FormViewControllerFactoryViewController.m
//  COnfiguration Change Form
//
//  Created by Douglas Gardiner on 11/5/13.
//  Copyright (c) 2013 Douglas Gardiner. All rights reserved.
//

#import "FormViewControllerFactory.h"
#import "enumList.h"

@interface FormViewControllerFactory ()

@end

@implementation FormViewControllerFactory


+(id) createFormView: (int) type {
    
    if (type == ADD) {
        return [[AddDeviceViewController alloc] init];
    }
    if (type == REMOVE) {
        return [[RemoveDeviceViewController alloc] init];
    }
    if (type == REPLACE) {
        return [[ReplaceDeviceController alloc] init];
    }
    return [[ReplaceDeviceController alloc] init];
}

@end
