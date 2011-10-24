@interface NSObject (Coby)
- (id)try:(NSString *)method;
- (id)try:(NSString *)method with:(id)object;
+ (void)benchmark: (void (^)())block;
@end
