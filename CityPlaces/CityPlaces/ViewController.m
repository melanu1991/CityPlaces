#import "ViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "VAKMyAnnotation.h"

@interface ViewController () <MKMapViewDelegate, CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *location;

@end

@implementation ViewController

#pragma mark - life cycle view controller

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mapView.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self checkLocationAuthorizationStatus];
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
}

#pragma mark - helpers

- (void)checkLocationAuthorizationStatus {
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    if (CLLocationManager.authorizationStatus == kCLAuthorizationStatusAuthorizedWhenInUse) {
        [self.mapView showsUserLocation];
    }
    else {
        [self.locationManager requestWhenInUseAuthorization];
    }
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.distanceFilter = 1;
    self.mapView.showsUserLocation = YES;
    [self.locationManager startUpdatingLocation];
}

#pragma mark - Actions

- (IBAction)switchBetweenTypesMap:(UIBarButtonItem *)sender {
    self.mapView.mapType = sender.tag;
}

- (IBAction)userLocation:(UIBarButtonItem *)sender {
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(self.mapView.userLocation.coordinate, 100000, 100000);
    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
}

@end
