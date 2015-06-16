

@interface UITextView (DTTextView)


// <act type="at" name="好人" id="sdfss">aa</act>
- (void)addAt:(NSString*)name withId:(NSString*)id;
- (void)replaceWithAt:(NSString*)name withId:(NSString*)id;

- (void)addEmotion:(NSString *)type;
- (void)replaceWithEmotion:(NSString *)type;


- (NSString*)getHtmlStr;
- (NSArray*)atUserIds;

- (void)appendHtmlStr:(NSString*)text;
- (void)setHtmlStr:(NSString *)str;

-(CGFloat)newHeightWithMaxSize:(CGSize)maxSize;
@end

