@interface NSObject (Coby)
- (id)try:(NSString *)method;
- (id)try:(NSString *)method with:(id)object;
- (id)try:(NSString *)method default:(id)object;
- (id)try:(NSString *)method with:(id)object default:(id)returnObject;
+ (void)benchmark: (void (^)())block;
@end
