#import "NSString+Coby.h"

@implementation NSString (Coby)
- (NSString *)center:(NSInteger)length {
  return [self center:length withPaddedString:@" "];
}

- (NSString *)center:(NSInteger)length withPaddedString:(NSString*)paddedString {
  if ([self length] >= length) return self;

  NSInteger leftPadding = (length - [self length]) / 2;
  NSInteger rightPadding = length - [self length] - leftPadding;
  NSMutableString *aString = [NSMutableString stringWithCapacity:length];

  for(int i = 0; i < leftPadding; i++)
    [aString appendString:paddedString];
  [aString appendString:self];
  for(int i = 0; i < rightPadding; i++)
    [aString appendString:paddedString];

  return [NSString stringWithString:aString];
}

- (NSUInteger)index:(NSString *)subString {
  return [self index:subString startingAt:0];
}

- (NSUInteger)index:(NSString *)subString startingAt:(NSUInteger)startingIndex {
  if (startingIndex > [self length]) return -1;
  NSRange startingRange = NSMakeRange(startingIndex, [self length] - startingIndex);
  NSRange aRange = [self rangeOfString:subString options:0 range:startingRange];

  if (aRange.location == NSNotFound) return -1;
  return aRange.location;
}

- (NSString *)reverse {
  if ([self length] <= 1) return self;

  NSInteger charsRemaining = [self length] - 1;
	NSMutableString *reversedString = [NSMutableString stringWithCapacity:[self length]];
	while (charsRemaining >= 0) {
		NSRange range = [self rangeOfComposedCharacterSequenceAtIndex:charsRemaining];
		[reversedString appendString:[self substringWithRange:range]];
		charsRemaining -= range.length;
	}
	return [NSString stringWithString:reversedString];
}

@end
