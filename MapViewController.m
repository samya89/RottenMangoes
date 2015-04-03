//
//  MapViewController.m
//  RottenMangoes
//
//  Created by Samia Al Rahmani on 4/2/15.
//  Copyright (c) 2015 Samia Al Rahmani. All rights reserved.
//

#import "MapViewController.h"
#import "Theatre.h"
#import "Geocoder.h"

@interface MapViewController ()

@property (nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _theatreMapView.delegate = self;
    _locationManager.delegate = self;
    _locationManager = [[CLLocationManager alloc] init];
    [_locationManager requestWhenInUseAuthorization];
    [_locationManager startUpdatingLocation];
    
    self.theatreMapView.showsUserLocation =true;
    
    MKCoordinateRegion startingRegion;
    CLLocationCoordinate2D loc = _locationManager.location.coordinate;
    startingRegion.center = loc;
    startingRegion.span.latitudeDelta = 0.02;
    startingRegion.span.longitudeDelta = 0.02;
    
    MKPointAnnotation *currentLocationMarker=[[MKPointAnnotation alloc] init];
    CLLocationCoordinate2D launchAcademyLocation;
    launchAcademyLocation.latitude = 49.282980;
    launchAcademyLocation.longitude = -123.110454;
    currentLocationMarker.coordinate = launchAcademyLocation;
    currentLocationMarker.title = @"Your Current Location";
    
    [self.theatreMapView addAnnotation:currentLocationMarker];
    [self.theatreMapView setRegion:startingRegion];
    
    //JSON http://lighthouse-movie-showtimes.herokuapp.com/theatres.json?address=V5T&movie=Paddington
    
    // get postal code as nsstring
    // get movie name as nsstring
    
    // create the query
    // 1. append '?' address=
    
    NSURL *theatreURL = [NSURL URLWithString:@"http://lighthouse-movie-showtimes.herokuapp.com/theatres.json[query goes here]"];
    
    NSData *jsonData = [NSData dataWithContentsOfURL:theatreURL];

    NSError *error = nil;

    NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];

    NSLog(@"JSON %@", dataDictionary);

    self.theatres = [NSMutableArray array];

    NSMutableArray *theatreArray = [dataDictionary objectForKey:@"theatres"];

    for (NSDictionary *theatreDictionary in theatreArray) {

        Theatre *theatre = [[Theatre alloc]initWithDictionary:theatreDictionary];

        [self.theatres addObject:theatre];
    }
}


- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    
    if (status == kCLAuthorizationStatusAuthorizedWhenInUse){
        NSLog(@"Location authorized");
    } else if (status == kCLAuthorizationStatusDenied ){
        NSLog(@"You have not authorized Rotten Mangoes to access your location");
    }
}


- (MKAnnotationView *)mapView:(MKMapView *)theMapView viewForAnnotation:(id <MKAnnotation>)_annotation{

    if (_annotation == self.theatreMapView.userLocation){
        return nil; //default to blue dot
    }
    
    static NSString* annotationIdentifier = @"ianAnnotation";
    
    MKPinAnnotationView* pinView = (MKPinAnnotationView *)
    [self.theatreMapView dequeueReusableAnnotationViewWithIdentifier:annotationIdentifier];
    
    if (!pinView) {
        // if an existing pin view was not available, create one
        pinView = [[MKPinAnnotationView alloc]
                   initWithAnnotation:_annotation reuseIdentifier:annotationIdentifier];
    }
    
    pinView.canShowCallout = YES;
    pinView.pinColor = MKPinAnnotationColorGreen;
    //pinView.calloutOffset = CGPointMake(-7, 0);
    
    return pinView;
}


-(void)locationManager:(CLLocationManager *)manager
    didUpdateLocations:(NSArray *)locations{
    NSLog(@"New Location Update %@", [locations firstObject]);
    
    // get user's current location's postal code 
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
