//
//  LoginViewController.m
//  CoffeeKit
//
//  Created by Mia on 21/09/2017.
//  Copyright © 2017 WondersGroup. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIButton *stopButton;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) NSNumber *elapsedTime;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self racBind];
    //    [self startAnother];
    //    [self start];
//    [self myStart];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)racBind {
        RAC(self.timeLabel, text) = [RACObserve(self, elapsedTime) map:^id _Nullable(id  _Nullable value) {
            return [value stringValue];
        }];
    [[self.startButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [self myStart];
    }];
}

- (RACSignal *)newPaymentSignal
{
    return [RACSignal return:@"token"];
}

- (void)myStart {
    NSInteger refreshInterval = 30;
    @weakify(self);
    [[[[self newPaymentSignal] map:^id _Nullable(NSString * _Nullable paymentToken) {
        return [[NSDate date] dateByAddingTimeInterval:refreshInterval];
    }] flattenMap:^__kindof RACSignal * _Nullable(NSDate * _Nullable expiryDate) {
        return [[[[[RACSignal interval:1 onScheduler:[RACScheduler mainThreadScheduler]]
                  startWith:[NSDate date]]
                 takeUntilBlock:^BOOL(NSDate * _Nullable now) {
                     return [expiryDate compare:now] == NSOrderedAscending;
                 }] doCompleted:^{
                     self.timeLabel.text = @"reset";
                 }]
                map:^NSNumber *(NSDate *now)
                {
                    return @([expiryDate timeIntervalSinceDate:now]);
                }];
    }] subscribeNext:^(NSNumber *remaining)
    {
        // update timer readout here
        self.elapsedTime = @([remaining intValue]);
        NSLog(@"%@", remaining);
    }];
}

- (void)start
{
    NSInteger refreshInterval = 30;
    
    RACSignal *refreshTokenTimerSignal =
    [[RACSignal interval:refreshInterval onScheduler:[RACScheduler mainThreadScheduler]]
     startWith:[NSDate date]];
    
    [[[[refreshTokenTimerSignal
        flattenMap:^__kindof RACSignal * _Nullable(id  _Nullable value) {
            return [self newPaymentSignal];
        }]
       map:^NSDate *(NSString *paymentToken)
       {
           // display paymentToken here
           NSLog(@"%@", paymentToken);
           
           return [[NSDate date] dateByAddingTimeInterval:refreshInterval];
       }]
      flattenMap:^__kindof RACSignal * _Nullable(NSDate * _Nullable expiryDate) {
          return [[[[RACSignal interval:1 onScheduler:[RACScheduler mainThreadScheduler]]
                    startWith:[NSDate date]]
                   takeUntil:[refreshTokenTimerSignal skip:1]]
                  map:^NSNumber *(NSDate *now)
                  {
                      return @([expiryDate timeIntervalSinceDate:now]);
                  }];
      }]
     subscribeNext:^(NSNumber *remaining)
     {
         // update timer readout here
         self.elapsedTime = remaining;
         NSLog(@"%@", remaining);
     }];
}

- (void)startAnother {
    
    @weakify(self);
    [[self.startButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *sender) {
        @strongify(self);
        self.startButton.enabled = NO;
        NSDate *startDate = [NSDate date];
        RAC(self, elapsedTime) = [[[[[RACSignal interval:0.1f onScheduler:
                                      [RACScheduler schedulerWithPriority:RACSchedulerPriorityDefault]]
                                     startWith:[NSDate date]]
                                    takeUntil:[self.stopButton rac_signalForControlEvents:UIControlEventTouchUpInside]] map:^id(id value) {
            NSTimeInterval timeInterval = [(NSDate *)value timeIntervalSinceDate:startDate];
            //            NSLog(@"timeInterval: %@", timeInterval);
            return [NSNumber numberWithDouble:timeInterval];
        }] deliverOn:[RACScheduler mainThreadScheduler]];
    }];
}

@end
