//
//  AddFoodViewController.h
//  Food
//
//  Created by Vidya Ramamurthy on 23/12/15.
//  Copyright © 2015 BridgeLabz. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "TableViewController.h"




@interface AddFoodViewController : UIViewController<CLLocationManagerDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>


@property (nonatomic,weak) TableViewController *foodTableViewController;

@property (weak, nonatomic) IBOutlet UITextField *foodTextField;
- (IBAction)AddFoodButtonPressed:(id)sender;

@property (weak, nonatomic) IBOutlet UISegmentedControl *ratingController;
@property (weak, nonatomic) IBOutlet UILabel *locationLable;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (weak, nonatomic) IBOutlet UITextField *RestaurantTextField;

@property (nonatomic,strong) CLLocationManager *locationManager;
- (IBAction)AddImage:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

- (IBAction)show:(id)sender;
@property UIImage *storedImage;


@end
