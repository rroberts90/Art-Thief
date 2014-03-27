//
//  Laser.m
//  ArtThief
//
//  Created by Richard Roberts on 3/26/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Laser.h"

// super class for laser objects
@implementation Laser
@synthesize start = _start;
@synthesize end = _end;
@synthesize laserColor = _laserColor;
@synthesize laserWidth = _laserWidth;
@synthesize xVelocity = _xVelocity;


+ (Laser *) laserWithPosition:(CGPoint) start end:(CGPoint) end {
    return [[Laser alloc] initWithPosition:start end:end];
}

- (id) init{
    if(self = [super init]){
        _laserWidth = 5.f;
        _xVelocity = 0.0;
    }
    return self;
}
- (id) initWithPosition: (CGPoint) start end:(CGPoint) end {
    self = [self init]; //ccc4f( 255, 255, 204,255)]; // yellow
    _start = start;
    _end = end;
    
    return self;
}

- (void) draw {
    //[super draw];
    //ccDrawColor4B(_laserColor);
    ccDrawColor4B(255, 0, 0, 255) ;//Color of the line RGBA
    glLineWidth(10.f); //Stroke width of the line
    ccDrawLine( _start, _end);
}




@end
