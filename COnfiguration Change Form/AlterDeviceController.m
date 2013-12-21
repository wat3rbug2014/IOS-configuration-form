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
#import "ConnectionsController.h"

@interface AlterDeviceController ()

@end

@implementation AlterDeviceController


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

-(void) viewDidLoad {
    
    [super viewDidLoad];
    [super setData:[ConfigurationDataFactory create:OTHER]];
    UIBarButtonItem *toConnection = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStylePlain target:self action:@selector(pushNextController)];
    [[self navigationItem] setRightBarButtonItem:toConnection];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    [self updateConfigurationDataStructure];
    NSLog(@"%@ is showing memory warning", [[self class] description]);
}

-(void) pushNextController {
    
    ConnectionsController *updateConnectorController = [[ConnectionsController alloc] init];
    [[self navigationController] pushViewController:updateConnectorController animated:YES];
}
@end
