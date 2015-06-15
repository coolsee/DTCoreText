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

@implementation DTTextView

// <act type="at" name="好人" id="sdfss">aa</act>
- (void)addAction:(NSString *)type withName:(NSString*)name withId:(NSString*)id{
	NSString *action = [NSString stringWithFormat:@"<act type=\"%@\" name=\"%@\" id=\"%@\">%@</act>", type, name, id, name];
	
	NSString *str =  [NSString stringWithFormat:@"%@%@",self.attributedText.htmlSimpleFragment, action];
	
	
	NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
	NSMutableDictionary *options = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], DTUseiOS6Attributes, nil];
	[options setObject:[NSNumber numberWithDouble:self.font.pointSize]  forKey:DTDefaultFontSize];
	
	NSAttributedString *string = [[NSAttributedString alloc] initWithHTMLData:data options:options documentAttributes:NULL];
	self.attributedText = string;
}

- (void)replaceWithAction:(NSString *)type withName:(NSString*)name withId:(NSString*)id{
	NSString *action = [NSString stringWithFormat:@"<act type=\"%@\" name=\"%@\" id=\"%@\">%@</act>", type, name, id, name];
	
	
	NSData *data = [action dataUsingEncoding:NSUTF8StringEncoding];
	NSMutableDictionary *options = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], DTUseiOS6Attributes, nil];
	[options setObject:[NSNumber numberWithDouble:self.font.pointSize]  forKey:DTDefaultFontSize];
	
	NSAttributedString *string = [[NSAttributedString alloc] initWithHTMLData:data options:options documentAttributes:NULL];
	
	[self.textStorage replaceCharactersInRange:self.selectedRange withAttributedString:string];
	self.selectedRange = NSMakeRange(self.selectedRange.location + 1, 0);
}

- (NSString*)htmlStr{
	return self.attributedText.htmlSimpleFragment;
}

@end
