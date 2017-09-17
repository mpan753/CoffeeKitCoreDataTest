//
//  Venue.h
//  CoffeeKit
//
//  Created by Mia on 16/09/2017.
//  Copyright © 2017 WondersGroup. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Location, Stats;

@interface Venue : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) Location *location;
@property (strong, nonatomic) Stats *stats;

@end
