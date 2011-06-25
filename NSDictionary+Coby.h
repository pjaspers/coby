@interface NSDictionary (Coby)
- (id)fetch:(NSString *)key;
- (id)fetch:(NSString *)key default:(id)defaultValue;
@end

@interface NSMutableDictionary (Coby)
- (void)set:(id)object for:(NSString *)key;
@end
