//
//  AppDelegate.m
//  DateSearch
//
//  Created by Vitaliy on 01.08.2020.
//  Copyright © 2020 Vitaliy. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self registerDate:@"31-07-2020"subscribeTrialDays:30];

    return YES;
}

-(void) registerDate:(NSString *) signDate subscribeTrialDays:(NSUInteger) trialDays {
    NSDate* nowDate = [NSDate date];
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
        NSLog(@"\n - - - Actual Date - - -\nnowDate = %@", [dateFormatter stringFromDate:nowDate]);
    
    NSDate *dateFromString = [dateFormatter dateFromString:signDate];
        NSLog(@"\n - - - Sign Date - - -\nsignDate = %@", [dateFormatter stringFromDate:dateFromString]);
    
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* rangeDaysToOff = [calendar components:NSCalendarUnitDay
                                                                fromDate:dateFromString
                                                                toDate:nowDate
                                                                options:0];
        NSLog(@"\n - - - Range Days - - -\ndays subscriptions passed = %@", rangeDaysToOff);

    if (dateFromString == nil) {
        NSLog(@"\n! ! ! Введите корректную дату регистрации ! ! !");
    }
    
    NSUInteger subscribeDays = trialDays;
    if (subscribeDays < rangeDaysToOff.day) {
        NSLog(@"\nBad news");
    } else if (subscribeDays > rangeDaysToOff.day) {
        NSLog(@"\nYour subscription expires after = %lu days", (subscribeDays-rangeDaysToOff.day));
        NSDate* offDay = [calendar dateByAddingUnit:NSCalendarUnitDay value:(subscribeDays - rangeDaysToOff.day) toDate:[NSDate date] options:0];
        NSLog(@"\nSubscription take off = %@", [dateFormatter stringFromDate:offDay] );
    }
    
}

#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
