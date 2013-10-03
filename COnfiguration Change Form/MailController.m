//
//  MailController.m
//  COnfiguration Change Form
//
//  Created by Douglas Gardiner on 10/2/13.
//  Copyright (c) 2013 Douglas Gardiner. All rights reserved.
//

#import "MailController.h"
#import "enumList.h"

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
    NSMutableString *subjectLine;
    NSString *tag;
    NSArray *devices = [NSArray arrayWithObjects:@"Access Switch", @"UPS", @"Access Point", @"Distribution Switch", @"Access Router", nil];
    switch ([self formType]) {
        case ADD: {
            subjectLine = [NSMutableString stringWithString:@"Added "];
            tag = [[self formData] currentTag];
            break;
        }
        case REMOVE: {
            subjectLine = [NSMutableString stringWithString:@"Removed "];
            tag = [[self formData] oldTag];
            break;
        }
        default: {
            subjectLine = [NSMutableString stringWithString:@"Changed "];
            tag = [[self formData] oldTag];
            break;
        }
    }
    [subjectLine appendString:[devices objectAtIndex:[[self formData] deviceType]]];
    [subjectLine appendString:@" tag# "];
    [subjectLine appendString:tag];
    if ([self formType] == BOTH) {
        [subjectLine appendString:@" with new tag# "];
        [subjectLine appendString:[[self formData] currentTag]];
    }
    [self setToRecipients:[[self formData] getMailingList]];
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
