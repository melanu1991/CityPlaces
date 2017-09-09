#import <Foundation/Foundation.h>

@interface VAKPlace : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *subtitle;
@property (strong, nonatomic) NSString *info;
@property (strong, nonatomic) NSString *latitude;
@property (strong, nonatomic) NSString *longitude;

+ (VAKPlace *)placeWithData:(NSArray *)data;

@end
