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
    
      // Do any additional setup after loading the view.
    
 
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
#pragma mark-View lifecycle


-(void)viewWillAppear:(BOOL)animated
{
   // NSLog(@"Status %d",authorizationStatus());
    
    [super viewWillAppear:animated];
    
    //-----Uncomment
    
    
    if(locationManager==nil)
    {
        
         [locationManager requestWhenInUseAuthorization];
        
        locationManager=[[CLLocationManager alloc]init];
        locationManager.delegate=self;
        [locationManager requestWhenInUseAuthorization];

      //[locationManager requestWhenInUseAuthorization];//SO ImP
        
       
        locationManager.desiredAccuracy=kCLLocationAccuracyKilometer;
        //locationManager.significantLocationChangeMonitoringAvailable=kCLLocationAccuracyKilometer;
        locationManager.pausesLocationUpdatesAutomatically=NO;
        locationManager.activityType=CLActivityTypeFitness;
        
        //locationManager.purpose=@"location is set for lacation of restaurarnt";
        
    }
    

    [locationManager startUpdatingLocation];
    [activityIndicator startAnimating];
    locationLable.text=@"Updating Location";
}
#pragma mark-location manager delegate method
//If have any error change this method
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
//    [loacationManager startUpdatingLocation];
    [locationManager stopUpdatingLocation];
    
    NSString *newFoodName=[foodTextField text];
    NSString *newRestaurantName=[RestaurantTextField text];
    
    //UIImage *someImage=[imageView image];//review
     UIImage *someImage=[UIImage imageNamed:@"latte.jpg"];
    NSLog(@"some imAGE  %@",someImage);
    
    NSData *imageData = UIImagePNGRepresentation(someImage);
   // NSLog(@"NSDATA ImageData %@",imageData);
   // [imageArray addObject:data];
    //[imageArray writeToFile:plistPath atomically:YES];
    
    NSString *rating=@"ok";
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
        //CLLocation *currentLocation=locationManager.location;
        CLLocationCoordinate2D currentCoordinate=locationManager.location.coordinate;
        longitudeNumber=[NSNumber numberWithFloat:currentCoordinate.longitude];
        latitudeNumber=[NSNumber numberWithFloat:currentCoordinate.latitude];

    }
    
    NSDictionary *newFood=[[NSDictionary alloc]initWithObjectsAndKeys:newFoodName,kFoodName,newRestaurantName,kRestaurantName,rating,kRating,latitudeNumber ,kLatitude,longitudeNumber ,kLongitude,storedImage,aKeyForYourImage,nil];
    NSDictionary *newImage=[[NSDictionary alloc]initWithObjectsAndKeys:imageData,aKeyForYourImage,nil];
    //
    
    
    
    [foodTableViewController addFood :newFood];
    
    
    [foodTableViewController addImage:newImage];
    [[self presentingViewController] dismissViewControllerAnimated:YES completion:nil] ;
     
     }






- (IBAction)AddImage:(id)sender {
    
    
//    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:1];
//    UIImage *img = [UIImage imageNamed:@"latte.jpg"];
//    [dict setObject:img forKey:@"aKeyForYourImage"];
//    
//    UIImage *imgAgain = [dict objectForKey:@"aKeyForYourImage"];
//    UIImageView *newImageView1=[[UIImageView alloc]initWithImage:imgAgain];
//        [newImageView1 setFrame:CGRectMake(80,80, 80, 80)];
//    
//       // [self dismissViewControllerAnimated:YES completion:^{
//    
//            [imageView addSubview:newImageView1];
//            NSLog(@"A");
//        //}];
//    
//    //[NSKeyedArchiver archiveRootObject:dict toFile:@"/Users/BridgeLabz/Library/Developer/CoreSimulator/Devices/39CF1665-25B2-462D-A0CB-1437928173E5/data/Containers/Data/Application/A8AB364D-DC50-41C4-B02E-C92CD4F5BB0D/Documents/imageInfo.plist"];

    
    
    
    UIImagePickerController *imagePicker=[[UIImagePickerController alloc]init];
    [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [imagePicker setDelegate:self];
    [self presentViewController:imagePicker animated:YES completion:NULL];

    NSLog(@"After");
    
    
//    UIImageView *newImageView1=[[UIImageView alloc]initWithImage:new];
//    [newImageView1 setFrame:CGRectMake(80,80, 80, 80)];
//    
//    [self dismissViewControllerAnimated:YES completion:^{
//        
//        [imageView addSubview:newImageView1];
//        NSLog(@"A");
//    }];
//    
   
    
}


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{//ading image
    
    UIImage *image=[info objectForKey:UIImagePickerControllerOriginalImage];
    UIImageView *newImageView=[[UIImageView alloc]initWithImage:image];
    [newImageView setFrame:CGRectMake(0,0, 80, 80)];

    [self dismissViewControllerAnimated:YES completion:^{
       
       [imageView addSubview:newImageView];
        
        storedImage=[newImageView image];

            }];
    
    
    
    
    //--
      //--
//  NSLog(@"After");
//    
//       UIImage *image=[UIImage imageNamed:@"latte"];
//    
//      NSData *imageData = UIImagePNGRepresentation(image);
//    UIImage *new=[UIImage imageWithData:imageData];
//    UIImageView *newImageView1=[[UIImageView alloc]initWithImage:new];
//    [newImageView1 setFrame:CGRectMake(80,80, 80, 80)];
//    
//    [self dismissViewControllerAnimated:YES completion:^{
//        
//        [imageView addSubview:newImageView1];
//        NSLog(@"A");
//    }];

}

@end
