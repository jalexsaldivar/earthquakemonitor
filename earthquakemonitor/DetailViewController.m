//
//  DetailViewController.m
//  earthquakemonitor
//
//  Created by Alejandro Saldivar on 1/6/16.
//  Copyright © 2016 Alejandro Saldivar. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController () {
    IBOutlet MKMapView *mapView;
}

@end

@implementation DetailViewController
@synthesize mag,lat,lng,dpt,place,time;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *magText = [NSString stringWithFormat:@"Magnitud: %@", mag];
    NSString *magTxt = [NSString stringWithFormat:@"%@", mag];
    
    magLabel.text = magText;
    
    NSString *placeText = [NSString stringWithFormat:@"Location: %@, %@, %@ \n%@ ", lat, lng, dpt, place];
    
    placeLabel.text = placeText;
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[time doubleValue]/1000.0];
    
    NSString *datetimeText = [NSString stringWithFormat:@"Time: %@", date];
    
    double latd = [lat doubleValue];
    double lngd = [lng doubleValue];
    
    datetimeLabel.text = datetimeText;
    
    MKCoordinateRegion region = {{0.0,0.0},{0.0,0.0}};
    region.center.latitude = lngd;
    region.center.longitude = latd;
    region.span.latitudeDelta = 5.0f;
    region.span.longitudeDelta = 5.0f;
    [mapView setRegion:region animated:YES];
    MapPin *ann = [[MapPin alloc]init];
    ann.title = magTxt;
    ann.subtitle = place;
    ann.coordinate = region.center;
    [mapView addAnnotation:ann];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
