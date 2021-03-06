//
//  DetailVC.m
//  Food
//
//  Created by Vidya Ramamurthy on 23/12/15.
//  Copyright © 2015 BridgeLabz. All rights reserved.
//

#import "DetailVC.h"
#import "TableViewController.h"
@interface DetailVC ()

@end

@implementation DetailVC
@synthesize foodLable;
@synthesize restaurantLable;
@synthesize food;
@synthesize ratingLable;
@synthesize mapView;
@synthesize getImageView;
@synthesize imageA;

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//setting Lable
    [foodLable setText:[food objectForKey:kFoodName]];
    [restaurantLable setText:[food objectForKey:kRestaurantName]];
    NSString *foodRatin=[food objectForKey:kRating];
    NSString *foodRatingStatement=[[NSString alloc]initWithFormat:@"The food is %@ ",foodRatin];
    [ratingLable setText:foodRatingStatement];
    
//setting Image
    UIImage *imgAgain = [imageA objectForKey:aKeyForYourImage];
    UIImageView *newImageView1=[[UIImageView alloc]initWithImage:imgAgain];
    [newImageView1 setFrame:CGRectMake(80,80, 80, 80)];
    [getImageView addSubview:newImageView1];
    getImageView.image=[food objectForKey:aKeyForYourImage];
// For mapView
    NSNumber *latitude=[food objectForKey:kLatitude];
    NSNumber *longitude=[food objectForKey:kLongitude];
    MKCoordinateRegion region;
    region.span= MKCoordinateSpanMake(0.02, 0.02);
    region.center=CLLocationCoordinate2DMake([latitude floatValue], [longitude floatValue]);
    [mapView setRegion:region];
  
    
}




@end
