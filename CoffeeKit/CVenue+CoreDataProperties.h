//
//  CVenue+CoreDataProperties.h
//  CoffeeKit
//
//  Created by Mia on 17/09/2017.
//  Copyright © 2017 WondersGroup. All rights reserved.
//

#import "CVenue+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface CVenue (CoreDataProperties)

+ (NSFetchRequest<CVenue *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, retain) CLocation *location;
@property (nullable, nonatomic, retain) CStats *stats;

@end

NS_ASSUME_NONNULL_END
