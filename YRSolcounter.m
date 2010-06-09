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
  
  timer = [NSTimer scheduledTimerWithTimeInterval: 0.0
                                           target: self
                                         selector: @selector(handleTimer:)
                                         userInfo: nil
                                          repeats: YES];
  
  NSNib *nib = [[NSNib alloc] initWithNibNamed: @"Solcounter" bundle: bundle];
  
  [nib instantiateNibWithOwner: self topLevelObjects: /* sets `textField` */ nil];
  [self setView: textField];
  
  [nib dealloc];
  return self;
}

-(void) handleTimer: (NSTimer*)_
{
  double date = [[NSDate date] timeIntervalSince1970];
  
  [textField setStringValue:
    [NSString stringWithFormat: @"%3llu %03llu ſ %03llu %03llu %03llu",
                                    (unsigned long long int)(date / 86400000) % 1000,
                                    (unsigned long long int)(date / 86400) % 1000,
                                    (unsigned long long int)(date / 86.4) % 1000,
                                    (unsigned long long int)(date / 0.0864) % 1000,
                                    (unsigned long long int)(date / 0.0000864) % 1000]];
}

-(void) dealloc
{
  [textField release];
  [super dealloc];
}

@end
