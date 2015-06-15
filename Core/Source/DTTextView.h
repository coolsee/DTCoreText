


@interface DTTextView : UITextView

// <act type="at" name="好人" id="sdfss">aa</act>
- (void)addAction:(NSString *)type withName:(NSString*)name withId:(NSString*)id;

- (void)replaceWithAction:(NSString *)type withName:(NSString*)name withId:(NSString*)id;

- (NSString*)htmlStr;
@end
