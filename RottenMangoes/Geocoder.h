//
//  Geocoder.h
//  RottenMangoes
//
//  Created by Samia Al Rahmani on 4/2/15.
//  Copyright (c) 2015 Samia Al Rahmani. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
@interface Geocoder : CLGeocoder

@property (nonatomic, readonly, copy) NSString *postalCode;

- (void)getAddressFromLocation:(CLLocation *)location;


@end
