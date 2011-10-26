#import <Foundation/Foundation.h>
#import "NSObject+Coby.h"


@implementation NSObject (Coby)

// # Try
// (highly inspired by [Rails](http://api.rubyonrails.org/classes/Object.html#method-i-try)
//
// Invokes the method identified by the string `method`, just like
// `performSelector` except this will just return nil if the object
// does not respond to the method.
//
//       [Person try:@"name"];
//
- (id)try:(NSString *)method {
    return [self try:method with:nil];
}

// Invokes the method identified by the string `method`, just like
// `performSelector` except this will just return nil if the object
// does not respond to the method. It will pass the object to the method.
//
//       [Person try:@"find" with:@"Jake"   ];
//
- (id)try:(NSString *)method with:(id)object{
  return [self try:method with:object default:nil];
}

- (id)try:(NSString *)method default:(id)object{
  return [self try:method with:nil default:object];
}

- (id)try:(NSString *)method with:(id)object default:(id)returnObject {
  if (![self respondsToSelector:NSSelectorFromString(method)]) return returnObject;

  id result = [self performSelector:NSSelectorFromString(method) withObject:object];
  if (result) return result;
  return returnObject;
}

// Quick way to "benchmark" a block of code, will log the number
// of seconds the block took to execute.
+ (void)benchmark: (void (^)())block {
	NSDate *startingDate = [NSDate date];
    block();
	NSLog(@"%f",[[NSDate date] timeIntervalSinceDate:startingDate]);
}

@end
