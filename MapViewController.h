//
//  MapViewController.h
//  RottenMangoes
//
//  Created by Samia Al Rahmani on 4/2/15.
//  Copyright (c) 2015 Samia Al Rahmani. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreData/CoreData.h>
@class Movie;

@interface MapViewController : UIViewController<MKMapViewDelegate, CLLocationManagerDelegate>

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (weak, nonatomic) IBOutlet MKMapView *theatreMapView;
@property (strong, nonatomic) NSArray *theatres;
@property (nonatomic, readonly, copy) NSString *postalCode;

@property (nonatomic, strong) Movie *movie;
- (void)setDetailItem:(Movie *)newMovie;



@end
