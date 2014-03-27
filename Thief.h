//
//  Thief.h
//  ArtThief
//
//  Created by Richard Roberts on 3/25/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CCSprite.h"

@interface Thief : CCSprite
@property (nonatomic) BOOL isMoving;
@property (nonatomic) BOOL isJumping;
@property (nonatomic) CGFloat currentMove;

@end
