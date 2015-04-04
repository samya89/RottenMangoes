//
//  Movie.h
//  RottenMangoes
//
//  Created by Samia Al Rahmani on 4/3/15.
//  Copyright (c) 2015 Samia Al Rahmani. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Movie : NSManagedObject

@property (nonatomic, retain) NSString * poster;
@property (nonatomic, retain) NSString * synopsis;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSSet *showtimes;
@property (nonatomic, retain) NSSet *theatres;
@end

@interface Movie (CoreDataGeneratedAccessors)

- (void)addShowtimesObject:(NSManagedObject *)value;
- (void)removeShowtimesObject:(NSManagedObject *)value;
- (void)addShowtimes:(NSSet *)values;
- (void)removeShowtimes:(NSSet *)values;

- (void)addTheatresObject:(NSManagedObject *)value;
- (void)removeTheatresObject:(NSManagedObject *)value;
- (void)addTheatres:(NSSet *)values;
- (void)removeTheatres:(NSSet *)values;

@end
