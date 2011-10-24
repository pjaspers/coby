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
@end
