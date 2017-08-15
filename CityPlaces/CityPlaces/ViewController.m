#import "ViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "VAKMyAnnotation.h"
#import "VAKPlace.h"

@interface ViewController () <MKMapViewDelegate, CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *location;
@property (strong, nonatomic) NSMutableArray *annotations;

@end

@implementation ViewController

#pragma mark - lazy getters

- (NSMutableArray *)annotations {
    if (!_annotations) {
        _annotations = [NSMutableArray array];
    }
    return _annotations;
}

#pragma mark - life cycle view controller

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mapView.delegate = self;
    [self loadData];
    [self.mapView addAnnotations:self.annotations];
    [self zoomRegionAnnotations];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self checkLocationAuthorizationStatus];
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
}

#pragma mark - MKMapViewDelegate

- (nullable MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    MKAnnotationView *result = nil;
    if (![annotation isKindOfClass:[VAKMyAnnotation class]]) {
        return result;
    }
    VAKMyAnnotation *senderAnnotation = (VAKMyAnnotation *)annotation;
    NSString *pinReusableIdentifier = [VAKMyAnnotation reusableIdentifierForPinColor:senderAnnotation.pinColor];
    MKPinAnnotationView *annotationView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:pinReusableIdentifier];
    if (!annotationView) {
        annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:senderAnnotation reuseIdentifier:pinReusableIdentifier];
        UIButton *descriptionButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        annotationView.rightCalloutAccessoryView = descriptionButton;
        [annotationView setCanShowCallout:YES];
    }
    annotationView.pinColor = senderAnnotation.pinColor;
    result = annotationView;
    return result;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    VAKMyAnnotation *selectedAnnotation = (VAKMyAnnotation *)view.annotation;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"Info about %@", selectedAnnotation.title] message:selectedAnnotation.info preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - helpers

- (void)zoomRegionAnnotations {
    MKMapRect zoomRect = MKMapRectNull;
    for (id<MKAnnotation> annotation in self.mapView.annotations) {
        CLLocationCoordinate2D location = annotation.coordinate;
        MKMapPoint center = MKMapPointForCoordinate(location);
        static double delta = 2000;
        MKMapRect rect = MKMapRectMake(center.x - delta, center.y - delta, delta * 2, delta * 2);
        zoomRect = MKMapRectUnion(zoomRect, rect);
    }
    zoomRect = [self.mapView mapRectThatFits:zoomRect];
    [self.mapView setVisibleMapRect:zoomRect edgePadding:UIEdgeInsetsMake(100, 100, 100, 100) animated:YES];
}

- (void)addAnnotationFromJSON:(NSArray *)json {
    VAKPlace *place = [VAKPlace initFromJSON:json];
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(place.latitude.doubleValue, place.longitude.doubleValue);
    VAKMyAnnotation *annotation = [[VAKMyAnnotation alloc] initWithCoordinates:coordinate title:place.title subtitle:place.subtitle info:place.info];
    [self.annotations addObject:annotation];
}

- (void)loadData {
    NSString *fileName = [[NSBundle mainBundle] pathForResource:@"PublicArt" ofType:@"json"];
    NSError *error = nil;
    NSData *data = [NSData dataWithContentsOfFile:fileName options:0 error:&error];
    if (!error) {
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        if (!error) {
            NSArray *arrayObjects = [json objectForKey:@"data"];
            for (NSArray *object in arrayObjects) {
                [self addAnnotationFromJSON:object];
            }
        }
    }
}

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
