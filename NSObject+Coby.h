@interface NSObject (Coby)
- (id)send:(NSString *)method;
- (id)send:(NSString *)method with:(id)object;
- (id)try:(NSString *)method;
- (id)try:(NSString *)method with:(id)object;
- (id)try:(NSString *)method default:(id)object;
- (id)try:(NSString *)method with:(id)object default:(id)returnObject;
- (id)tap:(void (^)(id obj))block;
+ (void)benchmark: (void (^)())block;
@end
