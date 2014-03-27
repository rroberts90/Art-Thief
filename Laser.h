//
//  Laser.h
//  ArtThief
//
//  Created by Richard Roberts on 3/26/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CCNode.h"

@interface Laser : CCNode

+ (Laser *) laserWithPosition:(CGPoint) start end:(CGPoint) end;
- (id) initWithPosition: (CGPoint) start end:(CGPoint) end;

@property (nonatomic) CGPoint start;
@property (nonatomic) CGPoint end;
@property (nonatomic) ccColor4F laserColor;
@property (nonatomic) CGFloat laserWidth;
@property (nonatomic) CGFloat xVelocity;
//@property (nonatomic) BOOL isVertical;
@end
