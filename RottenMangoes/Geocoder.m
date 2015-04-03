//
//  Geocoder.m
//  RottenMangoes
//
//  Created by Samia Al Rahmani on 4/2/15.
//  Copyright (c) 2015 Samia Al Rahmani. All rights reserved.
//

#import "Geocoder.h"
#import <AddressBookUI/AddressBookUI.h>
#import <CoreLocation/CLGeocoder.h>
#import <CoreLocation/CLPlacemark.h>

@implementation Geocoder

+ (void)getAddressFromLocation:(CLLocation *)location withCallback:(CLGeocodeCompletionHandler)callback{
    CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
    [geoCoder reverseGeocodeLocation:location completionHandler:callback];
}


@end
