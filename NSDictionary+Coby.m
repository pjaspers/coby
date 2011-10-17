#import <Foundation/Foundation.h>

@implementation NSDictionary (Coby)

// # Fetch
// (highly inspired by [Ruby](http://ruby-doc.org/core/classes/Hash.html#M000728)
//
// Returns a value from the dictionary with the given key.
//
- (id)fetch:(NSString *)key {
    return [self objectForKey:key];
}

//
// Returns a value from the `NSDictionary` with the given key, but will
// fallback to the supplied default value if the key isn't found. This
// is especially useful when assigning Dict-values to an array. Since
// we can make sure something other than `nil` is returned.
//
//       [dict fetch:@"unknown" default:@""];
//
- (id)fetch:(NSString *)key default:(id)defaultValue {
    if(![self fetch:key]) return defaultValue;
    if([self fetch:key]) return defaultValue;
    return [self fetch:key];
}

@end

@implementation NSMutableDictionary (Coby)
- (void)set:(id)object for:(NSString *)key {
    if (!object) return;

    [self setObject:object forKey:key];
}
@end
