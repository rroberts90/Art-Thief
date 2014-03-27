//
//  MainScene.m
//  PROJECTNAME
//
//  Created by Viktor on 10/10/13.
//  Copyright (c) 2013 Apportable. All rights reserved.
//

#import "MainScene.h"
#import "Thief.h"
#import "Painting.h"
#import "GameData.h"
#import "Laser.h"

static const CGFloat walkSpeed = 100.f;
//static const CGFloat jumpHeight = 5.f;
//static const CGFloat distanceBetweenPaintings = 400;
static const CGFloat firstPaintingX = 200;
static const CGFloat lastPaintingX = 500;

static const CGFloat firstPaintingY = 200;

typedef NS_ENUM(NSInteger, DrawingOrder) {
    DrawingOrderPainting,
    DrawingOrderFloor,
    DrawingOrderScore,
    DrawingOrderThief,
    DrawingOrderLaser,
    DrawingRestartButton
};

@implementation MainScene {
    
    // sprite builder connections
    CCNode *_floor1;
    CCNode *_floor2;
    Thief *_thief;
    CCPhysicsNode *_physicsNode;
    CCLabelTTF *_scoreLabel;
    
    // collections
    NSArray *_floors;
    NSMutableArray *_paintings;
    NSMutableArray *_lasers; // current layers in scene
    NSMutableArray *_laserPatterns; // contains 
    // counters
    NSTimeInterval _sinceTouch;
    CGFloat _score;

}
- (void) didLoadFromCCB {
    NSLog(@"MainScene loaded");
    
    self.userInteractionEnabled = YES;

    _floors = @[_floor1, _floor2];
    _paintings = [NSMutableArray array];

    _thief.isMoving = NO;
    _thief.physicsBody.affectedByGravity = TRUE;

    _thief.zOrder = DrawingOrderThief;
    _floor1.zOrder = DrawingOrderFloor;
    _floor2.zOrder = DrawingOrderFloor;
    _scoreLabel.zOrder = DrawingOrderScore;

    //[GameData sharedData].gameplayScene = self;
    //[GameData sharedData].rootPhysicsNode = _physicsNode;
    
    
    _sinceTouch = 0.f;
    _score = 0.f;

    [self setupGallery: 0.f];

}


// post condition: paintings are ordered as their appear in gallery
- (void) setupGallery: (CGFloat) startX{
    // for now just 2 paintings
    Painting *p1 = [Painting painting];
    CGPoint shiftPos;
    if(self.contentSize.width > 10)
        shiftPos = ccp(startX + self.contentSize.width - 100, firstPaintingY);
    else
        shiftPos = ccp(startX + lastPaintingX, firstPaintingY);

    
    p1.position = shiftPos;
    p1.shiftPainting = TRUE;
    
    Painting *p2 = [Painting painting];
    
    p2.position = ccp(startX + firstPaintingX, firstPaintingY);
    p2.shiftPainting = FALSE;
    [self addPainting:p2];
    [self addPainting:p1];
 
    [self addLaser];

    
    
}


- (void) addLaser {
    CGSize size = [[CCDirector sharedDirector] viewSize];
    
    NSLog(@"\nheight: %.2f", size.height);
    CGPoint start = ccp(500,size.height);
    CGPoint  end = ccp(500,10);
    Laser *l =  [Laser laserWithPosition: start end: end];
 //   Laser *l =  [Laser laserWithPosition: ccp(100,100) end: ccp(1000,1000)];
    [_lasers addObject: l];
    l.zOrder = DrawingOrderLaser;
    [_physicsNode addChild:l];
}


//parameters: ??
- (void) shiftLeft: (CGFloat) nextGalleryStartX  {

    
    [self setupGallery: nextGalleryStartX];
    
    CCActionMoveTo *cameraMove = [CCActionMoveTo actionWithDuration:1.f position: ccp(-nextGalleryStartX, _physicsNode.position.y)];
    [_physicsNode runAction:cameraMove];
    
    [self moveFloors];
    [self removePaintings];

}


- (void) update:(CCTime)delta {
    _sinceTouch += delta;
    
    if (_thief.isMoving){
        // check for score updates
        for (Painting *p in _paintings)
            if (!p.stolen && _thief.position.x > p.position.x - p.contentSize.width/2){
                [p removeCanvas];
                _score++;
                _scoreLabel.string = [NSString stringWithFormat:@"%.0f",_score];
            }
        Painting *p = [_paintings lastObject];
        if ( _thief.position.x > p.position.x)
            [self shiftLeft: p.position.x]; // start of a new frame
    }
}


- (void) touchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    //CGFloat yVelocity = 0.0;
    

    if(!_thief.isMoving  && _thief.isMoving){ // UNCOMMENT AFTER LASER TESTS
        _thief.physicsBody.velocity = ccp(walkSpeed , _thief.physicsBody.velocity.y);
        _thief.isMoving = YES;

     }
    
    [self addLaser];
     _sinceTouch = 0.0;

}

- (void) touchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
    [_thief stopAllActions];
    _thief.physicsBody.velocity = ccp(0.0, _thief.physicsBody.velocity.y);
    _thief.isMoving = NO;
}


- (void) scrollLeft: (CCTime) delta {
    if(_thief.isMoving){
        CGFloat thiefScrollX = _thief.physicsBody.velocity.x * delta;
        _physicsNode.position = ccp(_physicsNode.position.x - thiefScrollX, _physicsNode.position.y);
        
        [self moveFloors];
        // remove a painting
        /*NSMutableArray *toRemove = nil;
        for (Painting *painting in _paintings) {
            CGPoint paintingWP = [_physicsNode convertToWorldSpace:painting.position];
            CGPoint paintingSP = [self convertToNodeSpace:paintingWP];
            CGFloat actualPaintingSize = painting.contentSize.width * painting.scaleX;
            if (paintingSP.x < -actualPaintingSize) {
                if(!toRemove)
                    toRemove = [NSMutableArray array];
                [toRemove addObject: painting];
            }
        }
        for (Painting *painting in toRemove){
            [painting removeFromParent];
            [_paintings removeObject:painting];
            [self spawnPainting];
        }
        */
        
    }
}

- (void) moveFloors {
    for(CCNode *floor in _floors){
        CGPoint floorWP = [_physicsNode convertToWorldSpace:floor.position];
        CGPoint floorSP = [self convertToNodeSpace:floorWP];
        
        CGFloat actualSize = floor.contentSize.width * floor.scaleX;
        if(floorSP.x <= (-1 * actualSize)){
            
            CGPoint scrolledPos = ccp(floor.position.x + (2 * actualSize) , floor.position.y);
            floor.position = scrolledPos;
        }
    }

}

- (void) removePaintings {
    NSMutableArray *toRemove = nil;
    for (Painting *painting in _paintings) {
        CGPoint paintingWP = [_physicsNode convertToWorldSpace:painting.position];
        CGPoint paintingSP = [self convertToNodeSpace:paintingWP];
        CGFloat actualPaintingSize = painting.contentSize.width * painting.scaleX;
        if (paintingSP.x < -actualPaintingSize) {
            if(!toRemove)
                toRemove = [NSMutableArray array];
            [toRemove addObject: painting];
        }
    }
    
    for (CCNode *object in toRemove){
        [object removeFromParent];
        [_paintings removeObject:object];
    }
}


- (BOOL) addPainting: (Painting *) p {
    [_physicsNode addChild:p];
    [_paintings addObject:p];
    p.zOrder = DrawingOrderPainting;
    return YES;
}

                                
int signum(int n) { return (n < 0) ? -1 : (n > 0) ? +1 : 0; }


@end



//CCActionMoveTo *move = [CCActionMoveTo actionWithDuration: moveDuration position:ccp(finalX, _bear.position.y)];
//NSLog(@"Touch registered");
//CCActionMoveBy *move = [CCActionMoveBy actionWithDuration: walkTime  position: ccp(_thief.position.x + walkSpeed, 0)];

//[_thief runAction:[CCActionRepeatForever actionWithAction:move]];

/*NSLog(@"\n\nMoving Floor\nScreen X position: %.2f",floorSP.x);
 NSLog(@"\nfloor Content Size: %.2f",floor.contentSize.width);
 NSLog(@"\nfloor ScaleX: %.2f",floor.scaleX);
 
 NSLog(@"\nthief position: %.2f", _thief.position.x);
 // get world position
 CGPoint thiefWP = [_physicsNode convertToWorldSpace:_thief.position];
 CGPoint thiefSP = [self convertToNodeSpace:thiefWP   ];
 
 NSLog(@"thief world position: %.2f", thiefWP.x  );
 NSLog(@"thief screen position: %.2f", thiefSP.x);

 */

/* Includ Jumping as a v.2 feature
 f(_sinceTouch < .7f && !_thief.isJumping){ // double tap means jump
 _thief.isJumping = true;
 [_thief.physicsBody applyImpulse:ccp(500.f, 1500.f)];
 }
 
 if(_thief.isJumping && _thief.physicsBody.velocity.y == 0)
 _thief.isJumping = NO;*/

//NSLog(@"\n Last Painting position: %.2f", _.position.x);
// get world position
//CGPoint thiefWP = [_physicsNode convertToWorldSpace:_thief.position];
//CGPoint thiefSP = [self convertToNodeSpace:thiefWP   ];

//NSLog(@"thief world position: %.2f", thiefWP.x  );
//NSLog(@"thief screen position: %.2f", thiefSP.x);

// remove paintings

/*- (Painting *) spawnPainting: (CGPoint) pos{
    
    Painting *p = [Painting painting: pos];
    [_physicsNode addChild:p];
    [_paintings addObject:p];
    p.zOrder = DrawingOrderPainting;
    return p;
}*/


