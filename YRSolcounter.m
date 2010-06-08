//
//  YRSolcounter.m
//  Solcounter
//
//  Created by elliottcable on 14 766 ſ.
//  Copyright 2010 yreality. All rights reserved.
//

#import "YRSolcounter.h"


@implementation YRSolcounter

- (id)initWithBundle:(NSBundle *)bundle
{
  if ( (self = [super initWithBundle: bundle]) == nil ) return nil;
  
  defaults = [[BundleUserDefaults alloc]
    initWithPersistentDomainName: [bundle objectForInfoDictionaryKey: @"CFBundleIdentifier"]];
  [defaults registerDefaults: [NSDictionary dictionaryWithContentsOfFile:
    [bundle pathForResource: @"UserDefaults" ofType: @"plist"]]];
  
  [[[NSNib alloc] initWithNibNamed: @"Solcounter" bundle: bundle]
    instantiateNibWithOwner: self topLevelObjects: nil];
  
  [self setView: textField];
  
  return self;
}

- (void)dealloc
{
  [textField release];
  [super dealloc];
}

@end
