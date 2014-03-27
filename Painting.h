//
//  Painting.h
//  ArtThief
//
//  Created by Richard Roberts on 3/25/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CCNode.h"

@interface Painting : CCNode
+ (Painting *) painting: (CGPoint ) loc;
+ (Painting *) painting;
//+ (Painting *) painting: (NSString *) galleryTag; // for later


- (void) removeCanvas;
@property (nonatomic) BOOL shiftPainting; //if painting is reached, screen shifts
@property (nonatomic) BOOL stolen; 

//@property (nonatomic) ,,, image, not sure how to store it yet
@end
