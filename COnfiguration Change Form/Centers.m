//
//  Centers.m
//  COnfiguration Change Form
//
//  Created by Douglas Gardiner on 2/22/15.
//  Copyright (c) 2015 Douglas Gardiner. All rights reserved.
//

/**
 * This class is used for center location information.  I didn't like center
 * stuff spread out everywhere because it becomes an unwieldy mess and prone to
 * troubleshooting events and bugs.
 */

#import "Centers.h"
#import <CoreLocation/CoreLocation.h>

@implementation Centers

@synthesize centerAbbreviations;
@synthesize centerAcronyms;
@synthesize centerFullNames;
@synthesize centerRegions;

float const METERS_PER_MILE = 1609.4;
CLLocationDistance const defaultDistance = 3 * METERS_PER_MILE;
CLLocationDistance const wstfDistance = 100 * METERS_PER_MILE;

-(id) init {
    
    if (self = [super init]) {
        
        // setup values to create regions and the essential arrays
        
        centerAcronyms = [NSArray arrayWithObjects: @"JSC", @"WSTF", @"JPL", @"KSC", @"LARC", nil];
        centerAbbreviations = [NSArray arrayWithObjects:@"js", @"ws", @"jp", @"ks", @"lc", nil];
        centerFullNames = [NSArray arrayWithObjects:@"Johnson Space Center", @"White Sands Test Facility", @"Jet Propulsion Laboratory", @"Kennedy Space Center", @"Langley Research Center", nil];
        double longitudes[] = { 29.5630, 32.33555556, 137.4416334989196, 28.51944444, 37.08583333};
        double latitdutes[] = { -95.0910,  -106.4058333, -4.5894669521344875, -80.67, -76.38055556};

        // create an array of regions
        
        NSMutableArray *tempListing = [[NSMutableArray alloc] init];
        for (int i = 0; i < [centerAcronyms count]; i++) {
            CLLocationCoordinate2D  currentCoord = {longitudes[i], latitdutes[i]};
            CLCircularRegion *currentRegion;
            if ([[centerAcronyms objectAtIndex:i] rangeOfString:@"WSTF"].location != NSNotFound) {
                currentRegion = [[CLCircularRegion alloc] initWithCenter:currentCoord radius:wstfDistance identifier:@"WSTF"];
            } else {
                currentRegion = [[CLCircularRegion alloc] initWithCenter:currentCoord radius:defaultDistance identifier:[centerAcronyms objectAtIndex:i]];
            }
            NSLog(@"making %@", [currentRegion identifier]);
            [tempListing addObject:currentRegion];
        }
        centerRegions = [NSSet setWithArray:tempListing];
    }
    return self;
}

-(NSString *)getNameForRegion:(CLRegion *)region {
    
    int index = 0;
    
    for (int i = 0; i < [centerAcronyms count]; i++) {
        NSString *currentRegion = [centerAcronyms objectAtIndex:i];
        if ([[region identifier] rangeOfString:currentRegion].location != NSNotFound) {
            index = i;
            NSLog(@"Found %@", [region identifier]);
        }
    }
    return [centerFullNames objectAtIndex:index];
}

-(NSInteger)getIndexForRegion:(CLRegion *)region {
    
    NSInteger index = 0;
    
    for (int i = 0; i < [centerAcronyms count]; i++) {
        NSString *currentRegion = [centerAcronyms objectAtIndex:i];
        if ([[region identifier] rangeOfString:currentRegion].location != NSNotFound) {
            index = i;
            NSLog(@"Found %@", [region identifier]);
        }
    }
    return index;
}

-(NSString*) getAbbreviatedCenterNameForIndex:(NSInteger)index {
    
    return [centerAbbreviations objectAtIndex:index];
}

-(NSString*) getAcronymCenterNameForIndex:(NSInteger)index {
    
    return [centerAcronyms objectAtIndex:index];
}

@end
