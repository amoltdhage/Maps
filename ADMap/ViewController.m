//
//  ViewController.m
//  ADMap
//
//  Created by Student P_02 on 07/09/16.
//  Copyright © 2016 Amol T. Dhage. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    location=[[CLLocationManager alloc]init];
    [location setDesiredAccuracy:kCLLocationAccuracyBest];
    [location requestWhenInUseAuthorization];
    self.mapView.showsUserLocation=YES;
    
    [locationManager startUpdatingLocation];
    
    
    UILongPressGestureRecognizer *longPressOnMap = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(handleLongPress:)];
    
    longPressOnMap.minimumPressDuration = 2.0;
    
    [self.mapView addGestureRecognizer:longPressOnMap];
    
}


-(void)handleLongPress:(UIGestureRecognizer *)gesture {
    
    if (gesture.state == UIGestureRecognizerStateBegan) {
        
        CGPoint touchPoint = [gesture locationInView:gesture.view];
        
        CLLocationCoordinate2D myCoordinate = [self.mapView convertPoint:touchPoint toCoordinateFromView:gesture.view];
        
        MKPointAnnotation *annotation = [[MKPointAnnotation alloc]init];
        annotation.coordinate = myCoordinate;
        
        //        [self.mapView addAnnotation:annotation];
        
        
        CLGeocoder *geocoder = [[CLGeocoder alloc]init];
        
        CLLocation *annotationLocation = [[CLLocation alloc]initWithLatitude:myCoordinate.latitude longitude:myCoordinate.longitude];
        
        [geocoder reverseGeocodeLocation:annotationLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            
            if (error != nil) {
                NSLog(@"%@",error.localizedDescription);
                return;
            }
            
            if (placemarks.count > 0) {
                
                CLPlacemark *placemark = placemarks.firstObject;
                NSString *title;
                if (placemark.thoroughfare != nil) {
                    if (placemark.subThoroughfare != nil) {
                        title = [placemark.thoroughfare stringByAppendingString:placemark.subThoroughfare];
                    }
                    else {
                        title = placemark.thoroughfare;
                    }
                }
                
                NSString *subtitle = placemark.locality;
                
                annotation.title = title;
                annotation.subtitle = subtitle;
                
            }
            else {
                annotation.title = @"Unknown Place";
            }
            
            [self.mapView addAnnotation:annotation];
            
            
        }];
        
    }
    
}
// Do any additional setup after loading the view, typically from a nib.


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    presentLocation=locations.lastObject;
    presentLocation=[[CLLocation alloc]initWithLatitude:presentLocation.coordinate.latitude longitude:presentLocation.coordinate.longitude];
    NSLog(@"%f,%f",presentLocation.coordinate.latitude,presentLocation.coordinate.latitude);
}



-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    
    CLLocationCoordinate2D myCoordinate = userLocation.coordinate;
    MKCoordinateSpan span = MKCoordinateSpanMake(0.01, 0.01);
    MKCoordinateRegion region = MKCoordinateRegionMake(myCoordinate, span);
    [mapView setRegion:region animated:YES];
}



- (IBAction)segmenteControllerMapValueChanged:(id)sender {
    UISegmentedControl *segment =sender;
    if (segment.selectedSegmentIndex==0)
    {
        [self.mapView setMapType:MKMapTypeStandard];
    }
    else
        if (segment.selectedSegmentIndex==1)
        {
            [self.mapView setMapType:MKMapTypeSatellite];
        }
        else
            if (segment.selectedSegmentIndex==2)
            {
                [self.mapView setMapType:MKMapTypeHybrid];
            }
}
@end

