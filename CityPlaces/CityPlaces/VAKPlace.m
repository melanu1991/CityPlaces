#import "VAKPlace.h"

@implementation VAKPlace

+ (VAKPlace *)initFromJSON:(NSArray *)json {
    VAKPlace *place = [[super alloc] init];
    place.title = [NSString stringWithFormat:@"%@", json[16]];
    place.subtitle = [NSString stringWithFormat:@"%@", json[12]];
    place.latitude = [NSString stringWithFormat:@"%@", json[18]];
    place.longitude = [NSString stringWithFormat:@"%@", json[19]];
    place.info = [NSString stringWithFormat:@"%@", json[11]];
    return place;
}

@end
