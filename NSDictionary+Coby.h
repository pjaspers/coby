#import <Foundation/Foundation.h>

@interface NSDictionary (Coby)
- (id)fetch:(NSString *)key;
- (id)fetch:(NSString *)key default:(id)defaultValue;
- (id)fetch:(NSString *)key withBlock:(id (^)(id keyOrValue))block;

- (NSDictionary *)merge:(NSDictionary *)otherDictionary;
- (NSDictionary *)merge:(NSDictionary *)otherDictionary withBlock:(id (^)(NSString *key, id oldValue, id newValue))block;
@end

@interface NSMutableDictionary (Coby)
- (void)set:(id)object for:(NSString *)key;
@end
