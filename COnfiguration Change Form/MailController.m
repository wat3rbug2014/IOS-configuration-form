//
//  MailController.m
//  COnfiguration Change Form
//
//  Created by Douglas Gardiner on 10/2/13.
//  Copyright (c) 2013 Douglas Gardiner. All rights reserved.
//

#import "MailController.h"

@interface MailController ()

@end

@implementation MailController

@synthesize formData;
@synthesize formType;

-(id) initWithData:(ConfigurationData *)data andFormType:(NSInteger)type {
    
    self = [self initWithNibName:nil bundle:nil];
    [self setFormData: data];
    [self setFormType: formType];
    return  self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
