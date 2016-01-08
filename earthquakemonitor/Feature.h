//
//  Feature.h
//  earthquakemonitor
//
//  Created by Alejandro Saldivar on 1/7/16.
//  Copyright © 2016 Alejandro Saldivar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Feature : NSObject
{
    NSNumber *mag;
    NSNumber *lat;
    NSNumber *lng;
    NSNumber *dpt;
    NSString *place;
    NSNumber *time;
}

@property(nonatomic, retain) NSNumber *mag;
@property(nonatomic, retain) NSNumber *lat;
@property(nonatomic, retain) NSNumber *lng;
@property(nonatomic, retain) NSNumber *dpt;
@property(nonatomic, retain) NSString *place;
@property(nonatomic, retain) NSNumber *time;
@end
