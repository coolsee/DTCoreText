//
//  DTTextAttachmentImage.m
//  DTCoreText
//
//  Created by Oliver Drobnik on 22.04.13.
//  Copyright (c) 2013 Drobnik.com. All rights reserved.
//

#import "DTCoreText.h"
#import "DTEmotionTextAttachment.h"


@implementation DTEmotionTextAttachment

- (id)initWithElement:(DTHTMLElement *)element options:(NSDictionary *)options
{
	self = [super initWithElement:element options:options];
	
	_originalSize = CGSizeMake(22, 22);
	[self setDisplaySize:_originalSize withMaxDisplaySize:_originalSize];
	
	
	NSString *src = [element.attributes objectForKey:@"src"];
	self.image = [[DTImageTextAttachment sharedImageCache] objectForKey:src];
	
	if (!self.image)
	{
		self.image = [UIImage imageNamed:src];
		// cache that for later
		if (self.image)
		{
			[[DTImageTextAttachment sharedImageCache] setObject:self.image forKey:src];
		}
	}
	return self;
}


- (NSMutableAttributedString*)attrStringWithElement:(DTHTMLElement *)element withAttr:(NSDictionary*)attr;
{
	//		NSMutableDictionary *tmpDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:[UIColor greenColor], NSBackgroundColorAttributeName, nil];
	
	if (___useiOS6Attributes)
	{
		
		UIFont *font = [attr objectForKey:NSFontAttributeName];
		CGRect rect = [@"img" boundingRectWithSize:CGSizeMake(1000, 1000) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil];
		CGFloat fontd = [font descender];
//		rect.size.height = rect.size.height + fontd;
		rect.origin.y = rect.origin.y+fontd;
		rect.size.width = rect.size.height;
		
		
		NSTextAttachment *attach = [[NSTextAttachment alloc] init];
		attach.image = self.image;
		
		attach.bounds = rect;
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
	NSMutableString *retString = [NSMutableString string];
	NSString *urlString;
	
	if (_contentURL)
	{
		
		if ([_contentURL isFileURL])
		{
			NSString *path = [_contentURL path];
			
			NSRange range = [path rangeOfString:@".app/"];
			
			if (range.length)
			{
				urlString = [path substringFromIndex:NSMaxRange(range)];
			}
			else
			{
				urlString = [_contentURL absoluteString];
			}
		}
		else
		{
			urlString = [_contentURL relativeString];
		}
	}
	else
	{
		urlString = [self dataURLRepresentation];
	}
	
	// output tag start
	[retString appendString:@"<e"];
	
//	// build style for img/video
//	NSMutableString *styleString = [NSMutableString string];
//	
//	switch (_verticalAlignment)
//	{
//		case DTTextAttachmentVerticalAlignmentBaseline:
//		{
//			//				[classStyleString appendString:@"vertical-align:baseline;"];
//			break;
//		}
//		case DTTextAttachmentVerticalAlignmentTop:
//		{
//			[styleString appendString:@"vertical-align:text-top;"];
//			break;
//		}
//		case DTTextAttachmentVerticalAlignmentCenter:
//		{
//			[styleString appendString:@"vertical-align:middle;"];
//			break;
//		}
//		case DTTextAttachmentVerticalAlignmentBottom:
//		{
//			[styleString appendString:@"vertical-align:text-bottom;"];
//			break;
//		}
//	}
//	
//	if (_originalSize.width>0)
//	{
//		[styleString appendFormat:@"width:%.0fpx;", _originalSize.width];
//	}
//	
//	if (_originalSize.height>0)
//	{
//		[styleString appendFormat:@"height:%.0fpx;", _originalSize.height];
//	}
//	
//	// add local style for size, since sizes might vary quite a bit
//	if ([styleString length])
//	{
//		[retString appendFormat:@" style=\"%@\"", styleString];
//	}
//	
//	[retString appendFormat:@" src=\"%@\"", urlString];
//	
//	// attach the attributes dictionary
//	NSMutableDictionary *tmpAttributes = [_attributes mutableCopy];
//	
//	// remove src,style, width and height we already have these
//	[tmpAttributes removeObjectForKey:@"src"];
//	[tmpAttributes removeObjectForKey:@"style"];
//	[tmpAttributes removeObjectForKey:@"width"];
//	[tmpAttributes removeObjectForKey:@"height"];
//	
//	for (__strong NSString *oneKey in [tmpAttributes allKeys])
//	{
//		oneKey = [oneKey stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//		NSString *value = [[tmpAttributes objectForKey:oneKey] stringByAddingHTMLEntities];
//		[retString appendFormat:@" %@=\"%@\"", oneKey, value];
//	}
//	
	// end
	[retString appendFormat:@" src=\"%@\"", urlString];
	[retString appendString:@" >e</e>"];
	
	return retString;
}

@end
