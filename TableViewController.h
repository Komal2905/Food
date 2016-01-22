//
//  TableViewController.h
//  Food
//
//  Created by Vidya Ramamurthy on 22/12/15.
//  Copyright © 2015 BridgeLabz. All rights reserved.
//

#import <UIKit/UIKit.h>
// Define Constatnt which will use as Key in Dictionary
#define kFoodName @"FoodName"
#define kRestaurantName @"RestaurantName"
#define kRating @"Rating"
#define kLatitude @"Latitude"
#define kLongitude @"Longitude"
#define aKeyForYourImage @"aKeyForYourImage"

@interface TableViewController : UITableViewController
@property (nonatomic,strong) NSMutableArray *foodArray;
@property(nonatomic,strong) NSMutableArray *imageArray;;
-(void)addFood:(NSDictionary *)newFood;
-(void)saveData:(NSNotification *)notification;

-(void)addImage:(NSDictionary *)newImage;



@end
