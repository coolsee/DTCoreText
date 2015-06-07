//
//  DTTextAttachmentImage.h
//  DTCoreText
//
//  Created by Oliver Drobnik on 22.04.13.
//  Copyright (c) 2013 Drobnik.com. All rights reserved.
//

#import "DTTextAttachment.h"
#import "DTImageTextAttachment.h"

@interface DTEmotionTextAttachment : DTImageTextAttachment<DTTextAttachmentHTMLPersistence>

- (id)initWithElement:(DTHTMLElement *)element options:(NSDictionary *)options;
@end
