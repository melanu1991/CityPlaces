#import "VAKMyAnnotation.h"

static NSString * const kReusablePinRed = @"Red";
static NSString * const kReusablePinGreen = @"Green";
static NSString * const kReusablePinPurple = @"Purple";

@implementation VAKMyAnnotation

+ (NSString *)reusableIdentifierForPinColor:(MKPinAnnotationColor)paramColor {
    NSString *result = nil;
    switch (paramColor) {
        case MKPinAnnotationColorRed:
            result = kReusablePinRed;
            break;
        case MKPinAnnotationColorGreen:
            result = kReusablePinGreen;
            break;
        case MKPinAnnotationColorPurple:
            result = kReusablePinPurple;
            break;
        default:
            break;
    }
    return result;
}

- (instancetype)initWithCoordinates:(CLLocationCoordinate2D)paramCoordinates title:(NSString *)paramTitle subtitle:(NSString *)paramSubtitle info:(NSString * _Nullable)info {
    self = [super init];
    if (self) {
        _coordinate = paramCoordinates;
        _title = paramTitle;
        _subtitle = paramSubtitle;
        _pinColor = MKPinAnnotationColorGreen;
        _info = info;
    }
    return self;
}

@end
