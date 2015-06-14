//
//  DTTextAttachmentImage.m
//  DTCoreText
//
//  Created by Oliver Drobnik on 22.04.13.
//  Copyright (c) 2013 Drobnik.com. All rights reserved.
//

#import "DTActTextAttachment.h"
#import "DTCoreText.h"



@implementation DTActTextAttachment


- (instancetype)initWithCoder:(NSCoder *)aDecoder {
	self = [super initWithCoder:aDecoder];

	return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
	[super encodeWithCoder:aCoder];
}

- (id)initWithElement:(DTHTMLElement *)element options:(NSDictionary *)options
{
	self = [super initWithElement:element options:options];
	NSString *type = [element.attributes objectForKey:@"type"];
	if([@"at" isEqual:type]){
		_actType = DTActTypeAt;
	}
	if([@"topic" isEqual:type]){
		_actType = DTActTypeTopic;
	}
	_actName = [element.attributes objectForKey:@"name"];
	_actId = [element.attributes objectForKey:@"id"];
	
	
	_originalSize = CGSizeMake(100, 10);
	[self setDisplaySize:_originalSize withMaxDisplaySize:_originalSize];
	return self;
}

- (NSMutableAttributedString*)attrStringWithElement:(DTHTMLElement *)element withAttr:(NSDictionary*)attr;
{
//		NSMutableDictionary *tmpDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:[UIColor greenColor], NSBackgroundColorAttributeName, nil];

	if (___useiOS6Attributes)
	{
//		NSString *value =[NSString stringWithFormat:@"%@", _actName];
//		NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:value attributes:attr];
//		
////		NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:value];
//		NSURL *url = [NSURL URLWithString:_actId];
//		
//		[attributedString addAttribute:NSLinkAttributeName
//								 value:url
//								 range:NSMakeRange(0, attributedString.length)];
//		
//		[attributedString addAttribute:NSForegroundColorAttributeName
//								 value:[UIColor blueColor]
//								 range:NSMakeRange(0, attributedString.length)];
//		return attributedString;
		
		NSString *text =[NSString stringWithFormat:@"@%@", _actName];
		NSTextAttachment *attach = [[NSTextAttachment alloc] init];
		
		CGRect frame = CGRectMake(0, 0, 40, 10);
		UIImage *image = [[UIImage alloc] init];
		UIFont *font = [UIFont boldSystemFontOfSize:8];
		UIGraphicsBeginImageContext(frame.size);
		[image drawInRect:frame];
		CGRect rect = frame;
		[[UIColor blueColor] set];
		[text drawInRect:CGRectIntegral(rect) withFont:font];
		UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
		UIGraphicsEndImageContext();
		
		
		
		attach.image = newImage;
		attach.bounds = frame;
		NSAttributedString* attributedString = [NSAttributedString attributedStringWithAttachment:attach];
		NSMutableAttributedString *attrRet = attributedString.mutableCopy;
		
		[attrRet addAttributes:attr range:NSMakeRange(0, attrRet.length)];
		
		return attrRet;
		
	}else{
		return [super attrStringWithElement:element withAttr:attr];
	}
}


- (NSString *)stringByEncodingAsHTML
{
	NSString *type = @"at";
	if (_actType == DTActTypeTopic) {
		type = @"topic";
	}
	return [NSString stringWithFormat:@"<act type='%@' name='%@' id='%@'>%@</act>", type, _actName, _actId, _actName];
}


@end
