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
    
// Getting Home Directory
    NSString *homeDirectory=NSHomeDirectory();
    NSString *filePath=[homeDirectory stringByAppendingString:@"/Documents/food.plist"];
   
    NSString *imageFilePath=[homeDirectory stringByAppendingString:@"/Documents/imageInfo.plist"];
    NSLog(@"File Path %@", filePath);
    NSLog(@"Image Info %@",imageFilePath);
    
// For checking whether file is exists or not ; if Exists then intialize foodArray with its content
    if([[NSFileManager defaultManager] fileExistsAtPath:filePath])
    {
        foodArray=[[NSMutableArray alloc]initWithContentsOfFile:filePath ];
       
    }
    else
    {
// if file not exist then create new dictionary, intialize its data
    NSDictionary *firstFoodDictionary=[[NSDictionary alloc]initWithObjectsAndKeys:@"Pizza",kFoodName,@"Pizza Place",kRestaurantName,@"good",kRating,nil];
    
        
// intialize foodArray with content of dictionary
    foodArray=[[NSMutableArray alloc]initWithObjects:firstFoodDictionary, nil];
  
     self.clearsSelectionOnViewWillAppear = NO;
    }
//---For Image
    if([[NSFileManager defaultManager] fileExistsAtPath:imageFilePath])
    {
        imageArray=[[NSMutableArray alloc]initWithContentsOfFile:imageFilePath ];
      
    }
    else
    {
        NSDictionary *firstImageDictionary=[[NSDictionary alloc]initWithObjectsAndKeys:@"Image",aKeyForYourImage,nil];
                imageArray=[[NSMutableArray alloc]initWithObjects:firstImageDictionary, nil];
        self.clearsSelectionOnViewWillAppear = NO;
       
         self.navigationItem.rightBarButtonItem = self.editButtonItem;
    }

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
// -- Table View


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
    NSLog(@"Array count %lu",(unsigned long)[foodArray count]);
   return [foodArray count];
    
 
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIndetifier=@"BasicCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndetifier forIndexPath:indexPath];
    
    int rowNumber=[indexPath row];
    NSDictionary *foodDictionary=[foodArray objectAtIndex:rowNumber];
    NSString *food=[foodDictionary objectForKey:kFoodName];
    NSString *restaurant=[foodDictionary objectForKey:kRestaurantName];
    
    
    [[cell textLabel] setText:food];
    [[cell detailTextLabel] setText:restaurant];
    NSLog(@"table view is asking for cell %d",[indexPath row]);
    if(cell ==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndetifier];
    }
    
    // Configure the cell...
    
    cell.imageView.image=[foodDictionary objectForKey:aKeyForYourImage];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [foodArray removeObjectAtIndex:[indexPath row]];
    
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:
         UITableViewRowAnimationFade];
        
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}



// when user click on ADD Button or click on Cell , segue define which view to display
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    // segue for Adding Foodd
    if([[segue identifier]isEqualToString:@"AddFoodSegue"])
    {
    AddFoodViewController *addFoodViewController=[segue destinationViewController];
    [addFoodViewController setFoodTableViewController:self];
    }
    // segue for detail of food
    else if([[segue identifier]isEqualToString:@"detailSegue"])
    {
        NSIndexPath *selectedRow=[[self tableView] indexPathForSelectedRow];
        NSDictionary *selectedFood=[foodArray objectAtIndex:[selectedRow row]];
        DetailVC  *detailVc=[segue destinationViewController];
        [detailVc setFood:selectedFood];
        
    }
       
    
}
// store user input to Array
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

// notification to observer
-(void)saveData:(NSNotification *)notification
{
    
    NSString *homeDirectory=NSHomeDirectory();
    NSLog(@"Home%@", homeDirectory);
    NSString *filePath=[homeDirectory stringByAppendingString:@"/Documents/food.plist"];
    NSLog(@"Save Data %@",filePath);
    NSString *imageFilePath=[homeDirectory stringByAppendingString:@"/Documents/imageInfo.plist"];
    [foodArray writeToFile:filePath atomically:YES];
    [imageArray writeToFile:imageFilePath atomically:YES];
    NSLog(@"FILE PATH %@ ",imageFilePath);
    NSLog(@"Image %@",imageArray);
   

}







@end
