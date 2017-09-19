//
//  CVenue+Extention.m
//  CoffeeKit
//
//  Created by Mia on 17/09/2017.
//  Copyright © 2017 WondersGroup. All rights reserved.
//

#import "CVenue+Extention.h"
#import "CLocation+CoreDataClass.h"
#import "CStats+CoreDataClass.h"

@implementation CVenue (Extention)

+ (NSDictionary *)mappings {
    return @{
             @"location" : @{
                     @"class" : [CLocation class]
                     },
             @"stats" : @{
                     @"class" : [CStats class]
                     }
             };
}

@end
