//
//  InterfaceController.m
//  SmartTimer WatchKit Extension
//
//  Created by Admin on 20.04.16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "InterfaceController.h"


@interface InterfaceController()
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *levelLabel;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *exerciseLabel;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceTimer *timer;
@property (weak) NSTimer *systemTimer;
@property NSUInteger level;
@property NSUInteger exercise;


@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    _level = 0;
    _exercise = 0;
    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

- (IBAction)levelButtonPressed {
    _level++;
    [_levelLabel setText:[NSString stringWithFormat:@"%u подходов",_level]];
    [_systemTimer invalidate];
    [_timer setDate:[NSDate dateWithTimeIntervalSinceNow:90]];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        _systemTimer = [NSTimer scheduledTimerWithTimeInterval:90 target:self selector:@selector(timerDone) userInfo:nil repeats:NO];
    });
    
    [_timer start];
}

- (IBAction)exerciseButtonPressed {
    _level = 0;
    _exercise++;
    [_levelLabel setText:[NSString stringWithFormat:@"%u подходов",_level]];
    [_exerciseLabel setText:[NSString stringWithFormat:@"%u упражнений",_exercise]];
    [_systemTimer invalidate];
    [_timer setDate:[NSDate dateWithTimeIntervalSinceNow:180]];
    _systemTimer = [NSTimer scheduledTimerWithTimeInterval:180 target:self selector:@selector(timerDone) userInfo:nil repeats:NO];
    [_timer start];
}

- (void)timerDone {
    [[WKInterfaceDevice currentDevice] playHaptic:WKHapticTypeNotification];
}

@end



