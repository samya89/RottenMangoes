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
//        _latitude = [theatreDictionary objectForKey:@"lat"];
//        _longitude = [theatreDictionary objectForKey:@"lng"];
    }
    return self;
}





@end
