//
//  MapViewController.h
//  earthquakemonitor
//
//  Created by Alejandro Saldivar on 1/6/16.
//  Copyright © 2016 Alejandro Saldivar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "MapPin.h"

@interface MapViewController : UIViewController <MKMapViewDelegate, NSURLConnectionDataDelegate>

- (IBAction)getfeed;

@end
