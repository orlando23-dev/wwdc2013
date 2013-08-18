//
//  ViewController.h
//  CameraView
//
//  Created by llv22 on 8/18/13.
//  Copyright (c) 2013 llv22. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<MKMapViewDelegate>

@property (nonatomic, strong) IBOutlet MKMapView *mapView;

@end
