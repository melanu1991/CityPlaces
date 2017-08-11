#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface VAKMyAnnotation : NSObject <MKAnnotation>

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

@property (nonatomic, readonly, copy, nullable) NSString *title;
@property (nonatomic, readonly, copy, nullable) NSString *subtitle;

- (instancetype _Nullable )initWithCoordinates:(CLLocationCoordinate2D)paramCoordinates title:(NSString *_Nullable)paramTitle subtitle:(NSString *_Nullable)paramSubtitle;

@end
