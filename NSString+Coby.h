#import <Foundation/Foundation.h>

@interface NSString (Coby)
// If length is greater than the length of `self`, returns a
// new `NSString` of length `length` with `self` centered
// and padded with `paddedString` otherwise, returns `self`.
- (NSString *)center:(NSInteger)length;
- (NSString *)center:(NSInteger)length withPaddedString:(NSString*)paddedString;
@end
