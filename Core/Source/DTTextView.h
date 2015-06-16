

@interface UITextView (DTTextView)

// <act type="at" name="好人" id="sdfss">aa</act>
- (void)addAction:(NSString *)type withName:(NSString*)name withId:(NSString*)id;
- (void)addEmotion:(NSString *)type;

- (void)replaceWithAction:(NSString *)type withName:(NSString*)name withId:(NSString*)id;

- (NSString*)getHtmlStr;

- (void)setHtmlStr:(NSString *)str;

@end

