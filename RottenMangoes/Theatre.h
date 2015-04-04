//
//  Theatre.h
//  RottenMangoes
//
//  Created by Samia Al Rahmani on 4/3/15.
//  Copyright (c) 2015 Samia Al Rahmani. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Movie, Showtimes;

@interface Theatre : NSManagedObject

@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSSet *movies;
@property (nonatomic, retain) NSSet *showtimes;
@end

@interface Theatre (CoreDataGeneratedAccessors)

- (void)addMoviesObject:(Movie *)value;
- (void)removeMoviesObject:(Movie *)value;
- (void)addMovies:(NSSet *)values;
- (void)removeMovies:(NSSet *)values;

- (void)addShowtimesObject:(Showtimes *)value;
- (void)removeShowtimesObject:(Showtimes *)value;
- (void)addShowtimes:(NSSet *)values;
- (void)removeShowtimes:(NSSet *)values;

@end
