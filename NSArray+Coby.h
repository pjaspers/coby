#import <Foundation/Foundation.h>

@interface NSArray (Coby)
- (NSArray *)from:(NSUInteger)position;
- (NSArray *)to:(NSUInteger)position;
- (NSArray *)first:(NSUInteger)numberOfElements;
- (id)first;
- (id)second;
- (id)third;
- (id)fourth;
- (id)fifth;
- (id)fortyTwo;
- (id)CB_safeObjectAtIndex:(NSUInteger)index;

- (NSString *)join:(NSString *)seperator;
- (NSArray *)map: (id (^)(id obj))block;
- (void)each: (void (^)(id obj))block;
- (NSArray *)select: (BOOL (^)(id obj))block;
- (BOOL)all: (BOOL (^)(id obj))block;
@end
