//
//  AddOrRemoveDeviceController.m
//  COnfiguration Change Form
//
//  Created by Douglas Gardiner on 9/24/13.
//  Copyright (c) 2013 Douglas Gardiner. All rights reserved.
//

#import "RemoveDeviceController.h"
#import "UIColor+ExtendedColor.h"
#import "ConfigurationDataFactory.h"
#import "CommentsController.h"
#import "RemoveDeviceData.h"

@interface RemoveDeviceController ()

@end

@implementation RemoveDeviceController


#pragma mark -
#pragma mark Initialization Methods

-(id) init {
    
    return [self initWithNibName:@"RemoveDeviceController" bundle:nil];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setTitle: @"Remove"];
        [super setData:[ConfigurationDataFactory create:REMOVE]];
        [self setRestorationIdentifier:@"RemoveDevice"];
    }
    return self;
}

#pragma mark -
#pragma mark Superclass methods

- (void)viewDidLoad {
    

    [super viewDidLoad];
    
    // this is redundant but the data structure type changes between init and viewdidload ?!!
    [super setData:[ConfigurationDataFactory create:REMOVE]];
    
    UIBarButtonItem *toCommenter = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStylePlain target:self action:@selector(pushNextController)];
    [[self navigationItem] setRightBarButtonItem:toCommenter];
    UIColor *textColor = [UIColor textColor];
    [super.currentTagLabel setTextColor:textColor];
    [super.currentTagLabel setText:@"Old tag"];
    [self updateFormContents];
    [self changeLabelColorForMissingInfo];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    [self updateConfigurationDataStructure];
    NSLog(@"%@ is showing memory warning", [[self class] description]);
}

-(void) updateConfigurationDataStructure {
    
    [super updateConfigurationDataStructure];
    [[super data] setTag:[[super currentTag] text]];
}

-(void) pushNextController {
    
    [self updateConfigurationDataStructure];
    CommentsController *commenter = [[CommentsController alloc] initWithData:self.data];
    [[self navigationController] pushViewController:commenter animated:YES];
}

-(void) changeLabelColorForMissingInfo {
    
    [super changeLabelColorForMissingInfo];
    if ([[[super currentTag] text] length] > 0) {
        [[super currentTagLabel] setTextColor:[UIColor textColor]];
    } else {
        [[super currentTagLabel] setTextColor:[UIColor unFilledRequiredTextColor]];
    }
}

-(void) updateFormContents {
    
    [super updateFormContents];
    [[super currentTag] setText:[[super data] tag]];
}

#pragma mark -
#pragma mark UITextFieldDelegate methods

-(BOOL) textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    [self updateConfigurationDataStructure];
    [self changeLabelColorForMissingInfo];
    return YES;
}

#pragma mark -
#pragma mark UIResponder methods

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self updateConfigurationDataStructure];
    [self changeLabelColorForMissingInfo];
}
@end
