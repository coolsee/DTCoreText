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


- (NSString *)stringByEncodingAsHTML
{
	NSString *type = @"at";
	if (_actType == DTActTypeTopic) {
		type = @"topic";
	}
	return [NSString stringWithFormat:@"<act type='%@' name='%@' id='%@'>%@</act>", type, _actName, _actId, _actName];
}


@end
