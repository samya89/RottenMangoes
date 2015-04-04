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
#import "Movie.h"

@interface MapViewController ()

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, copy) NSString *postalCode;
@property (nonatomic, strong) CLLocation *userLocation;

@end

@implementation MapViewController

- (void)setDetailItem:(Movie *)newMovie{
    if (_movie != newMovie) {
        _movie = newMovie;
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    
    _theatreMapView.delegate = self;
    _locationManager.delegate = self;
    
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
    
    if (!self.userLocation) {
        self.userLocation = [locations firstObject];
        [Geocoder getAddressFromLocation:self.userLocation withCallback:^(NSArray *placemarks, NSError *error) {
            NSLog(@"Placemarks = %@", placemarks);
            
            if (placemarks) {
                CLPlacemark *placemark = [placemarks firstObject];
                self.postalCode = [placemark.postalCode substringToIndex:3];
                NSLog(@"Postal code = %@", self.postalCode);
                
                
                NSURL *theatreURL = [self createTheatreURLWithPostalCode:self.postalCode withMovieName:@"Paddington"/*self.movie.title*/];
                NSLog(@"theatreURL %@", theatreURL);
                
                NSData *theatreData = [self getTheatreWithDataURL:theatreURL];
                self.theatres = [self buildTheatreArrayWithData:theatreData];
                
                NSLog(@"theatre array %@", self.theatres);
            }
        }];
    }
    [self drawPins:self.theatres];
    
    NSLog(@"New Location Update %@", [locations firstObject]);
    
    // get user's current location's postal code 
}

- (void)drawPins:(NSArray *)theatres {
    
    for (Theatre *theatre in theatres) {
//        NSLog(@"Theatre name: %@", theatre.theatreName);
//        NSLog(@"Longitude: %f", theatre.longitude);
//        NSLog(@"Latitude: %f", theatre.latitude);
//        
//        CLLocationCoordinate2D theatreLocation;
//        theatreLocation.latitude = theatre.latitude;
//        theatreLocation.longitude = theatre.longitude;
//        
//        MKPointAnnotation *theatreMarker=[[MKPointAnnotation alloc] init];
//        theatreMarker.coordinate = theatreLocation;
//        theatreMarker.title = theatre.theatreName;
        
//        [self.theatreMapView addAnnotation:theatreMarker];
    }
}


- (NSURL *)createTheatreURLWithPostalCode:(NSString *)postalCode withMovieName:(NSString *)movieName{
    
    NSString *baseURLString = @"http://lighthouse-movie-showtimes.herokuapp.com/theatres.json";
    NSString *postalCodeParam = [NSString stringWithFormat:@"address=%@", postalCode];
    NSString *movieNameParam = [NSString stringWithFormat:@"movie=%@", movieName];
    
    NSString *finalURL = [NSString stringWithFormat:@"%@?%@&%@", baseURLString, postalCodeParam, movieNameParam];
    
    NSURL *theatreURL = [NSURL URLWithString:finalURL];
    
    return theatreURL;
}

- (NSData *)getTheatreWithDataURL:(NSURL *)theatreURL {
    NSData *theatreData = [NSData dataWithContentsOfURL:theatreURL];
    return theatreData;
}

- (NSArray *)buildTheatreArrayWithData:(NSData *)data{
    NSError *error = nil;
    
    NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    
    NSLog(@"Theatre data dictionary %@", dataDictionary);
    
    NSMutableArray *newTheatreArray = [NSMutableArray array];

    NSMutableArray *theatreArrayFromData = [dataDictionary objectForKey:@"theatres"];
    
    for (NSDictionary *theatreDictionary in theatreArrayFromData) {
        
//        Theatre *theatre = [[Theatre alloc]initWithDictionary:theatreDictionary];
            [newTheatreArray addObject:@"Theatre"];
    }
    return [NSArray arrayWithArray:newTheatreArray];
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
