//
//  MapPin.h
//  earthquakemonitor
//
//  Created by Alejandro Saldivar on 1/7/16.
//  Copyright © 2016 Alejandro Saldivar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MapPin : NSObject<MKAnnotation>{
    NSString *title;
    NSString *subtitle;
    CLLocationCoordinate2D coordinate;
}

@property (nonatomic,copy)NSString *title;
@property (nonatomic,copy)NSString *subtitle;
@property (nonatomic,assign)CLLocationCoordinate2D coordinate;

@end
