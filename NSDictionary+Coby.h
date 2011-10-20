#import <Foundation/Foundation.h>

@interface NSDictionary (Coby)
- (id)fetch:(NSString *)key;
- (id)fetch:(NSString *)key default:(id)defaultValue;
- (id)fetch:(NSString *)key withBlock:(id (^)(id keyOrValue))block;
@end

@interface NSMutableDictionary (Coby)
- (void)set:(id)object for:(NSString *)key;
@end
