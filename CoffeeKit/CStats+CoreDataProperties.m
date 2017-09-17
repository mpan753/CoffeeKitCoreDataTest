//
//  CStats+CoreDataProperties.m
//  CoffeeKit
//
//  Created by Mia on 17/09/2017.
//  Copyright © 2017 WondersGroup. All rights reserved.
//

#import "CStats+CoreDataProperties.h"

@implementation CStats (CoreDataProperties)

+ (NSFetchRequest<CStats *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"CStats"];
}

@dynamic checkins;
@dynamic tips;
@dynamic users;
@dynamic venue;

@end
