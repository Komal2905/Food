//
//  TableViewController.m
//  Food
//
//  Created by Vidya Ramamurthy on 22/12/15.
//  Copyright © 2015 BridgeLabz. All rights reserved.
//

#import "TableViewController.h"
#import "AddFoodViewController.h"
#import "DetailVC.h"
@interface TableViewController ()

@end

@implementation TableViewController
@synthesize foodArray;
@synthesize imageArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(saveData:) name:UIApplicationDidEnterBackgroundNotification  object:nil];
    
    
    NSString *homeDirectory=NSHomeDirectory();
   NSString *filePath=[homeDirectory stringByAppendingString:@"/Documents/food.plist"];
   // NSString *imageFilePath=@"/Users/BridgeLabz/Documents/komal/IOS";
    NSString *imageFilePath=[homeDirectory stringByAppendingString:@"/Documents/imageInfo.plist"];
    NSLog(@"FIle Path %@", filePath);
    NSLog(@"Image Info %@",imageFilePath);
    
    
    if([[NSFileManager defaultManager] fileExistsAtPath:filePath])
    {
        foodArray=[[NSMutableArray alloc]initWithContentsOfFile:filePath ];
        NSLog(@"Plist here %@",foodArray);
    }
    else
    {
    
    NSDictionary *firstFoodDictionary=[[NSDictionary alloc]initWithObjectsAndKeys:@"Pizza",kFoodName,@"Pizza Place",kRestaurantName,@"good",kRating,nil];
    //foodArray=[[NSMutableArray alloc]initWithObjects:@"Pizza",@"Sandwiches",@"Hot Dog",@"Bacon", nil];
    foodArray=[[NSMutableArray alloc]initWithObjects:firstFoodDictionary, nil];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    }
    //---FOr Image
    if([[NSFileManager defaultManager] fileExistsAtPath:imageFilePath])
    {
        imageArray=[[NSMutableArray alloc]initWithContentsOfFile:imageFilePath ];
       // NSLog(@"Image List here in if  %@",imageArray);
    }
    else
    {
        
        NSDictionary *firstImageDictionary=[[NSDictionary alloc]initWithObjectsAndKeys:@"Image",aKeyForYourImage,nil];
        //foodArray=[[NSMutableArray alloc]initWithObjects:@"Pizza",@"Sandwiches",@"Hot Dog",@"Bacon", nil];
        imageArray=[[NSMutableArray alloc]initWithObjects:firstImageDictionary, nil];
         //NSLog(@"Image List here in esle  %@",imageArray);
        // Uncomment the following line to preserve selection between presentations.
        // self.clearsSelectionOnViewWillAppear = NO;
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    }

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   // NSLog(@"Array %@",[foodArray objectAtIndex:2]);
    NSLog(@"Array count %lu",(unsigned long)[foodArray count]);
   return [foodArray count];
    //return 2 ;
 
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    
    if([[segue identifier]isEqualToString:@"AddFoodSegue"])
    {
    AddFoodViewController *addFoodViewController=[segue destinationViewController];
    [addFoodViewController setFoodTableViewController:self];
    }
    else if([[segue identifier]isEqualToString:@"detailSegue"])
    {
        NSIndexPath *selectedRow=[[self tableView] indexPathForSelectedRow];
        NSDictionary *selectedFood=[foodArray objectAtIndex:[selectedRow row]];
      DetailVC  *detailVc=[segue destinationViewController];
        [detailVc setFood:selectedFood];
        
    }
       
    
}

-(void)addFood:(NSDictionary *)newFood
{
    [foodArray addObject:newFood];
    [[self tableView] reloadData];
    
        NSLog(@"Addig food");
}


-(void)addImage:(NSDictionary *)newImage
{
    [imageArray addObject:newImage];
    [[self tableView] reloadData];
    NSLog(@"Ading Image");
}

-(void)saveData:(NSNotification *)notification
{
    
    NSLog(@"Save Data");
    NSString *homeDirectory=NSHomeDirectory();
    NSLog(@"Home%@", homeDirectory);
    NSString *filePath=[homeDirectory stringByAppendingString:@"/Documents/food.plist"];
    NSLog(@"Save Data %@",filePath);
     NSString *imageFilePath=[homeDirectory stringByAppendingString:@"/Documents/imageInfo.plist"];
    // NSString *imageFilePath=@"/Users/BridgeLabz/Documents/komal/IOS";
    [foodArray writeToFile:filePath atomically:YES];
    [imageArray writeToFile:imageFilePath atomically:YES];
    NSLog(@"FILE PATH%@ ",imageFilePath);
    NSLog(@"Image %@",imageArray);
   

//    [dictionary setObject:image forKey:@"image"];
//    [NSKeyedArchiver archiveRootObject:dictionary toFile:path];
    

}


//-(void)saveImageData:(NSNotification *)notification;
//{
//    
//    NSLog(@"Save Data");
//    NSString *homeDirectory=NSHomeDirectory();
//    NSLog(@"HOme%@", homeDirectory);
//    NSString *filePath=[homeDirectory stringByAppendingString:@"/Documents/food.plist"];
//    NSLog(@"Save Data %@",filePath);
//    NSString *imageFilePath=[homeDirectory stringByAppendingString:@"/Documents/imageInfo.plist"];
//    [foodArray writeToFile:filePath atomically:YES];
//    [imageArray writeToFile:imageFilePath atomically:YES];
//    
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndetifier=@"BasicCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndetifier forIndexPath:indexPath];
    
    int rowNumber=[indexPath row];
    
    NSDictionary *foodDictionary=[foodArray objectAtIndex:rowNumber];
    NSString *food=[foodDictionary objectForKey:kFoodName];
    NSString *restaurant=[foodDictionary objectForKey:kRestaurantName];
    
  //  NSDictionary *imageDictionary=[foodArray objectAtIndex:rowNumber];
    
    
   // NSString *food=[foodArray objectAtIndex:rowNumber];
    [[cell textLabel] setText:food];
    [[cell detailTextLabel] setText:restaurant];
    NSLog(@"table view is asking for cell %d",[indexPath row]);
    if(cell ==nil)
   {
     cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndetifier];
  }
//
//    // Configure the cell...
    
    cell.imageView.image=[foodDictionary objectForKey:aKeyForYourImage];
//    
   return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        
         [foodArray removeObjectAtIndex:[indexPath row]];
         NSLog(@"Deleted Item");
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
       
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
