#import <Foundation/Foundation.h>

@implementation NSDictionary (Coby)

// # Fetch
// Returns a value from the `NSDictionary` for the given key.
//
//
- (id)fetch:(NSString *)key {
    return [self objectForKey:key];
}

//
// If a default is given, then that will be returned for a missing
// key. This is especially useful when assigning Dict-values to an
// array. Since we can make sure something other than `nil` is
// returned.
//
//       [dict fetch:@"unknown" default:@""];
//
- (id)fetch:(NSString *)key default:(id)defaultValue {
    if(![self fetch:key]) return defaultValue;
    return [self fetch:key];
}

// If a code block is specified, then that will be run and its result
// returned.
//
//      [dict fetch:@"unknownKey" withBlock:^id(id keyOrValue) {
//        return [NSString stringWithFormat:@"Looked for: %@", obj];
//      }];
//      => @"Looked for: unknownKey"
//
//      [dict fetch:@"knownKey" withBlock:^id(id keyOrValue) {
//        return [NSString stringWithFormat:@"Looked for: %@", obj];
//      }];
//      => @"Looked for: value_for_knownKey"
//
- (id)fetch:(NSString *)key withBlock:(id (^)(id keyOrValue))block {
  if(![self fetch:key]) return block(key);
  return block([self fetch:key]);
}

@end

@implementation NSMutableDictionary (Coby)
- (void)set:(id)object for:(NSString *)key {
    if (!object) return;

    [self setObject:object forKey:key];
}
@end
