#import "NSArray+Coby.h"

@implementation NSArray (Coby)

// # Access

// Returns the tail of the array, returns an empty array if the subarray
// is out of range.
//
//      NSArray *anArray = [NSArray arrayWithObjects:@"One", "@Two", "@Three"];
//      [anArray from:0]; => [@"One", @"Two", @"Three"]
//      [anArray from:10]; => []
//
- (NSArray *)from:(NSUInteger)position {
  if( position >= [self count]) return [NSArray array];

  return [self subarrayWithRange:NSMakeRange(position, [self count] - position)];
}

- (NSArray *)to:(NSUInteger)position {
  return [self first:(position + 1)];
}

// Returns the first `n` elements, if it's empty return an empty `NSArray`
- (NSArray *)first:(NSUInteger)numberOfElements {
  if([self count] == 0) return [NSArray array];

  if( numberOfElements >= [self count]) numberOfElements = [self count];
  return [self subarrayWithRange:NSMakeRange(0, numberOfElements)];
}

// These pretty much describe themselves. They just add some
// handy accessors to your arrays without needing to check indices
//
//      NSArray *anArray = [NSArray arrayWithObjects:@"One", "@Two", "@Three"];
//      [anArray first] => @"One"
//      [anArray third] => @"Three"
//      [anArray fourth] => nil
//
- (id)first {
  return [self CB_safeObjectAtIndex:0];
}

- (id)second {
  return [self CB_safeObjectAtIndex:1];
}

- (id)third {
  return [self CB_safeObjectAtIndex:2];
}

- (id)fourth {
  return [self CB_safeObjectAtIndex:3];
}

- (id)fifth {
  return [self CB_safeObjectAtIndex:4];
}

- (id)fortyTwo {
  return [self CB_safeObjectAtIndex:41];
}

// Don't use it. Except when needed, or wanted.
- (id)CB_safeObjectAtIndex:(NSUInteger)index {
  if([self count] < index) return nil;

  return [self objectAtIndex:index];
}

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
