#import <Foundation/Foundation.h>

@interface NSString (Coby)
// If length is greater than the length of `self`, returns a
// new `NSString` of length `length` with `self` centered
// and padded with `paddedString` otherwise, returns `self`.
- (NSString *)center:(NSInteger)length;
- (NSString *)center:(NSInteger)length withPaddedString:(NSString*)paddedString;

// Returns the index of the first occurrence of the given
// substring or in `self`. Returns `-1` if not found.
// If the second parameter is present, it specifies the
// position in the string to begin the search.
- (NSUInteger)index:(NSString *)subString;
- (NSUInteger)index:(NSString *)subString startingAt:(NSUInteger)startingIndex;

// Returns a new string with the characters from str in reverse order.
- (NSString *)reverse;
@end
