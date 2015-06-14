//
//  DemoAboutViewController.m
//  DTCoreText
//
//  Created by Oliver Drobnik on 3/4/13.
//  Copyright (c) 2013 Drobnik.com. All rights reserved.
//

#import "DemoAboutViewController.h"

@interface DemoAboutViewController ()
@property (weak, nonatomic) IBOutlet UITextView *mSysText;

@end

@implementation DemoAboutViewController

- (id)init
{
    self = [super initWithNibName:@"DemoAboutViewController" bundle:nil];
    if (self)
	 {
        // Custom initialization
		 self.navigationItem.title = @"About DTCoreText";
    }
    return self;
}
- (IBAction)onGetSysText:(id)sender {
	
	NSString *str = self.mSysText.attributedText.htmlSimpleFragment;
	
	NSLog(@" fragment:%@", str);
	
	NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
	NSMutableDictionary *options = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], DTUseiOS6Attributes, nil];
	NSAttributedString *string = [[NSAttributedString alloc] initWithHTMLData:data options:options documentAttributes:NULL];
	self.mSysText.attributedText = string;
	
	
	
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	
	NSString *path = [[NSBundle mainBundle] pathForResource:@"About" ofType:@"html"];
	NSData *data = [NSData dataWithContentsOfFile:path];
	NSAttributedString *attributedString = [[NSAttributedString alloc] initWithHTMLData:data documentAttributes:NULL];
	
	// we draw images and links via subviews provided by delegate methods
	self.attributedTextView.shouldDrawImages = YES;
	self.attributedTextView.shouldDrawLinks = YES;
	self.attributedTextView.textDelegate = self; // delegate for custom sub views

//	self.attributedTextView.attributedString = attributedString;

	NSMutableDictionary *options = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], DTUseiOS6Attributes, nil];
	NSAttributedString *string = [[NSAttributedString alloc] initWithHTMLData:data options:options documentAttributes:NULL];
	self.mSysText.attributedText = string;
	

	NSLog(@" fragment:%@", attributedString.htmlSimpleFragment);
}

- (void)attributedTextContentView:(DTAttributedTextContentView *)attributedTextContentView didDrawLayoutFrame:(DTCoreTextLayoutFrame *)layoutFrame inContext:(CGContextRef)context
{
	
}


- (void)attributedTextContentView:(DTAttributedTextContentView *)attributedTextContentView willDrawLayoutFrame:(DTCoreTextLayoutFrame *)layoutFrame inContext:(CGContextRef)context
{
	
}



/**
 Called before the text belonging to a text block is drawn.
 
 This gives the developer an opportunity to draw a custom background below a text block.
 
 @param attributedTextContentView The content view that drew a layout frame
 @param textBlock The text block
 @param frame The frame within the content view's coordinate system that will be drawn into
 @param context The graphics context that will be drawn into
 @param layoutFrame The layout frame that will be drawn for
 @returns `YES` is the standard fill of the text block should be drawn, `NO` if it should not
 */
- (BOOL)attributedTextContentView:(DTAttributedTextContentView *)attributedTextContentView shouldDrawBackgroundForTextBlock:(DTTextBlock *)textBlock frame:(CGRect)frame context:(CGContextRef)context forLayoutFrame:(DTCoreTextLayoutFrame *)layoutFrame
{
	
	UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(frame,1,1) cornerRadius:10];
	
	CGColorRef color = [textBlock.backgroundColor CGColor];
	if (color)
	{
		CGContextSetFillColorWithColor(context, color);
		CGContextAddPath(context, [roundedRect CGPath]);
		CGContextFillPath(context);
		
		CGContextAddPath(context, [roundedRect CGPath]);
		CGContextSetRGBStrokeColor(context, 0, 0, 0, 1);
		CGContextStrokePath(context);
		return NO;
	}
	
	return YES; // draw standard background
	
}

/**
 @name Providing Custom Views for Content
 */


/**
 Provide custom view for an attachment, e.g. an imageView for images
 
 @param attributedTextContentView The content view asking for a custom view
 @param attachment The <DTTextAttachment> that this view should represent
 @param frame The frame that the view should use to fit on top of the space reserved for the attachment
 @returns The view that should represent the given attachment
 */
- (UIView *)attributedTextContentView:(DTAttributedTextContentView *)attributedTextContentView viewForAttachment:(DTTextAttachment *)attachment frame:(CGRect)frame
{
	if ([attachment isKindOfClass:[DTImageTextAttachment class]])
	{
		// if the attachment has a hyperlinkURL then this is currently ignored
		DTLazyImageView *imageView = [[DTLazyImageView alloc] initWithFrame:frame];
		imageView.delegate = self;
		
		// sets the image if there is one
		imageView.image = [(DTImageTextAttachment *)attachment image];
		
		// url for deferred loading
		imageView.url = attachment.contentURL;
		
		// if there is a hyperlink then add a link button on top of this image
		if (attachment.hyperLinkURL)
		{
			// NOTE: this is a hack, you probably want to use your own image view and touch handling
			// also, this treats an image with a hyperlink by itself because we don't have the GUID of the link parts
			imageView.userInteractionEnabled = YES;
			
			DTLinkButton *button = [[DTLinkButton alloc] initWithFrame:imageView.bounds];
			button.URL = attachment.hyperLinkURL;
			button.minimumHitSize = CGSizeMake(25, 25); // adjusts it's bounds so that button is always large enough
			button.GUID = attachment.hyperLinkGUID;
			
			// use normal push action for opening URL
			[button addTarget:self action:@selector(linkPushed:) forControlEvents:UIControlEventTouchUpInside];
			
			// demonstrate combination with long press
			UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(linkLongPressed:)];
			[button addGestureRecognizer:longPress];
			
			[imageView addSubview:button];
		}
		
		return imageView;
	}
	else if ([attachment isKindOfClass:[DTActTextAttachment class]])
	{
//		CGRect rect = CGRectMake(frame.origin.x, frame.origin.y, 100.0, 40.0);
		UILabel *label = [[UILabel alloc] initWithFrame:frame];
		label.backgroundColor = [UIColor grayColor];
		label.text = [(DTActTextAttachment *)attachment actName];
		return label;
	}
	else if ([attachment isKindOfClass:[DTObjectTextAttachment class]])
	{
		// somecolorparameter has a HTML color
		NSString *colorName = [attachment.attributes objectForKey:@"somecolorparameter"];
		UIColor *someColor = DTColorCreateWithHTMLName(colorName);
		
		UIView *someView = [[UIView alloc] initWithFrame:frame];
		someView.backgroundColor = someColor;
		someView.layer.borderWidth = 1;
		someView.layer.borderColor = [UIColor blackColor].CGColor;
		
		someView.accessibilityLabel = colorName;
		someView.isAccessibilityElement = YES;
		
		return someView;
	}
	return nil;

}

//
///**
// Provide button to be placed over links, the identifier is used to link multiple parts of the same A tag
// 
// @param attributedTextContentView The content view asking for a custom view
// @param url The `NSURL` of the hyperlink
// @param identifier An identifier that uniquely identifies the hyperlink within the document
// @param frame The frame that the view should use to fit on top of the space reserved for the attachment
// @returns The view that should represent the given hyperlink
// */
//- (UIView *)attributedTextContentView:(DTAttributedTextContentView *)attributedTextContentView viewForLink:(NSURL *)url identifier:(NSString *)identifier frame:(CGRect)frame
//{
//	return nil;
//}
//
//
///**
// Provide generic views for all attachments.
// 
// This is only called if the more specific delegate methods are not implemented.
// 
// @param attributedTextContentView The content view asking for a custom view
// @param string The attributed sub-string containing this element
// @param frame The frame that the view should use to fit on top of the space reserved for the attachment
// @returns The view that should represent the given hyperlink or text attachment
// @see attributedTextContentView:viewForAttachment:frame: and attributedTextContentView:viewForAttachment:frame:
// */
//- (UIView *)attributedTextContentView:(DTAttributedTextContentView *)attributedTextContentView viewForAttributedString:(NSAttributedString *)string frame:(CGRect)frame
//{
//	return nil;
//}


#pragma mark - DTLazyImageViewDelegate

- (void)lazyImageView:(DTLazyImageView *)lazyImageView didChangeImageSize:(CGSize)size {
	NSURL *url = lazyImageView.url;
	CGSize imageSize = size;
	
	NSPredicate *pred = [NSPredicate predicateWithFormat:@"contentURL == %@", url];
	
	BOOL didUpdate = NO;
	
	// update all attachments that matchin this URL (possibly multiple images with same size)
	for (DTTextAttachment *oneAttachment in [self.attributedTextView.attributedTextContentView.layoutFrame textAttachmentsWithPredicate:pred])
	{
		// update attachments that have no original size, that also sets the display size
		if (CGSizeEqualToSize(oneAttachment.originalSize, CGSizeZero))
		{
			oneAttachment.originalSize = imageSize;
			
			didUpdate = YES;
		}
	}
	
	if (didUpdate)
	{
		// layout might have changed due to image sizes
		[self.attributedTextView relayoutText];
	}
}



- (void)viewDidUnload
{
    [self setAttributedTextView:nil];
    [super viewDidUnload];
}
@end
