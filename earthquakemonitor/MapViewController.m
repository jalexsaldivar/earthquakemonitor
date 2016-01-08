//
//  MapViewController.m
//  earthquakemonitor
//
//  Created by Alejandro Saldivar on 1/6/16.
//  Copyright © 2016 Alejandro Saldivar. All rights reserved.
//

#import "MapViewController.h"
#import "Feature.h"

@interface MapViewController () {
    NSMutableData *webData;
    NSURLConnection *connection;
    NSMutableArray *arrayForEntry;
    IBOutlet MKMapView *mapView;
}

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    arrayForEntry = [[NSMutableArray alloc]init];
    [self getfeed];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [webData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [webData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"fail with error");
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSDictionary *allDataDictionary = [NSJSONSerialization JSONObjectWithData:webData options:0 error:nil];
    
    NSDictionary *features = [allDataDictionary objectForKey:@"features"];
    
    for (NSDictionary *diction in features) {
        
        Feature *myFeature = [[Feature alloc]init];
        
        NSDictionary *properties = [diction objectForKey:@"properties"];
        
        myFeature.mag = [properties objectForKey:@"mag"];
        myFeature.place = [properties objectForKey:@"place"];
        myFeature.time = [properties objectForKey:@"time"];
        
        NSDictionary *geometry = [diction objectForKey:@"geometry"];
        NSArray *coordinates = [geometry objectForKey:@"coordinates"];
        myFeature.lat = [coordinates objectAtIndex:0];
        myFeature.lng = [coordinates objectAtIndex:1];
        myFeature.dpt = [coordinates objectAtIndex:2];
        
        [arrayForEntry addObject:myFeature];
    }

    for (int i = 0; i < [arrayForEntry count]; i++) {
        Feature *obj = [arrayForEntry objectAtIndex:i];
        
        NSString *magTxt = [NSString stringWithFormat:@"%@", obj.mag];
        
        double latd = [obj.lat doubleValue];
        double lngd = [obj.lng doubleValue];
        
        MKCoordinateRegion region = {{0.0,0.0},{0.0,0.0}};
        region.center.latitude = lngd;
        region.center.longitude = latd;
        region.span.latitudeDelta = 100.0f;
        region.span.longitudeDelta = 100.0f;
        [mapView setRegion:region animated:YES];
        MapPin *ann = [[MapPin alloc]init];
        ann.title = magTxt;
        ann.subtitle = obj.place;
        ann.coordinate = region.center;
        [mapView addAnnotation:ann];
        
    }
    
    
}

- (IBAction)getfeed {
    [arrayForEntry removeAllObjects];
    NSURL *url = [NSURL URLWithString:@"http://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_hour.geojson"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    connection = [NSURLConnection connectionWithRequest:request delegate:self];
    
    if(connection)
    {
        webData = [[NSMutableData alloc]init];
    }
}


@end
