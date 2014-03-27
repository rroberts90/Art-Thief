//
//  LaserPattern.m
//  ArtThief
//
//  Created by Richard Roberts on 3/26/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "LaserPattern.h"
#import "Laser.h"
//
//  GameData.m
//  Indigo
//
//  Created by Richard Roberts on 3/23/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//


// class to create & maintain different configurations of lasers
@implementation LaserPattern
@synthesize patterns = _patterns;

/*@synthesize arrayOfDataToBeStored;
 @synthesize missionCriticalNumber;
 @synthesize somethingToBeToggled;*/

//static variable - this stores our singleton instance
static LaserPattern *laserPattern = nil;

- (id) init {
    //patterns = @[createPattern1();];
}
// returns random pattern
+(LaserPattern*) laserPattern
{
    //LaserPattern = [];
    //If our singleton instance has not been created (first time it is being accessed)
    //if(laserPattern == nil)
/*    {
        //create our singleton instance
       // sharedPattern = [[GameData alloc] init];
        //sharedData.paintings = [NSMutableArray array];
        
        
        //collections (Sets, Dictionaries, Arrays) must be initialized
        //Note: our class does not contain properties, only the instance does
        //self.arrayOfDataToBeStored is invalid
        //sharedData.arrayOfDataToBeStored = [[NSMutableArray alloc] init];
    }*/
    
    //if the singleton instance is already created, return it
    return laserPattern;
}

-(LaserPattern*) createPattern1 {
    
}



@end