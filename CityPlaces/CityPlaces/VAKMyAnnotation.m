#import "VAKMyAnnotation.h"

@implementation VAKMyAnnotation

- (instancetype)initWithCoordinates:(CLLocationCoordinate2D)paramCoordinates title:(NSString *)paramTitle subtitle:(NSString *)paramSubtitle {
    self = [super init];
    if (self) {
        _coordinate = paramCoordinates;
        _title = paramTitle;
        _subtitle = paramSubtitle;
    }
    return self;
}

@end
