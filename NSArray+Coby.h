@interface NSArray (Coby)
- (NSString *)join:(NSString *)seperator;
- (NSArray *)map: (id (^)(id obj))block;
- (void)each: (void (^)(id obj))block;
- (NSArray *)select: (BOOL (^)(id obj))block;
- (BOOL)all: (BOOL (^)(id obj))block;
- (NSArray*)uniq;

@end
