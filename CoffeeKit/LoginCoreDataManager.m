//
//  LoginCoreDataManager.m
//  CoffeeKit
//
//  Created by Mia on 18/09/2017.
//  Copyright © 2017 WondersGroup. All rights reserved.
//

#import "LoginCoreDataManager.h"

@implementation LoginCoreDataManager

+ (instancetype)sharedManager {
    static LoginCoreDataManager *singleton;
    static dispatch_once_t singletonToken;
    dispatch_once(&singletonToken, ^{
        singleton = [[self alloc] init];
    });
    return singleton;
}

@end
