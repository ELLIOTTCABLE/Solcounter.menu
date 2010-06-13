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
  
  integralPrecision   = [[defaults dictionaryForKey: @"Precision"] objectForKey: @"Integral"];
  fractionalPrecision = [[defaults dictionaryForKey: @"Precision"] objectForKey: @"Fractional"];
  
  timer = [NSTimer scheduledTimerWithTimeInterval: 0.0864
                                           target: self
                                         selector: @selector(handleTimer:)
                                         userInfo: nil
                                          repeats: YES];
  
  textField = [[NSTextField alloc] initWithFrame: NSMakeRect(0, 0, 200, 21)];
  [self initTextField];
  return self;
}

-(void) initTextField {
  [textField setBordered: NO]; [textField setDrawsBackground: NO]; [textField setSelectable: NO];
  [[textField cell] setBackgroundStyle: NSBackgroundStyleRaised];
  
  [self setView: textField];
  
  NSURL *fontURL = [NSURL fileURLWithPath: [[self bundle] pathForResource: @"FertigoPro-Truncated"
                                                                   ofType: @"otf"
                                                              inDirectory: @"Fonts"]];
  
  radixFont = (NSFont*)CTFontCreateWithFontDescriptor(
    (CTFontDescriptorRef)[[(NSArray*)CTFontManagerCreateFontDescriptorsFromURL((CFURLRef)fontURL) autorelease]
                                       lastObject], 19.0, NULL);
  
  [self handleTimer: nil];
}

-(void) handleTimer: (NSTimer*)_ {
  double date = [[NSDate date] timeIntervalSince1970] / 86400.0;
  
  NSString *solCount = [NSString stringWithFormat: @"%3llu %03llu ſ %03llu %03llu %03llu",
    (unsigned long long int)(date / 1000.0)         % 1000,
    (unsigned long long int)(date /    1.0)         % 1000,
    (unsigned long long int)(date /    0.001)       % 1000,
    (unsigned long long int)(date /    0.000001)    % 1000,
    (unsigned long long int)(date /    0.000000001) % 1000];
  
  NSMutableAttributedString *attributedSolCount = [[[NSMutableAttributedString alloc]
    initWithString: solCount
        attributes: [[[NSDictionary alloc] initWithObjectsAndKeys:
          [NSFont menuFontOfSize: 14.0],                        NSFontAttributeName,
          [[NSColor blackColor] colorWithAlphaComponent: 1.0],   NSForegroundColorAttributeName,
        nil] autorelease]] autorelease];
  
  [attributedSolCount addAttribute: NSFontAttributeName
                             value: radixFont
                             range: NSMakeRange([solCount length] - (3 * 4) - 1, 1)];
  
  [textField setAttributedStringValue: attributedSolCount];
}

-(void) dealloc
{
  [textField release];
  [super dealloc];
}

@end
