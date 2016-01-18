//
//  DetailVC.h
//  Food
//
//  Created by Vidya Ramamurthy on 23/12/15.
//  Copyright © 2015 BridgeLabz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>


@interface DetailVC : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *foodLable;
@property (weak, nonatomic) IBOutlet UILabel *restaurantLable;
@property (nonatomic, strong) NSDictionary *food;
@property (nonatomic, strong) NSDictionary *imageA;
@property (weak, nonatomic) IBOutlet UIImageView *getImageView;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property (weak, nonatomic) IBOutlet UILabel *ratingLable;

//@property (nonatomic, strong) NSMutableArray *imageArray;


@end
