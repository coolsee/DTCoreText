//
//  DTTextAttachmentImage.m
//  DTCoreText
//
//  Created by Oliver Drobnik on 22.04.13.
//  Copyright (c) 2013 Drobnik.com. All rights reserved.
//

#import "DTActTextAttachment.h"
#import "DTCoreText.h"
#import "DTCSSStylesheet.h"


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
	_isEditable = [options objectForKey:DTTextViewEditable];
	
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

	if (___useiOS6Attributes)
	{
//		NSString *value =[NSString stringWithFormat:@"@%@", _actName];
//		NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:value attributes:attr];
//		
////		NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:value];
//		NSURL *url = [NSURL URLWithString:_actId];
//		
//		[attributedString addAttribute:NSLinkAttributeName
//								 value:url
//								 range:NSMakeRange(0, value.length)];
//		
//		[attributedString addAttribute:NSForegroundColorAttributeName
//								 value:[UIColor blueColor]
//								 range:NSMakeRange(0, value.length)];
//		return attributedString;
		
		NSString *text =[NSString stringWithFormat:@"@%@", _actName];
		NSTextAttachment *attach = [[NSTextAttachment alloc] init];
		
		UIFont *font = [attr objectForKey:NSFontAttributeName];
		CGRect rect = [text boundingRectWithSize:CGSizeMake(1000, 1000) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil];
	
		
		UIImage *image = [[UIImage alloc] init];
		UIGraphicsBeginImageContext(rect.size);
		[image drawInRect:rect];
		NSDictionary *attribute = @{NSForegroundColorAttributeName: [UIColor blueColor], NSFontAttributeName:font};
		[text drawInRect:rect withAttributes:attribute];
		UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
		UIGraphicsEndImageContext();
		
		attach.image = newImage;
		CGFloat fontd = [font descender];
		rect.origin.y = rect.origin.y+fontd;
		attach.bounds = rect;
		NSAttributedString* attributedString = [NSAttributedString attributedStringWithAttachment:attach];
		
		NSMutableAttributedString *attrRet = attributedString.mutableCopy;
		
		if(!_isEditable){
			
			[attrRet addAttribute:NSLinkAttributeName
							value:[NSURL URLWithString:[NSString stringWithFormat:@"%@://%@",self.actTypeStr, _actId]]
							range:NSMakeRange(0, attrRet.length)];
		}
		[attrRet addAttributes:attr range:NSMakeRange(0, attrRet.length)];
		return attrRet;
		
	}else{
		return [super attrStringWithElement:element withAttr:attr];
	}
}

- (NSString *)actTypeStr
{
	NSString *type = @"at";
	if (_actType == DTActTypeTopic) {
		type = @"topic";
	}
	return type;
}
- (NSString *)stringByEncodingAsHTML
{
	return [NSString stringWithFormat:@"<act type='%@' name='%@' id='%@'>%@</act>", self.actTypeStr, _actName, _actId, _actName];
}


@end
