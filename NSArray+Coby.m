#import "NSArray+Coby.h"

@implementation NSArray (Coby)

-(NSString *)join:(NSString *)seperator {
  return [self componentsJoinedByString:seperator];
}

// Inspired by https://github.com/mikeash/MACollectionUtilities/blob/master/MACollectionUtilities.m
// But ditched the prefixed naming scheme, since I don't really see the point in
// doing so.
//
// For example `select` could clash with the `select` for `NSObject` (in UIResponders)
// however, if those two clash you have a bigger problem than calling it on an array.
// So no prefixing, in favor of simpler method names.

- (NSArray *)map: (id (^)(id obj))block {
  NSMutableArray *array = [NSMutableArray arrayWithCapacity: [self count]];
  for(id obj in self)
    [array addObject: block(obj)];
  return array;
}

- (void)each: (void (^)(id obj))block {
  for(id obj in self)
    block(obj);
}

- (NSArray *)select: (BOOL (^)(id obj))block {
  NSMutableArray *array = [NSMutableArray array];
  for(id obj in self)
    if(block(obj))
      [array addObject: obj];
  return array;
}

- (BOOL)all: (BOOL (^)(id obj))block {
    BOOL match = YES;
    for(id obj in self)
        if(!block(obj))
            match = NO;
    return match;
}

- (NSArray*)uniq {
    return [[NSSet setWithArray:self] allObjects];
}

@end
