//
//  CStats+CoreDataProperties.h
//  CoffeeKit
//
//  Created by Mia on 17/09/2017.
//  Copyright © 2017 WondersGroup. All rights reserved.
//

#import "CStats+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface CStats (CoreDataProperties)

+ (NSFetchRequest<CStats *> *)fetchRequest;

@property (nonatomic) int64_t checkins;
@property (nonatomic) int64_t tips;
@property (nonatomic) int64_t users;
@property (nullable, nonatomic, retain) CVenue *venue;

@end

NS_ASSUME_NONNULL_END
