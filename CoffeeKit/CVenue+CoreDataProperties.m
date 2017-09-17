//
//  CVenue+CoreDataProperties.m
//  CoffeeKit
//
//  Created by Mia on 17/09/2017.
//  Copyright © 2017 WondersGroup. All rights reserved.
//

#import "CVenue+CoreDataProperties.h"

@implementation CVenue (CoreDataProperties)

+ (NSFetchRequest<CVenue *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"CVenue"];
}

@dynamic name;
@dynamic location;
@dynamic stats;

@end
