//
//  Showtimes.h
//  RottenMangoes
//
//  Created by Samia Al Rahmani on 4/3/15.
//  Copyright (c) 2015 Samia Al Rahmani. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Movie;

@interface Showtimes : NSManagedObject

@property (nonatomic, retain) NSDate * currentTime;
@property (nonatomic, retain) NSDate * lastUpdated;
@property (nonatomic, retain) NSManagedObject *movie;
@property (nonatomic, retain) Movie *theatre;

@end
