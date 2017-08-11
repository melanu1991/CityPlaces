#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface VAKMyAnnotation : NSObject <MKAnnotation>

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

@property (nonatomic, readonly, copy, nullable) NSString *title;
@property (nonatomic, readonly, copy, nullable) NSString *subtitle;
@property (nonatomic, readonly, copy, nullable) NSString *info;

@property (nonatomic, unsafe_unretained) MKPinAnnotationColor pinColor;

+ (NSString *_Nullable)reusableIdentifierForPinColor:(MKPinAnnotationColor)paramColor;

- (instancetype _Nullable )initWithCoordinates:(CLLocationCoordinate2D)paramCoordinates title:(NSString *_Nullable)paramTitle subtitle:(NSString *_Nullable)paramSubtitle info:(NSString *_Nullable)info;

@end
