//
//  Theatre.h
//  RottenMangoes
//
//  Created by Samia Al Rahmani on 4/2/15.
//  Copyright (c) 2015 Samia Al Rahmani. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface Theatre : NSObject

@property (nonatomic) NSString *theatreName;
@property (nonatomic) NSString *theatreAddress;
@property (nonatomic) double latitude;
@property (nonatomic) double longitude;

- (instancetype)initWithDictionary:(NSDictionary *)theatreDictionary;


@end