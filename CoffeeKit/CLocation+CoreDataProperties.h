//
//  CLocation+CoreDataProperties.h
//  CoffeeKit
//
//  Created by Mia on 17/09/2017.
//  Copyright © 2017 WondersGroup. All rights reserved.
//

#import "CLocation+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface CLocation (CoreDataProperties)

+ (NSFetchRequest<CLocation *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *address;
@property (nullable, nonatomic, copy) NSString *city;
@property (nullable, nonatomic, copy) NSString *country;
@property (nullable, nonatomic, copy) NSString *crossStreet;
@property (nonatomic) int64_t distance;
@property (nonatomic) int64_t lat;
@property (nonatomic) int64_t lng;
@property (nullable, nonatomic, copy) NSString *postalCode;
@property (nullable, nonatomic, copy) NSString *state;
@property (nullable, nonatomic, retain) CVenue *venue;

@end

NS_ASSUME_NONNULL_END
