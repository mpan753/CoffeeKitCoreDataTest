//
//  MasterViewController.m
//  CoffeeKit
//
//  Created by Mia on 16/09/2017.
//  Copyright © 2017 WondersGroup. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "Location.h"
#import "VenueCell.h"
#import "Stats.h"

#import "CVenue+CoreDataClass.h"
#import "CLocation+CoreDataClass.h"
#import "CStats+CoreDataClass.h"

#define kCLIENTID @"NZIPM0EDEKMDVI54DXB11IHQC5VUSSZ34HAYQXWMBMYT1HJF"
#define kCLIENTSECRET @"LHR0Y25PKFTUMOE1QCOQ0ZTXEEG2PPFL3VL02O4OYHOOYRPE"

@interface MasterViewController ()

@property (nonatomic, strong) NSArray *venues;

@property (nonatomic, strong) AFHTTPSessionManager *httpManager;

@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    NSLog(@"Storeurl: %@", [[[CoreDataManager sharedManager] persistentStoreCoordinator] URLForPersistentStore:[[[[CoreDataManager sharedManager] persistentStoreCoordinator] persistentStores] firstObject]]);
    
    //    self.navigationItem.rightBarButtonItem = addButton;
    //    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    
//    [self configureRestKit];
    [self configureAFNetworking];
    [self loadVenues];
}

- (AFHTTPSessionManager *)httpManager {
    if (!_httpManager) {
        NSString *serverUrl = @"https://api.foursquare.com";
        _httpManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:serverUrl]];
    }
    return _httpManager;
}

- (void)configureAFNetworking {
//    self.httpManager
}
/*
- (void)configureRestKit
{
    // initialize AFNetworking HTTPClient
    NSURL *baseURL = [NSURL URLWithString:@"https://api.foursquare.com"];
    //    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:baseURL];
    
    // initialize RestKit
    //    RKObjectManager *objectManager = [[RKObjectManager alloc] initWithHTTPClient:client];
    RKObjectManager *objectManager = [RKObjectManager managerWithBaseURL:baseURL];
    
    
    // Initialize managed object store
    NSURL *storeURL = [[NSBundle mainBundle] URLForResource:@"CoffeeModel" withExtension:@"momd"];
    NSManagedObjectModel *managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:storeURL];
    RKManagedObjectStore *managedObjectStore = [[RKManagedObjectStore alloc] initWithManagedObjectModel:managedObjectModel];
    objectManager.managedObjectStore = managedObjectStore;
    
    // setup object mappings
//    RKObjectMapping *venueMapping = [RKObjectMapping mappingForClass:[Venue class]];
//    [venueMapping addAttributeMappingsFromArray:@[@"name"]];
    

    RKEntityMapping *venueMapping = [RKEntityMapping mappingForEntityForName:NSStringFromClass([CVenue class]) inManagedObjectStore:managedObjectStore];
    [venueMapping addAttributeMappingsFromDictionary:@{@"name" : @"kname"}];
    
    // register mappings with the provider using a response descriptor
    RKResponseDescriptor *responseDescriptor =
    [RKResponseDescriptor responseDescriptorWithMapping:venueMapping
                                                 method:RKRequestMethodGET
                                            pathPattern:@"/v2/venues/search"
                                                keyPath:@"response.venues"
                                            statusCodes:[NSIndexSet indexSetWithIndex:200]];
    
    [objectManager addResponseDescriptor:responseDescriptor];
    
    // define location object mapping
//    RKObjectMapping *locationMapping = [RKObjectMapping mappingForClass:[Location class]];
//    [locationMapping addAttributeMappingsFromArray:@[@"address", @"city", @"country", @"crossStreet", @"postalCode", @"state", @"distance", @"lat", @"lng"]];
    
    RKEntityMapping *locationMapping = [RKEntityMapping mappingForEntityForName:NSStringFromClass([CLocation class]) inManagedObjectStore:managedObjectStore];
        [locationMapping addAttributeMappingsFromArray:@[@"address", @"city", @"country", @"crossStreet", @"postalCode", @"state", @"distance", @"lat", @"lng"]];
    
    // define relationship mapping
    [venueMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"location" toKeyPath:@"location" withMapping:locationMapping]];
    
//    RKObjectMapping *statsMapping = [RKObjectMapping mappingForClass:[Stats class]];
//    [statsMapping addAttributeMappingsFromDictionary:@{@"checkinsCount": @"checkins", @"tipsCount": @"tips", @"usersCount": @"users"}];
    
    RKEntityMapping *statsMapping = [RKEntityMapping mappingForEntityForName:NSStringFromClass([CStats class]) inManagedObjectStore:managedObjectStore];
    [statsMapping addAttributeMappingsFromDictionary:@{@"checkinsCount": @"checkins", @"tipsCount": @"tips", @"usersCount": @"users"}];
    
    [venueMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"stats" toKeyPath:@"stats" withMapping:statsMapping]];
    
    
    RKLogConfigureByName("RestKit/CoreData", RKLogLevelDebug);
 
     Complete Core Data stack initialization
    [managedObjectStore createPersistentStoreCoordinator];
    NSString *storePath = [RKApplicationDataDirectory() stringByAppendingPathComponent:@"RKTwitter.sqlite"];
    NSString *seedPath = [[NSBundle mainBundle] pathForResource:@"RKSeedDatabase" ofType:@"sqlite"];

    NSError *error;
    NSPersistentStore *persistentStore = [managedObjectStore addSQLitePersistentStoreAtPath:storePath fromSeedDatabaseAtPath:seedPath withConfiguration:nil options:nil error:&error];
    NSAssert(persistentStore, @"Failed to add persistent store with error: %@", error);
    
    // Create the managed object contexts
    [managedObjectStore createManagedObjectContexts];
    
    // Configure a managed object cache to ensure we do not create duplicate objects
    managedObjectStore.managedObjectCache = [[RKInMemoryManagedObjectCache alloc] initWithManagedObjectContext:managedObjectStore.persistentStoreManagedObjectContext];
    

}
*/
- (void)loadVenues
{
    NSString *latLon = @"37.33,-122.03"; // approximate latLon of The Mothership (a.k.a Apple headquarters)
    NSString *clientID = kCLIENTID;
    NSString *clientSecret = kCLIENTSECRET;
    
    NSDictionary *queryParams = @{@"ll" : latLon,
                                  @"client_id" : clientID,
                                  @"client_secret" : clientSecret,
                                  @"categoryId" : @"4bf58dd8d48988d1e0931735",
                                  @"v" : @"20140118"};
//    {
//    [[RKObjectManager sharedManager] getObjectsAtPath:@"/v2/venues/search"
//                                           parameters:queryParams
//                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
//                                                  _venues = mappingResult.array;
//
//                                                  NSString *seedPath = [[NSBundle mainBundle] pathForResource:@"RKSeedDatabase" ofType:@"sqlite"];
//                                                  NSLog(@"URL: %@", seedPath);
//                                                  
//                                                  [self.tableView reloadData];
//                                              }
//                                              failure:^(RKObjectRequestOperation *operation, NSError *error) {
//                                                  NSLog(@"What do you mean by 'there is no coffee?': %@", error);
//                                              }];
//    }
    [self.httpManager GET:@"/v2/venues/search" parameters:queryParams progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"response: %@", responseObject[@"response"][@"venues"]);
        dispatch_async(dispatch_get_main_queue(), ^{
//            _venues = [NSArray yy_modelWithDictionary:responseObject[@"response"][@"venues"]];
            _venues = [Venue mj_objectArrayWithKeyValuesArray:responseObject[@"response"][@"venues"]];
//            _venues = [Venue arrayOfModelsFromDictionaries:responseObject[@"response"][@"venues"] error:nil];
            
            for (Venue *v in self.venues) {
                CVenue *venue = [CVenue mj_objectWithKeyValues:[v toDictionary] context:[CoreDataManager sharedManager].managedObjectContext];
                
//                [venue save];
                Venue *copyVenue = [Venue yy_modelWithDictionary:[venue toDictionary]];
                NSLog(@"Coredata venue: %@", [venue toDictionary]);
                NSLog(@"copyVenue: %@", [copyVenue mj_JSONString]);
                NSLog(@"originalVenue: %@", [v toDictionary]);
            }
//            NSLog(@"venues: %@", [Venue mj_keyValuesArrayWithObjectArray:self.venues].mj_JSONString);
            [self.tableView reloadData];
        });
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error: %@", error.localizedDescription);
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    self.clearsSelectionOnViewWillAppear = self.splitViewController.isCollapsed;
    [super viewWillAppear:animated];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)saveDatabase {
//    
//        [MagicalRecord saveWithBlock:^(NSManagedObjectContext * _Nonnull localContext) {
//            for (Venue *venue in self.venues) {
//                CVenue *v = [CVenue MR_createEntityInContext:localContext];
//                v.name = venue.name;
//            NSLog(@"url: %@", [NSPersistentStore MR_urlForStoreName:@"CoffeeKit.sqlite"].description);
//            }
//        }];
//}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDate *object = self.venues[indexPath.row];
        DetailViewController *controller = (DetailViewController *)[[segue destinationViewController] topViewController];
        [controller setDetailItem:object];
        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = YES;
    }
}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.venues.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VenueCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VenueCell" forIndexPath:indexPath];
    
    Venue *venue = _venues[indexPath.row];
    cell.nameLabel.text = [venue valueForKey:@"name"];
    cell.distanceLabel.text = [NSString stringWithFormat:@"%.0fm", venue.location.distance.floatValue];
    cell.checkinsLabel.text = [NSString stringWithFormat:@"%d checkins", venue.stats.checkins.intValue];
    
//    NSLog(@"json: %@", [venue toJSONString]);
    return cell;
}

@end
