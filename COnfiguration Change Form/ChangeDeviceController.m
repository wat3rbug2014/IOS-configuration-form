//
//  ChangeDeviceViewController.m
//  COnfiguration Change Form
//
//  Created by Douglas Gardiner on 11/5/13.
//  Copyright (c) 2013 Douglas Gardiner. All rights reserved.
//

#import "ChangeDeviceController.h"
#import "ConfigurationDataFactory.h"

@interface ChangeDeviceController ()

@end

@implementation ChangeDeviceController

@synthesize currentTag;

-(id) init {
    
    return [self initWithNibName:@"AddDeviceController" bundle:nil];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setTitle:@"Alter"];
        [super setData:[ConfigurationDataFactory create:OTHER]];
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) changeLabelColorForMissingInfo {
    
    
}

-(void) updateConfigurationDataStructure {
    
    
}

-(void) pushConnectionsController {
    
    
}

-(void) updateFormContents {
    
    
}

@end
