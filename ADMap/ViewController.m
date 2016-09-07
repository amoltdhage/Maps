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
    
    
    // Do any additional setup after loading the view, typically from a nib.
    
}

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
