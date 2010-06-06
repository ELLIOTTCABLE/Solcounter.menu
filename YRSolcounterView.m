//
//  YRSolcounterView.m
//  Solcounter
//
//  Created by elliottcable on 14 766 ſ.
//  Copyright 2010 yreality. All rights reserved.
//

#import "YRSolcounterView.h"


@implementation YRSolcounterView

- (void)drawRect:(NSRect)rect
{
  if ([_menuExtra isMenuDown])
    [[NSColor selectedMenuItemTextColor] set];
  else
    [[NSColor blackColor] set];
  
  [[NSBezierPath bezierPathWithOvalInRect: NSMakeRect(4, 4, rect.size.width-8, rect.size.height-8 )] fill];
}

@end
