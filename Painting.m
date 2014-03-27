//
//  Painting.m
//  ArtThief
//
//  Created by Richard Roberts on 3/25/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Painting.h"
//TODO: include a list of images to randomly assign to paintings

@implementation Painting {
    
}
+ (Painting *) painting: (CGPoint) loc {
    Painting *painting = (Painting *)[CCBReader load:@"Painting"];
    painting.position = loc;
    painting.stolen = NO;
    // assign image
    return painting;
}
+ (Painting *) painting {
    Painting *painting = (Painting *)[CCBReader load:@"Painting"];
    painting.stolen = NO;
    return painting;
}

- (void) didLoadFromCCB {
    
}

// TODO: fill out method to remove image leaving black canvas
- (BOOL) removeCanvas {
    self.stolen = YES;
    return YES;
}

@end
