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
	
	UIFont *font = self.font;
	NSString *action = [NSString stringWithFormat:@"<act type=\"at\" name=\"%@\" id=\"%@\">%@</act>", name, id, name];
	
	NSString *str =  [NSString stringWithFormat:@"%@%@",self.attributedText.htmlSimpleFragment, action];
	
	
	NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
	NSMutableDictionary *options = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], DTUseiOS6Attributes, nil];
	[options setObject:[NSNumber numberWithDouble:self.font.pointSize]  forKey:DTDefaultFontSize];
	[options setObject:[NSNumber numberWithBool:self.editable] forKey:DTTextViewEditable];
	NSAttributedString *string = [[NSAttributedString alloc] initWithHTMLData:data options:options documentAttributes:NULL];
	self.attributedText = string;
//	textView.textStorage.addAttribute(NSFontAttributeName, value: UIFont.systemFontOfSize(kTextViewFontSize), range: wholeRange)
	self.font = font;
}


- (void)replaceWithAt:(NSString*)name withId:(NSString*)id{
//	UIFont *font = self.font;
	NSString *action = [NSString stringWithFormat:@"<act type=\"at\" name=\"%@\" id=\"%@\">%@</act>", name, id, name];
	
	
	NSData *data = [action dataUsingEncoding:NSUTF8StringEncoding];
	NSMutableDictionary *options = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], DTUseiOS6Attributes, nil];
	[options setObject:[NSNumber numberWithDouble:self.font.pointSize]  forKey:DTDefaultFontSize];
	[options setObject:[NSNumber numberWithBool:self.editable] forKey:DTTextViewEditable];
	
	NSAttributedString *string = [[NSAttributedString alloc] initWithHTMLData:data options:options documentAttributes:NULL];
	
	[self.textStorage replaceCharactersInRange:self.selectedRange withAttributedString:string];
	self.selectedRange = NSMakeRange(self.selectedRange.location + 1, 0);
//	 textView.textStorage.removeAttribute(NSFontAttributeName, range: wholeRange)
//	[self.textStorage removeAttribute:NSForegroundColorAttributeName range:NSMakeRange(0, self.textStorage.length)];
//	[self.textStorage addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, self.textStorage.length)];
//	self.textStorage.addAttribute(NSFontAttributeName, value: font, range: self.s)
//	self.font = font;
}


- (void)addEmotion:(NSString *)type
{
	NSString *action = [NSString stringWithFormat:@"<e src=\"%@\">%@</e>", type, type];
	
	NSString *str =  [NSString stringWithFormat:@"%@%@",self.attributedText.htmlSimpleFragment, action];
	
	
	NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
	NSMutableDictionary *options = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], DTUseiOS6Attributes, nil];
	[options setObject:[NSNumber numberWithDouble:self.font.pointSize]  forKey:DTDefaultFontSize];
	[options setObject:[NSNumber numberWithBool:self.editable] forKey:DTTextViewEditable];
	
	NSAttributedString *string = [[NSAttributedString alloc] initWithHTMLData:data options:options documentAttributes:NULL];
	self.attributedText = string;
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

- (void)setHtmlStr:(NSString*)str{
	NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
	
	NSMutableDictionary *options = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], DTUseiOS6Attributes, nil];
	[options setObject:[NSNumber numberWithDouble:self.font.pointSize]  forKey:DTDefaultFontSize];
	NSAttributedString *string = [[NSAttributedString alloc] initWithHTMLData:data options:options documentAttributes:NULL];
	self.attributedText = string;
}


@end
