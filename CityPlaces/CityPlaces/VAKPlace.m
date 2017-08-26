#import "VAKPlace.h"

@implementation VAKPlace

+ (VAKPlace *)initPlaceWithData:(NSArray *)data {
    VAKPlace *place = [[super alloc] init];
    place.title = [NSString stringWithFormat:@"%@", data[16]];
    place.subtitle = [NSString stringWithFormat:@"%@", data[12]];
    place.latitude = [NSString stringWithFormat:@"%@", data[18]];
    place.longitude = [NSString stringWithFormat:@"%@", data[19]];
    place.info = [NSString stringWithFormat:@"%@", data[11]];
    return place;
}

@end
