//
//  AppDelegate.m
//  CameraViewOSX
//
//  Created by Ding Orlando on 11/3/13.
//  Copyright (c) 2013 Ding Orlando. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (void)updateCameraProperties{
    NSLog(@"%@", [self.mapView.camera description]);
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    self->animationCameras = [[NSMutableArray alloc]init];
    
    self.mapView.delegate = self;
    self.mapView.rotateEnabled = YES;
    self.mapView.showsCompass = YES;
    self.mapView.showsZoomControls = YES;
    
    // desc - center coordinate
    self.mapView.camera.centerCoordinate =  CLLocationCoordinate2DMake(37.78275123, -122.40416442);
    // desc - altitude - height above the map
    self.mapView.camera.altitude = 1500;
    // desc - heading - direction camera faces [0 - north for z axis, 180 - sourth for z axis, for z axis control]
    self.mapView.camera.heading = 0;
    // desc - pitch - angle camera tilts [0, 90], not make sense for (90, 180)
    self.mapView.camera.pitch = 30;
    
    [self updateCameraProperties];
}

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
//    [self updateCameraProperties];
    if (animated) {
        [self goToNextCamera];
    }
}

- (void)performShortCameraAnimation:(MKMapCamera *)end{
//    MKMapCamera *end = [MKMapCamera cameraLookingAtCenterCoordinate:coord
//                                                  fromEyeCoordinate:coord
//                                                        eyeAltitude:500];
//    // desc - 3D building for end.pitch = 55
//    end.pitch = 55;
    
    // desc - do filter of current distance to traverse
    MKMapCamera *start = self.mapView.camera;
    CLLocation *startLocation = [[CLLocation alloc]initWithCoordinate:start.centerCoordinate
                                                             altitude:start.altitude
                                                   horizontalAccuracy:0
                                                     verticalAccuracy:0
                                                            timestamp:nil];
    CLLocation *endLocation = [[CLLocation alloc]initWithCoordinate:end.centerCoordinate
                                                           altitude:end.altitude
                                                 horizontalAccuracy:0
                                                   verticalAccuracy:0
                                                          timestamp:nil];
    CLLocationDistance distance = [startLocation distanceFromLocation:endLocation];
    NSLog(@"Distance in meters: %f", distance);
    
    CLLocationCoordinate2D startingCoordinate = self.mapView.centerCoordinate;
    MKMapPoint startingPoint = MKMapPointForCoordinate(startingCoordinate);
    MKMapPoint endingPoint = MKMapPointForCoordinate(end.centerCoordinate);
    
    MKMapPoint midPoint = MKMapPointMake(startingPoint.x + ((endingPoint.x - startingPoint.x)/2.0), startingPoint.y + ((endingPoint.y - startingPoint.y)/2.0));
    CLLocationCoordinate2D midCoordinate = MKCoordinateForMapPoint(midPoint);
    // desc - just added magic for 4 3D change
    CLLocationDistance midAltitude = end.altitude * 4;
    
    MKMapCamera *midCamera = [MKMapCamera cameraLookingAtCenterCoordinate:end.centerCoordinate fromEyeCoordinate:midCoordinate eyeAltitude:midAltitude];
    if (self->animationCameras == NULL) {
        self->animationCameras = [[NSMutableArray alloc]init];
    }
    else{
        [self->animationCameras removeAllObjects];
    }
    [self->animationCameras addObject:midCamera];
    [self->animationCameras addObject:end];
    [self goToNextCamera];
}

- (void)performLongCameraAnimation:(MKMapCamera *)end{
    MKMapCamera *start = self.mapView.camera;
    CLLocation *startLocation = [[CLLocation alloc]initWithCoordinate:start.centerCoordinate
                                                             altitude:start.altitude
                                                   horizontalAccuracy:0
                                                     verticalAccuracy:0
                                                            timestamp:nil];
    CLLocation *endLocation = [[CLLocation alloc]initWithCoordinate:end.centerCoordinate
                                                           altitude:end.altitude
                                                 horizontalAccuracy:0
                                                   verticalAccuracy:0
                                                          timestamp:nil];
    CLLocationDistance distance = [startLocation distanceFromLocation:endLocation];
    CLLocationDistance midAltitude = distance;
    
    // desc - pan to camera position in the same height
    MKMapCamera *midCamera1 = [MKMapCamera cameraLookingAtCenterCoordinate:start.centerCoordinate
                                                         fromEyeCoordinate:start.centerCoordinate
                                                               eyeAltitude:midAltitude];
    MKMapCamera *midCamera2 = [MKMapCamera cameraLookingAtCenterCoordinate:end.centerCoordinate
                                                         fromEyeCoordinate:end.centerCoordinate
                                                               eyeAltitude:midAltitude];
    if (self->animationCameras == NULL) {
        self->animationCameras = [[NSMutableArray alloc]init];
    }
    else{
        [self->animationCameras removeAllObjects];
    }
    [self->animationCameras addObject:midCamera1];
    [self->animationCameras addObject:midCamera2];
    [self goToNextCamera];
}

- (void)goToNextCamera{
    if (animationCameras.count == 0) {
        //We've done!
        return;
    }
    
    MKMapCamera *nextCamera = [animationCameras firstObject];
    [animationCameras removeObjectAtIndex:0];
    // desc - don't use completionHandle of Animation
    [NSAnimationContext runAnimationGroup:^(NSAnimationContext *context) {
        context.duration = 1.0;
        context.allowsImplicitAnimation = YES;
        CAMediaTimingFunction *f = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        context.timingFunction = f;
        self.mapView.camera = nextCamera;
    } completionHandler:NULL];
}

- (void)goToCoordinate:(CLLocationCoordinate2D)coord{
    MKMapCamera *end = [MKMapCamera cameraLookingAtCenterCoordinate:coord
                                                  fromEyeCoordinate:coord
                                                        eyeAltitude:500];
    // desc - 3D building for end.pitch = 55
    end.pitch = 55;
    
    // desc - do filter of current distance to traverse
    MKMapCamera *start = self.mapView.camera;
    CLLocation *startLocation = [[CLLocation alloc]initWithCoordinate:start.centerCoordinate
                                                             altitude:start.altitude
                                                   horizontalAccuracy:0
                                                     verticalAccuracy:0
                                                            timestamp:nil];
    CLLocation *endLocation = [[CLLocation alloc]initWithCoordinate:end.centerCoordinate
                                                           altitude:end.altitude
                                                 horizontalAccuracy:0
                                                   verticalAccuracy:0
                                                          timestamp:nil];
    CLLocationDistance distance = [startLocation distanceFromLocation:endLocation];
    NSLog(@"Distance in meters: %f", distance);
    
    if (distance < 2500) {
        [self.mapView setCamera:end animated:YES];
        return;
    }
    
    if (distance < 5000) {
        [self performShortCameraAnimation:end];
        return;
    }
    
    [self performLongCameraAnimation:end];
}

- (IBAction)performSearch:(NSSearchField *)searchField{
    NSString *searchQuery = [searchField stringValue];
    if (!searchQuery || searchQuery.length == 0) {
        return;
    }
    
    //desc - execute query for map on local region
    MKLocalSearchRequest *searchRequest = [[MKLocalSearchRequest alloc]init];
    searchRequest.naturalLanguageQuery = searchQuery;
    searchRequest.region = self.mapView.region;
    
    MKLocalSearch *search = [[MKLocalSearch alloc]initWithRequest:searchRequest];
    [search startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error) {
        if (error || response.mapItems.count == 0) {
            NSLog(@"%@", error);
            return;
        }
        
        MKMapItem *topItem = [response.mapItems firstObject];
        [self.mapView removeAnnotations:self.mapView.annotations];
        [self.mapView addAnnotation:topItem.placemark];
        // desc - not just move, but move here with 3D building - replace with new anmimation
//        [self.mapView showAnnotations:@[topItem.placemark] animated:YES];
        [self goToCoordinate:topItem.placemark.coordinate];
    }];
}

@end
