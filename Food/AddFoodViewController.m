//
//  AddFoodViewController.m
//  Food
//
//  Created by Vidya Ramamurthy on 23/12/15.
//  Copyright © 2015 BridgeLabz. All rights reserved.
//



#import "AddFoodViewController.h"

@interface AddFoodViewController ()

@end

@implementation AddFoodViewController
@synthesize foodTextField;
@synthesize RestaurantTextField;
@synthesize ratingController;
@synthesize locationLable;
@synthesize activityIndicator;

@synthesize foodTableViewController;
@synthesize locationManager;
@synthesize imageView;
@synthesize storedImage;
//@synthesize imageArray;
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
    //Fetching Location
    if(locationManager==nil)
    {
        
        [locationManager requestWhenInUseAuthorization];
        locationManager=[[CLLocationManager alloc]init];
        locationManager.delegate=self;
        [locationManager requestWhenInUseAuthorization];
        locationManager.desiredAccuracy=kCLLocationAccuracyKilometer;
        locationManager.pausesLocationUpdatesAutomatically=NO;
        locationManager.activityType=CLActivityTypeFitness;
     
    }

    [locationManager startUpdatingLocation];
    [activityIndicator startAnimating];
    locationLable.text=@"Updating Location";
}
#pragma mark-location manager delegate method
//If have any error change this method
// For updating Location.
-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    [activityIndicator stopAnimating];
    locationLable.text=@"location received";
}



- (void)locationManager:(CLLocationManager *)manager didFailWithError:(nonnull NSError *)error
{
    [activityIndicator stopAnimating];
    locationLable.text=@"Location Error";
}



- (IBAction)AddFoodButtonPressed:(id)sender {
    [locationManager stopUpdatingLocation];
    // Saving data
    NSString *newFoodName=[foodTextField text];
    NSString *newRestaurantName=[RestaurantTextField text];
    UIImage *someImage=[UIImage imageNamed:@"latte.jpg"];
    NSData *imageData = UIImagePNGRepresentation(someImage);
    NSString *rating=@"Ok";
    
    if([ratingController selectedSegmentIndex]==0)
    {
       rating=@"Good";
    }
    else if([ratingController selectedSegmentIndex]==1)
    {
     rating=@"Bad";
    }
    
    NSNumber *longitudeNumber=[NSNumber numberWithFloat:0.0];
    NSNumber *latitudeNumber=[NSNumber numberWithFloat:0.0];
    
    if (locationManager.location!=nil) {
        
        CLLocationCoordinate2D currentCoordinate=locationManager.location.coordinate;
        longitudeNumber=[NSNumber numberWithFloat:currentCoordinate.longitude];
        latitudeNumber=[NSNumber numberWithFloat:currentCoordinate.latitude];

    }
    
    NSDictionary *newFood=[[NSDictionary alloc]initWithObjectsAndKeys:newFoodName,kFoodName,newRestaurantName,kRestaurantName,rating,kRating,latitudeNumber ,kLatitude,longitudeNumber ,kLongitude,storedImage,aKeyForYourImage,nil];
    NSDictionary *newImage=[[NSDictionary alloc]initWithObjectsAndKeys:imageData,aKeyForYourImage,nil];
    //
//storing data to array
    [foodTableViewController addFood :newFood];
    [foodTableViewController addImage:newImage];
    
    [[self presentingViewController] dismissViewControllerAnimated:YES completion:nil] ;
     
     }

- (IBAction)AddImage:(id)sender {

    UIImagePickerController *imagePicker=[[UIImagePickerController alloc]init];
    [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [imagePicker setDelegate:self];
    [self presentViewController:imagePicker animated:YES completion:NULL];
}


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
//Adding image
    
    UIImage *image=[info objectForKey:UIImagePickerControllerOriginalImage];
    UIImageView *newImageView=[[UIImageView alloc]initWithImage:image];
    [newImageView setFrame:CGRectMake(0,0, 80, 80)];

    [self dismissViewControllerAnimated:YES completion:^{
       
    [imageView addSubview:newImageView];
        
    storedImage=[newImageView image];

            }];


}

@end
