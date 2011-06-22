@interface NSDictionary (Coby)
- (id)fetch:(NSString *)key;
- (id)fetch:(NSString *)key default:(NSString *)defaultValue;
@end

@interface NSMutableDictionary (Coby)
- (void)set:(id)object for:(NSString *)key;
@end
