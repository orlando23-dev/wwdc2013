//
//  AppDelegate.h
//  CameraViewOSX
//
//  Created by Ding Orlando on 11/3/13.
//  Copyright (c) 2013 Ding Orlando. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate, MKMapViewDelegate>{
    NSMutableArray *animationCameras;
}

@property (assign) IBOutlet NSWindow *window;
@property (nonatomic, strong) IBOutlet MKMapView *mapView;

- (IBAction)performSearch:(NSSearchField *)searchField;
- (IBAction)performSaveSnapshots:(NSMenuItem *)menuItem;

@end
