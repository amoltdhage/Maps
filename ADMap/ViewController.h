//
//  ViewController.h
//  ADMap
//
//  Created by Student P_02 on 07/09/16.
//  Copyright © 2016 Amol T. Dhage. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <corelocation/coreLocation.h>

@interface ViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate>
{
    CLLocationManager *location;
    CLLocationManager *locationManager;
    CLLocation *presentLocation;
    
}
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentControllerMap;

- (IBAction)segmenteControllerMapValueChanged:(id)sender;



@end

