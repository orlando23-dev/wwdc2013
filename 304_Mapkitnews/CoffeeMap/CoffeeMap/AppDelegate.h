//
//  AppDelegate.h
//  CoffeeMap
//
//  Created by llv22 on 8/6/13.
//  Copyright (c) 2013 llv22. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@import MapKit;

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
// bug-fix - 2013-08-06 22:32:53.889 CoffeeMap[453:303] *** -[NSKeyedUnarchiver decodeObjectForKey:]: cannot decode object of class (MKMapView)
//@property (nonatomic, strong) IBOutlet MKMapView *mapView;
@property (assign) IBOutlet MKMapView *mapView;

@end
