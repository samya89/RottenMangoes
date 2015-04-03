//
//  Theatre.m
//  RottenMangoes
//
//  Created by Samia Al Rahmani on 4/2/15.
//  Copyright (c) 2015 Samia Al Rahmani. All rights reserved.
//

#import "Theatre.h"

@implementation Theatre

- (instancetype)initWithDictionary:(NSDictionary *)theatreDictionary{
    self = [super init];
    if (self) {
        NSDictionary *theatresDictionary = [theatreDictionary objectForKey:@"theatres"];
        _theatreName = [theatresDictionary objectForKey:@"name"];
        _theatreAddress = [theatresDictionary objectForKey:@"address"];
        
        NSNumber *lat = [theatreDictionary objectForKey:@"lat"];
        NSNumber *lng = [theatreDictionary objectForKey:@"lng"];
        
        _latitude = [lat doubleValue];
        _longitude = [lng doubleValue];

    }
    return self;
}


@end
