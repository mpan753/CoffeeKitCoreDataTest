//
//  Venue.m
//  CoffeeKit
//
//  Created by Mia on 16/09/2017.
//  Copyright © 2017 WondersGroup. All rights reserved.
//

#import "Venue.h"
#import "Stats.h"
#import "Location.h"

@implementation Venue

//+ (Class)classForCollectionProperty:(NSString *)propertyName {
//    if ([propertyName isEqual:@"stats"]) {
//        return [Stats class];
//    } else if ([propertyName isEqual:@"location"]) {
//        return [Location class];
//    }
//    return nil;
//}

+ (void)load {
    [self mj_setupObjectClassInArray:^NSDictionary *{
        return @{
                 @"stats" : [Stats class],
                 @"location" : [Location class]
                 };
    }];
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"stats" : [Stats class],
             @"location" : [Location class]};
             };

@end
