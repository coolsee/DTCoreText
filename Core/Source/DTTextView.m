//
//  DTAttributedTextView.m
//  DTCoreText
//
//  Created by Oliver Drobnik on 1/12/11.
//  Copyright 2011 Drobnik.com. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "DTTextView.h"
#import "NSAttributedString+DTCoreText.h"
#import "DTCoreTextConstants.h"
#import "NSAttributedString+HTML.h"
#import "DTActTextAttachment.h"

@implementation UITextView (DTTextView)

//@end

//@implementation DTTextView


//-(id)initWithCoder:(NSCoder *)aDecoder{
//	if([super initWithCoder:aDecoder]){
//		self.delegate = self;
//		self.editable = NO;
//		self.dataDetectorTypes = UIDataDetectorTypeLink;
//
//		return self;
//	}
//	return nil;
//}



// <act type="at" name="好人" id="sdfss">aa</act>
- (void)addAt:(NSString*)name withId:(NSString*)id
{
	
//	NSString *action = [NSString stringWithFormat:@"<act type=\"at\" name=\"%@\" id=\"%@\">%@</act>", name, id, name];
//	
//	NSString *htmstr = self.attributedText.htmlSimpleFragment;
//	NSString *str = @"";
//	if (htmstr == nil){
//		str = action;
//	}else{
//		str = [NSString stringWithFormat:@"%@%@", htmstr, action];
//	}
//	
//	NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
//	NSMutableDictionary *options = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], DTUseiOS6Attributes, nil];
//	[options setObject:[NSNumber numberWithDouble:self.font.pointSize]  forKey:DTDefaultFontSize];
//	[options setObject:[NSNumber numberWithBool:self.editable] forKey:DTTextViewEditable];
//	NSAttributedString *string = [[NSAttributedString alloc] initWithHTMLData:data options:options documentAttributes:NULL];
//	self.attributedText = string;
	
	
	NSString *action = [NSString stringWithFormat:@"<act type=\"at\" name=\"%@\" id=\"%@\">%@</act>", name, id, name];
	NSData *data = [action dataUsingEncoding:NSUTF8StringEncoding];
	NSMutableDictionary *options = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], DTUseiOS6Attributes, nil];
	[options setObject:[NSNumber numberWithDouble:self.font.pointSize]  forKey:DTDefaultFontSize];
	NSAttributedString *string = [[NSAttributedString alloc] initWithHTMLData:data options:options documentAttributes:NULL];
	
	NSRange range = NSMakeRange(self.text.length, 0);
	[self.textStorage replaceCharactersInRange:range withAttributedString:string];
	self.selectedRange = NSMakeRange(self.text.length, 0);

}


- (void)replaceWithAt:(NSString*)name withId:(NSString*)id{
	NSString *action = [NSString stringWithFormat:@"<act type=\"at\" name=\"%@\" id=\"%@\">%@</act>", name, id, name];
	
	
	NSData *data = [action dataUsingEncoding:NSUTF8StringEncoding];
	NSMutableDictionary *options = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], DTUseiOS6Attributes, nil];
	[options setObject:[NSNumber numberWithDouble:self.font.pointSize]  forKey:DTDefaultFontSize];
	[options setObject:[NSNumber numberWithBool:self.editable] forKey:DTTextViewEditable];
	
	NSAttributedString *string = [[NSAttributedString alloc] initWithHTMLData:data options:options documentAttributes:NULL];
	
	[self.textStorage replaceCharactersInRange:self.selectedRange withAttributedString:string];
	self.selectedRange = NSMakeRange(self.selectedRange.location + 1, 0);

}


- (void)addEmotion:(NSString *)type
{
//	NSString *action = [NSString stringWithFormat:@"<e src=\"%@\">%@</e>", type, type];
//	
//	NSString *htmstr = self.attributedText.htmlSimpleFragment;
//	NSString *str = @"";
//	if (htmstr == nil){
//		str = action;
//	}else{
//		str = [NSString stringWithFormat:@"%@%@", htmstr, action];
//	}
//	
//	NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
//	NSMutableDictionary *options = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], DTUseiOS6Attributes, nil];
//	[options setObject:[NSNumber numberWithDouble:self.font.pointSize]  forKey:DTDefaultFontSize];
//	[options setObject:[NSNumber numberWithBool:self.editable] forKey:DTTextViewEditable];
//	
//	NSAttributedString *string = [[NSAttributedString alloc] initWithHTMLData:data options:options documentAttributes:NULL];
//	self.attributedText = string;
	
	NSString *action = [NSString stringWithFormat:@"<e src=\"%@\">%@</e>", type, type];
	NSData *data = [action dataUsingEncoding:NSUTF8StringEncoding];
	NSMutableDictionary *options = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], DTUseiOS6Attributes, nil];
	[options setObject:[NSNumber numberWithDouble:self.font.pointSize]  forKey:DTDefaultFontSize];
	NSAttributedString *string = [[NSAttributedString alloc] initWithHTMLData:data options:options documentAttributes:NULL];
	
	NSRange range = NSMakeRange(self.text.length, 0);
	[self.textStorage replaceCharactersInRange:range withAttributedString:string];
	self.selectedRange = NSMakeRange(self.text.length, 0);
}


- (void)replaceWithEmotion:(NSString *)type
{
	NSString *action = [NSString stringWithFormat:@"<e src=\"%@\">%@</e>", type, type];
	
	NSData *data = [action dataUsingEncoding:NSUTF8StringEncoding];
	NSMutableDictionary *options = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], DTUseiOS6Attributes, nil];
	[options setObject:[NSNumber numberWithDouble:self.font.pointSize]  forKey:DTDefaultFontSize];
	[options setObject:[NSNumber numberWithBool:self.editable] forKey:DTTextViewEditable];
	
	NSAttributedString *string = [[NSAttributedString alloc] initWithHTMLData:data options:options documentAttributes:NULL];
	
	[self.textStorage replaceCharactersInRange:self.selectedRange withAttributedString:string];
	self.selectedRange = NSMakeRange(self.selectedRange.location + 1, 0);
}

- (NSString*)getHtmlStr{
	return self.attributedText.htmlSimpleFragment;
}

- (NSArray*)atUserIds
{
	NSMutableArray *models = [NSMutableArray array];
	[self.attributedText enumerateAttribute:NSAttachmentAttributeName inRange:NSMakeRange(0, self.attributedText.length)
					 options:0
				  usingBlock:^(id value, NSRange range, BOOL *stop) {
					  if (value && [value isKindOfClass:[DTActTextAttachment class]]) {
						  DTActTextAttachment *act = (DTActTextAttachment*)value;
						  if (act.actType == DTActTypeAt) {
							  [models addObject:act.actId];
						  }
					  }
				  }];
	return [NSArray arrayWithArray:models];
}

- (void)appendHtmlStr:(NSString*)text
{
	NSData *data = [text dataUsingEncoding:NSUTF8StringEncoding];
	
	NSMutableDictionary *options = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], DTUseiOS6Attributes, nil];
	[options setObject:[NSNumber numberWithDouble:self.font.pointSize]  forKey:DTDefaultFontSize];
	NSAttributedString *string = [[NSAttributedString alloc] initWithHTMLData:data options:options documentAttributes:NULL];
	
	NSRange range = NSMakeRange(self.text.length, 0);
	[self.textStorage replaceCharactersInRange:range withAttributedString:string];
	self.selectedRange = NSMakeRange(self.text.length, 0);
}

- (void)setHtmlStr:(NSString*)str{
	NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
	
	NSMutableDictionary *options = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], DTUseiOS6Attributes, nil];
	[options setObject:[NSNumber numberWithDouble:self.font.pointSize]  forKey:DTDefaultFontSize];
	NSAttributedString *string = [[NSAttributedString alloc] initWithHTMLData:data options:options documentAttributes:NULL];
	self.attributedText = string;
}


-(CGFloat)newHeightWithMaxSize:(CGSize)maxSize
{
	return [self sizeThatFits:maxSize].height;
	//    float h = [self sizeThatFits:maxSize].height;
	//    return h;
}

@end
