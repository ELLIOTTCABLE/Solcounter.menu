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
  
  [[[[NSNib alloc] initWithNibNamed: @"Solcounter" bundle: bundle] autorelease]
    instantiateNibWithOwner: self topLevelObjects: /* sets `textField` */ nil];
  [self setView: textField];
  
  [self initTextField];
  return self;
}

-(void) initTextField {
  NSRect frame = [textField frame];
  [textField setFrame: NSMakeRect(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height - 1)];
  [[textField cell] setBackgroundStyle: NSBackgroundStyleRaised];
  
  NSURL *fontURL = [NSURL fileURLWithPath: [[self bundle] pathForResource: @"FertigoPro-Truncated"
                                                                   ofType: @"otf"
                                                              inDirectory: @"Fonts"]];
  
  radixFont = (NSFont*)CTFontCreateWithFontDescriptor(
    (CTFontDescriptorRef)[[(NSArray*)CTFontManagerCreateFontDescriptorsFromURL((CFURLRef)fontURL) autorelease]
                                       lastObject], 19.0, NULL);
  
  [self handleTimer: nil];
}

-(void) handleTimer: (NSTimer*)_ {
  double date = [[NSDate date] timeIntervalSince1970];
  
  NSString *solCount = [NSString stringWithFormat: @"%3llu %03llu ſ %03llu %03llu %03llu",
    (unsigned long long int)(date / 86400000.0)       % 1000,
    (unsigned long long int)(date /    86400.0)       % 1000,
    (unsigned long long int)(date /       86.4)       % 1000,
    (unsigned long long int)(date /        0.0864)    % 1000,
    (unsigned long long int)(date /        0.0000864) % 1000];
  
  NSMutableAttributedString *attributedSolCount = [[[NSMutableAttributedString alloc]
    initWithString: solCount
        attributes: [[[NSDictionary alloc] initWithObjectsAndKeys:
          [NSFont menuFontOfSize: 14.0],                        NSFontAttributeName,
          [[NSColor blackColor] colorWithAlphaComponent: 1.0],   NSForegroundColorAttributeName,
        nil] autorelease]] autorelease];
  
  int length = [solCount length];
  NSRange nanosolRange  = NSMakeRange(length - (1 * 4),     4);
  NSRange microsolRange = NSMakeRange(length - (2 * 4),     4);
//NSRange millisolRange = NSMakeRange(length - (3 * 4),     4);
  NSRange radixRange    = NSMakeRange(length - (3 * 4) - 1, 1);
  NSRange solRange      = NSMakeRange(length - (4 * 4) - 1, 4);
  NSRange kilosolRange  = NSMakeRange(0,                    3);
  
  [attributedSolCount addAttribute: NSFontAttributeName value: radixFont range: radixRange];
  
  [attributedSolCount addAttribute: NSForegroundColorAttributeName
                             value: [[NSColor blackColor] colorWithAlphaComponent:.2]
                             range: nanosolRange];
  [attributedSolCount addAttribute: NSForegroundColorAttributeName
                             value: [[NSColor blackColor] colorWithAlphaComponent:.2]
                             range: microsolRange];
  [attributedSolCount addAttribute: NSForegroundColorAttributeName
                             value: [[NSColor blackColor] colorWithAlphaComponent:.2]
                             range: solRange];
  [attributedSolCount addAttribute: NSForegroundColorAttributeName
                             value: [[NSColor blackColor] colorWithAlphaComponent:.2]
                             range: kilosolRange];
  
  [textField setAttributedStringValue: attributedSolCount];
}

-(void) dealloc
{
  [textField release];
  [super dealloc];
}

@end
