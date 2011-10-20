#import <Foundation/Foundation.h>
#import "NSDictionary+Coby.h"

@implementation NSDictionary (Coby)

// Calls block once for each key in the dictionary, passing the
// key-value pair as parameters.
- (void)each: (void (^)(id key, id value))block {
  [self enumerateKeysAndObjectsUsingBlock: ^(id key, id obj, BOOL *stop) {
      block(key, obj);
    }];
}

// Returns a new dictionary containing the contents of
// `otherDictionary` and the contents of itself.
//
// The value for each duplicate key will be the value of the key
// found in `otherDictionary`.
- (NSDictionary *)merge:(NSDictionary *)otherDictionary {
  NSMutableDictionary * result = [NSMutableDictionary dictionaryWithDictionary:self];

  [otherDictionary each: ^(id key, id obj) {
        [result setObject:obj forKey:key];
    }];
  return (NSDictionary *) [[result mutableCopy] autorelease];
}

// The value for each duplicate key is determined by calling the
// block with the key, its value in hsh and its value in other_hash.
//
//       dict1 = [NSDictionary dictionaryWithObjectsAndKeys:
//                 @"a value", @"a",
//                 @"b value", @"b",nil];
//       dict2 = [NSDictionary dictionaryWithObjectsAndKeys:
//                 @"c value", @"c",
//                 @"newer value", @"b",nil];
//
//      [dict1 merge:dict2 withBlock:^(id key, id old, id new){
//        return [NSString stringWithFormat:@"%@ - %@",
//                 oldValue, newValue];
//      }];
//
//      => {"a" => @"a value", "b" => @"b value - newer value", "c" => @"c value"}
- (NSDictionary *)merge:(NSDictionary *)otherDictionary withBlock:(id (^)(NSString *key, id oldValue, id newValue))block {
  NSMutableDictionary * result = [NSMutableDictionary dictionaryWithDictionary:self];

  [otherDictionary each: ^(id key, id obj) {
      if ([self fetch:key]) {
        id object = block(key, [self fetch:key], obj);
        [result setObject:object forKey:key];
      } else {
        [result setObject:obj forKey:key];
      }
    }];
  return (NSDictionary *) [[result mutableCopy] autorelease];
}

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
