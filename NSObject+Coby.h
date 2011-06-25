@interface NSObject (Coby)
- (BOOL)isEmpty;
- (id)try:(NSString *)method;
- (id)try:(NSString *)method with:(id)object;
+ (void)benchmark: (void (^)())block;
@end
