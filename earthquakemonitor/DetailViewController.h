//
//  DetailViewController.h
//  earthquakemonitor
//
//  Created by Alejandro Saldivar on 1/6/16.
//  Copyright © 2016 Alejandro Saldivar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "MapPin.h"

@interface DetailViewController : UIViewController <MKMapViewDelegate>
{
    IBOutlet UILabel *magLabel;
    IBOutlet UILabel *placeLabel;
    IBOutlet UILabel *datetimeLabel;
}

@property (strong,nonatomic) NSNumber * mag;
@property (strong,nonatomic) NSNumber * lat;
@property (strong,nonatomic) NSNumber * lng;
@property (strong,nonatomic) NSNumber * dpt;
@property (strong,nonatomic) NSString * place;
@property (strong,nonatomic) NSNumber * time;

@end
