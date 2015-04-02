//
//  MapViewController.m
//  RottenMangoes
//
//  Created by Samia Al Rahmani on 4/2/15.
//  Copyright (c) 2015 Samia Al Rahmani. All rights reserved.
//

#import "MapViewController.h"

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
    
//    MKPointAnnotation *apartmentMarker=[[MKPointAnnotation alloc] init];
//    CLLocationCoordinate2D iansApartmentLocation;
//    iansApartmentLocation.latitude = 49.2689754;
//    iansApartmentLocation.longitude = -123.153034;
//    apartmentMarker.coordinate = iansApartmentLocation;
//    apartmentMarker.title = @"Your Current Location";
//    
    MKPointAnnotation *currentLocationMarker=[[MKPointAnnotation alloc] init];
    CLLocationCoordinate2D launchAcademyLocation;
    launchAcademyLocation.latitude = 49.2816252;
    launchAcademyLocation.longitude = -123.1091366;
    currentLocationMarker.coordinate = launchAcademyLocation;
    currentLocationMarker.title = @"Your Current Location";
    
//    [self.theatreMapView addAnnotation:apartmentMarker];
    [self.theatreMapView addAnnotation:currentLocationMarker];
    
    [self.theatreMapView setRegion:startingRegion];

}


- (void)locationManager:(CLLocationManager *)manager
didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    
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
