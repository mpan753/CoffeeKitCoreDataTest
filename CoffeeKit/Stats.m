//
//  Stats.m
//  CoffeeKit
//
//  Created by Mia on 16/09/2017.
//  Copyright © 2017 WondersGroup. All rights reserved.
//

#import "Stats.h"

@implementation Stats

//+ (JSONKeyMapper *)keyMapper {
//    return [[JSONKeyMapper alloc]
//            initWithModelToJSONDictionary:@{
//                                            @"checkins" : @"checkinsCount",
//                                            @"tips" : @"tipCount",
//                                            @"users" : @"usersCount"
//                                            }];
//}

+ (void)load {
    [self mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                 @"checkins" : @"checkinsCount",
                 @"tips" : @"tipCount",
                 @"users" : @"usersCount"
                 };
    }];
}

@end
