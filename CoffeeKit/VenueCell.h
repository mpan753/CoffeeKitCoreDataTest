//
//  VenueCell.h
//  CoffeeKit
//
//  Created by Mia on 16/09/2017.
//  Copyright © 2017 WondersGroup. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VenueCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *distanceLabel;
@property (nonatomic, weak) IBOutlet UILabel *checkinsLabel;

@end
