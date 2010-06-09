//
//  YRSolcounter.m
//  Solcounter
//
//  Created by elliottcable on 14 766 ſ.
//  Copyright 2010 yreality. All rights reserved.
//

#import "YRSolcounter.h"


@implementation YRSolcounter

-(id) initWithBundle: (NSBundle*)bundle {
  if ( (self = [super initWithBundle: bundle]) == nil ) return nil;
  
  [(defaults = [[BundleUserDefaults alloc]
    initWithPersistentDomainName: [bundle objectForInfoDictionaryKey: @"CFBundleIdentifier"]])
    registerDefaults: [NSDictionary dictionaryWithContentsOfFile:
      [bundle pathForResource: @"UserDefaults" ofType: @"plist"]]];
  
  timer = [NSTimer scheduledTimerWithTimeInterval: 0.0864
                                           target: self
                                         selector: @selector(handleTimer:)
                                         userInfo: nil
                                          repeats: YES];
  
  NSNib *nib = [[NSNib alloc] initWithNibNamed: @"Solcounter" bundle: bundle];
  
  [nib instantiateNibWithOwner: self topLevelObjects: /* sets `textField` */ nil];
  [self setView: textField];
  
  NSRect frame = [textField frame];
  [textField setFrame: NSMakeRect(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height - 1)];
  
  NSURL *fontURL = [NSURL fileURLWithPath: [[self bundle] pathForResource: @"FertigoPro-Truncated"
                                                                   ofType: @"otf"
                                                              inDirectory: @"Fonts"]];
  
  // Core Foundation pain
  radixFont = CTFontCreateWithGraphicsFont(
    CGFontCreateWithDataProvider(CGDataProviderCreateWithURL((CFURLRef)fontURL)), 14.0, NULL, NULL);
  // end Core Foundation pain
  
  NSLog(@"radixFont: %@", radixFont);
  
  [self handleTimer: nil];
  
  [nib dealloc];
  return self;
}

-(void) handleTimer: (NSTimer*)_ {
  double date = [[NSDate date] timeIntervalSince1970];
  
  NSString *solCount = [NSString stringWithFormat: @"%3llu %03llu ſ %03llu %03llu %03llu",
    (unsigned long long int)(date / 86400000.0)       % 1000,
    (unsigned long long int)(date /    86400.0)       % 1000,
    (unsigned long long int)(date /       86.4)       % 1000,
    (unsigned long long int)(date /        0.0864)    % 1000,
    (unsigned long long int)(date /        0.0000864) % 1000];
  
  NSDictionary *solCountAttributes = [[NSDictionary alloc] initWithObjectsAndKeys:
    [NSFont menuFontOfSize: 14.0],                        NSFontAttributeName,
    [[NSColor blackColor] colorWithAlphaComponent: .9],   NSForegroundColorAttributeName,
    nil];
  NSMutableAttributedString *attributedSolCount = //»
    [[NSMutableAttributedString alloc] initWithString: solCount
                                           attributes: solCountAttributes];
  
  int length = [solCount length];
  NSRange nanosolRange  = NSMakeRange(length - (1 * 4),     4);
  NSRange microsolRange = NSMakeRange(length - (2 * 4),     4);
  NSRange millisolRange = NSMakeRange(length - (3 * 4),     4);
  NSRange radixRange    = NSMakeRange(length - (3 * 4) - 1, 1);
  NSRange solRange      = NSMakeRange(length - (4 * 4) - 1, 4);
  NSRange kilosolRange  = NSMakeRange(0,                    3);
  
  [attributedSolCount addAttribute: NSForegroundColorAttributeName
                             value: [[NSColor blackColor] colorWithAlphaComponent:.3]
                             range: nanosolRange];
  [attributedSolCount addAttribute: NSForegroundColorAttributeName
                             value: [[NSColor blackColor] colorWithAlphaComponent:.3]
                             range: microsolRange];
  [attributedSolCount addAttribute: NSFontAttributeName value: radixFont range: radixRange];
  [attributedSolCount addAttribute: NSForegroundColorAttributeName
                             value: [[NSColor blackColor] colorWithAlphaComponent:.3]
                             range: kilosolRange];
  
  [textField setAttributedStringValue: attributedSolCount];
  [attributedSolCount release];
  [solCountAttributes release];
}

-(void) dealloc
{
  [textField release];
  [super dealloc];
}

@end
