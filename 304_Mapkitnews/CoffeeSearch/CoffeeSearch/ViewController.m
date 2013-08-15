//
//  ViewController.m
//  CoffeeSearch
//
//  Created by llv22 on 8/10/13.
//  Copyright (c) 2013 llv22. All rights reserved.
//

#define ENABLELOG

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    // desc - pan via API
//    self.map.centerCoordinate =  CLLocationCoordinate2DMake(0, 180);
//    self.map.region =  MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2DMake(0, 180), 1000.0*1000.0, 1000.0*1000.0);
#ifdef ENABLELOG
    NSLog(@"%f %f %f", MKMapPointsPerMeterAtLatitude(0), MKMapPointsPerMeterAtLatitude(90), MKMapPointsPerMeterAtLatitude(180));
    NSLog(@"%f %f", MKMapRectGetMaxX(MKMapRectWorld), MKMapRectGetMaxY(MKMapRectWorld));
#endif
    
    // desc  - for world viewport
    // //dx, dy = 0,0
    self.map.visibleMapRect = MKMapRectInset(MKMapRectMake(MKMapRectGetMaxX(MKMapRectWorld), MKMapRectGetMaxY(MKMapRectWorld), 0, 0),
                                             -1000.0 * 10000.0 * MKMapPointsPerMeterAtLatitude(0),
                                             -1000.0 * 10000.0 * MKMapPointsPerMeterAtLatitude(0));
    
    // desc - replace x/y/z with OpenStreetMap layer, more style - http://wiki.openstreetmap.org/wiki/tiles
    NSString *template = @"http://c.tile.openstreetmap.org/{z}/{x}/{y}.png";
    MKTileOverlay *overlay = [[MKTileOverlay alloc]initWithURLTemplate:template];
//    overlay.canReplaceMapContent = YES;
    [self.map addOverlay:overlay level:MKOverlayLevelAboveLabels];
}

- (void)viewDidAppear:(BOOL)animated{
    MKPointAnnotation  *a = [[MKPointAnnotation alloc]init];
    a.title = @"Honolulu, HI";
    a.coordinate = CLLocationCoordinate2DMake(19.47695, -155.566406);
    
    MKPointAnnotation  *b = [[MKPointAnnotation alloc]init];
    b.title = @"Sydney, Asustralia";
    b.coordinate = CLLocationCoordinate2DMake(-26.431228, 151.347656);
    [self.map showAnnotations:@[a,b] animated:YES];
    
    // desc - update geodesicpolyline
    [self updateOverlaysFromPoint:a.coordinate toPoint:b.coordinate];}

- (void)updateOverlaysFromPoint:(CLLocationCoordinate2D)start
                        toPoint:(CLLocationCoordinate2D)end{
    CLLocationCoordinate2D points[] = {start, end};
#ifdef ENABLELOG
    NSLog(@"%lu", sizeof(points)/sizeof(CLLocationCoordinate2D));
#endif
    // desc -  a line shape that traces the shortest path along the surface of the Earth.
    MKGeodesicPolyline* geodesic = [MKGeodesicPolyline polylineWithCoordinates:points count:sizeof(points)/sizeof(CLLocationCoordinate2D)];
    [self.map addOverlay:geodesic];
}

- (MKOverlayRenderer*)mapView:(MKMapView*)mapView rendererForOverlay:(id<MKOverlay>)overlay{
#ifdef ENABLELOG
    NSLog(@"%@", overlay);
#endif
    MKOverlayRenderer *renderer = nil;
    if ([overlay isKindOfClass:[MKGeodesicPolyline class]]) {
        MKPolylineRenderer *lineRenderer = [[MKPolylineRenderer alloc]initWithOverlay:overlay];
        lineRenderer.lineWidth = 5.0;
        lineRenderer.strokeColor = [UIColor purpleColor];
        renderer = lineRenderer;
    }
    else if([overlay isKindOfClass:[MKTileOverlay class]]){
        MKTileOverlayRenderer *tileRenderer = [[MKTileOverlayRenderer alloc]initWithOverlay:overlay];
        renderer = tileRenderer;
    }
    return renderer;
}

#pragma mark - UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
#ifdef ENABLELOG
    NSLog(@"doSearch via (%@)", [searchBar text]);
#endif
    // desc - initialize request object
    MKLocalSearchRequest *request = [[MKLocalSearchRequest alloc]init];
    request.naturalLanguageQuery = [searchBar text];
    request.region = self.map.region;
    
    // desc - initialize search object
    MKLocalSearch *search = [[MKLocalSearch alloc]initWithRequest:request];
    
    // desc - run search and display object
    __block UISearchBar* localSearchBar = searchBar;
    [search startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error) {
        if (!error) {
            NSMutableArray *placemarks = [NSMutableArray array];
            for (MKMapItem *item in response.mapItems) {
                [placemarks addObject:item.placemark];
            }
            [self.map removeAnnotations:[self.map annotations]];
            [self.map showAnnotations:placemarks animated:YES];
            [localSearchBar endEditing:YES];
        }
    }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
