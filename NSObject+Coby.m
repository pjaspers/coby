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
    if (![self respondsToSelector:NSSelectorFromString(method)]) return nil;

    return [self performSelector:NSSelectorFromString(method) withObject:nil];
}

// Quick way to "benchmark" a block of code, will log the number
// of seconds the block took to execute.
+ (void)benchmark: (void (^)())block {
	NSDate *startingDate = [NSDate date];
    block();
	NSLog(@"%f",[[NSDate date] timeIntervalSinceDate:startingDate]);
}

@end
