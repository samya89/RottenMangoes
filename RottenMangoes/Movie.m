//
//  Movie.m
//  RottenMangoes
//
//  Created by Samia Al Rahmani on 4/1/15.
//  Copyright (c) 2015 Samia Al Rahmani. All rights reserved.
//

#import "Movie.h"

@implementation Movie

- (instancetype)initWithDictionary:(NSDictionary *)movieDictionary{
    self = [super init];
    if (self) {
        _title = [movieDictionary objectForKey:@"title"];
        NSDictionary *synopsisDictionary = [movieDictionary objectForKey:@"synopsis"];
        _synopsis = [synopsisDictionary objectForKey:@"text"];
        NSDictionary *posterDictionary = [movieDictionary objectForKey:@"poster"];
        _poster = [posterDictionary objectForKey:@"src"];
    }
    return self;
}

- (NSURL *) thumbnailURL {
    return [NSURL URLWithString:self.poster];
}


@end
