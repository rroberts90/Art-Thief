//
//  Thief.m
//  ArtThief
//
//  Created by Richard Roberts on 3/25/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Thief.h"

@implementation Thief
@synthesize isMoving = _isMoving;
@synthesize isJumping = _isJumping;

- (void) didLoadFromCCB{
    //NSLog(@"Thief Loaded");
    _isMoving = NO;
    _isJumping = NO;
}



@end
