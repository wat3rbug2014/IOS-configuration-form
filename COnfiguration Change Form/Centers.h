//
//  Centers.h
//  COnfiguration Change Form
//
//  Created by Douglas Gardiner on 2/22/15.
//  Copyright (c) 2015 Douglas Gardiner. All rights reserved.
//

/**
 * This class defines the various centers, their coordinates and the names.
 * It is used as a center repository for the names and coordinates to make
 * changes easier.
 */

#import <Foundation/Foundation.h>

@interface Centers : NSObject


/**
 * This array contains the full name for each of the centers.
 */

@property NSArray *centerFullNames;


/**
 * This is the Acronym listing for all of the centers.  It is aligned with the
 * full names array.
 */

@property NSArray *centerAcronyms;


/**
 * This array is aligned with the center full names and contains the 2 character
 * abbreviations used for naming the devices.
 */

@property NSArray *centerAbbreviations;


/**
 * This set contains the list of centers with basic location information.
 */

@property NSSet *centerRegions;


/**
 * This method returns the full name for the center based on the region that was found.
 *
 * @param region The region that was found and is used to get the full name of the center
 * so that it can be used for the notifications.
 *
 * @return The full name for the center is returned.
 */

-(NSString*) getNameForRegion: (CLRegion*) region;


/**
 * This method returns an index for the center so that future emails can get the proper center.
 *
 * @param region The region for the center as it was found.
 *
 * @return The index of the center as it was found in the array of centers.
 */

-(NSInteger)getIndexForRegion:(CLRegion *)region;


/**
 * This method gets the centers abbreviated name based on the index of the location.
 *
 * @param index The index of the location.
 *
 * @return The two character name of the center as a string.
 */

-(NSString*) getAbbreviatedCenterNameForIndex: (NSInteger) index;


/**
 * This method gets the centers acronym name based on the index of the location.
 *
 * @param index The index of the location.
 *
 * @return The acronym name of the center as a string.
 */

-(NSString*) getAcronymCenterNameForIndex: (NSInteger) index;

@end
