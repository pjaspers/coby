#import "NSArray+Coby.h"

@implementation NSArray (Coby)

// # Access
//
// Returns the tail of the array, returns an empty array if the
// subarray is out of range.
//
//      NSArray *r = [NSArray arrayWithObjects:@"1", "@2", "@3", nil];
//      [r from:0]; => [@"1", @"2", @"3"]
//      [r from:10]; => []
//
- (NSArray *)from:(NSUInteger)position {
  if( position >= [self count]) return [NSArray array];

  return [self subarrayWithRange:NSMakeRange(position, [self count] - position)];
}

- (NSArray *)to:(NSUInteger)position {
  return [self first:(position + 1)];
}

// Returns the first `n` elements, if it's empty return an empty
// `NSArray`
- (NSArray *)first:(NSUInteger)numberOfElements {
  if([self count] == 0) return [NSArray array];

  if( numberOfElements >= [self count]) numberOfElements = [self count];
  return [self subarrayWithRange:NSMakeRange(0, numberOfElements)];
}

// These pretty much describe themselves. They just add some
// handy accessors to your arrays without needing to check indices
//
//      NSArray *r = [NSArray arrayWithObjects:@"1", "@2", "@3", nil];
//      [r first] => @"3"
//      [r third] => @"3"
//      [r fourth] => nil
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

// # Manipulation
//
//
//      NSArray *r = [NSArray arrayWithObjects:@"1", @"2", nil];
//      [r join] => @"12"
-(NSString *)join {
  return [self componentsJoinedByString:@""];
}

// Only added because join reads much easier than
// `componentsJoinedByString`, and I keep forgetting the
// latter.
-(NSString *)join:(NSString *)seperator {
  return [self componentsJoinedByString:seperator];
}

// Inspired by [MACollectionUtilities](https://github.com/mikeash/MACollectionUtilities/blob/master/MACollectionUtilities.m)
// But ditched the prefixed naming scheme, since I don't
// really see the point in doing so.
//
// For example `select` could clash with the `select` for
// `NSObject` (in UIResponders) however, if those two clash
// you have a bigger problem than calling it on an array imho.
//
// So no prefixing, in favor of simpler method names.


// Invokes the block once for each element of self, replacing the
// element with the value returned by block.
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

// Invokes the block passing in successive elements from self,
// returning an array containing those elements for which the block
// returns a true value.
- (NSArray *)select: (BOOL (^)(id obj))block {
  NSMutableArray *array = [NSMutableArray array];
  for(id obj in self)
    if(block(obj))
      [array addObject: obj];
  return array;
}

// Passes each element of the collection to the given block. The
// method returns true if the block never returns false or nil.
- (BOOL)all: (BOOL (^)(id obj))block {
    BOOL match = YES;
    for(id obj in self)
        if(!block(obj))
            match = NO;
    return match;
}

// Returns a new array by removing duplicate values in self.
- (NSArray*)uniq {
    return [[NSSet setWithArray:self] allObjects];
}

// Returns an `NSArray` containing two arrays, the first containing
// the elements of self for which the block evaluates to true,
// the second containing the rest.

- (NSArray*)partition:(BOOL (^)(id obj))block {
    NSMutableArray *yes = [NSMutableArray array];
    NSMutableArray *no = [NSMutableArray array];
    for(id obj in self)
        [(block(obj) ? yes : no) addObject: obj];
    return [NSArray arrayWithObjects:yes, no, nil];
}

// Passes each element of the array to the given block. The
// method returns true if the block ever returns a value
// other than false or nil.
- (BOOL)any:(BOOL (^)(id obj))block {
    for(id obj in self)
        if (block(obj)) return YES;
    return NO;
}

// Passes each entry in self to block. Returns the first
// for which block is not false. If no object matches returns nil.
- (id)detect:(BOOL (^)(id obj))block {
    for(id obj in self)
        if (block(obj)) return obj;
    return nil;
}

// Returns first n elements from self
- (NSArray *)take:(int)limit {
    if (limit >= self.count) return self;
    if (limit == 0) return [NSArray array];

    NSMutableArray *array = [NSMutableArray array];
    for (int i=0; i<limit; i++) {
        [array addObject:[self objectAtIndex:i]];
    }
    return array;
}
@end
