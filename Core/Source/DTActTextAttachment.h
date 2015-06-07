//
//  DTTextAttachmentImage.h
//  DTCoreText
//
//  Created by Oliver Drobnik on 22.04.13.
//  Copyright (c) 2013 Drobnik.com. All rights reserved.
//

#import "DTTextAttachment.h"

typedef NS_ENUM(NSInteger, DTActType)
{
	DTActTypeAt = 0,
	DTActTypeTopic
};

/**
 A specialized subclass in the DTTextAttachment class cluster to represent an embedded image
 */

@interface DTActTextAttachment : DTTextAttachment <DTTextAttachmentHTMLPersistence>

/**
 The designated initializer which will be called by [DTTextAttachment textAttachmentWithElement:options:] for image attachments.
 @param element A DTHTMLElement that must have a valid tag name and should have a size. Any element attributes are copied to the text attachment's elements.
 @param options An NSDictionary of options. Used to specify the max image size with the key DTMaxImageSize.
 */
- (id)initWithElement:(DTHTMLElement *)element options:(NSDictionary *)options;

/**
 The image represented by the receiver
 */
@property (nonatomic, assign) DTActType actType;
@property (nonatomic, strong) NSString* actName;
@property (nonatomic, strong) NSString* actId;

@end
