//
//  DemoAboutViewController.h
//  DTCoreText
//
//  Created by Oliver Drobnik on 3/4/13.
//  Copyright (c) 2013 Drobnik.com. All rights reserved.
//

#import "DTWeakSupport.h"
#import "DTTextView.h"

@interface DemoAboutViewController : UIViewController<DTAttributedTextContentViewDelegate, DTLazyImageViewDelegate, UITextViewDelegate>

@property (nonatomic, DT_WEAK_PROPERTY) IBOutlet DTAttributedTextView *attributedTextView;

@end
