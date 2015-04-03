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

- (void)getAddressFromLocation:(CLLocation *)location {
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error)
     {
         if (!placemarks) {
             // handle error
         }
         
         if(placemarks && placemarks.count > 0)
         {
             CLPlacemark *placemark= [placemarks objectAtIndex:0];
             NSString *address = [[NSString alloc] initWithFormat:@"%@",[placemark postalCode]];
             
                //[placemark subThoroughfare],[placemark thoroughfare],[placemark locality], [placemark administrativeArea]
             
             // you have the address.
             // do something with it.
             [[NSNotificationCenter defaultCenter] postNotificationName:@"MBDidReceiveAddressNotification" object:self userInfo:@{ @"address" : address }];
             NSLog(@"postal code %@", address);
         }
     }];
}

@end
