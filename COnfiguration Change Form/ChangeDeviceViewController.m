//
//  ChangeDeviceViewController.m
//  COnfiguration Change Form
//
//  Created by Douglas Gardiner on 11/5/13.
//  Copyright (c) 2013 Douglas Gardiner. All rights reserved.
//

#import "ChangeDeviceViewController.h"
#import "ConfigurationDataFactory.h"

@interface ChangeDeviceViewController ()

@end

@implementation ChangeDeviceViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setTitle:@"Alter"];
        [super setData:[ConfigurationDataFactory create:OTHER]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
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
