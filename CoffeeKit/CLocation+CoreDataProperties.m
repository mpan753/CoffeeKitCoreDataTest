//
//  CLocation+CoreDataProperties.m
//  CoffeeKit
//
//  Created by Mia on 17/09/2017.
//  Copyright © 2017 WondersGroup. All rights reserved.
//

#import "CLocation+CoreDataProperties.h"

@implementation CLocation (CoreDataProperties)

+ (NSFetchRequest<CLocation *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"CLocation"];
}

@dynamic address;
@dynamic city;
@dynamic country;
@dynamic crossStreet;
@dynamic distance;
@dynamic lat;
@dynamic lng;
@dynamic postalCode;
@dynamic state;
@dynamic venue;

@end
