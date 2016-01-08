//
//  SummaryTableViewController.m
//  earthquakemonitor
//
//  Created by Alejandro Saldivar on 1/7/16.
//  Copyright © 2016 Alejandro Saldivar. All rights reserved.
//

#import "SummaryTableViewController.h"
#import "DetailViewController.h"
#import "Feature.h"

@interface SummaryTableViewController () {
    NSMutableData *webData;
    NSURLConnection *connection;
    NSMutableArray *arrayForEntry;
}
@end

@implementation SummaryTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    arrayForEntry = [[NSMutableArray alloc]init];
    [self getfeed];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
    return [arrayForEntry count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    Feature *obj = [arrayForEntry objectAtIndex:indexPath.row];
    
    NSString *mag = [NSString stringWithFormat:@"%@", obj.mag];
    
    cell.textLabel.text = mag;
    cell.detailTextLabel.text = obj.place;
    
    long red = ((255 * [obj.mag integerValue])/10);
    long green = ((255 * (10 - [obj.mag integerValue]))/10);
    long blue = 0;
        
    UIColor *cellBackgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    cell.backgroundColor = cellBackgroundColor;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    DetailViewController * DVC = [[DetailViewController alloc]init];
    DVC = [segue destinationViewController];
    NSIndexPath * path = [self.tableView indexPathForSelectedRow];
    Feature *obj = [arrayForEntry objectAtIndex:path.row];
    DVC.mag = obj.mag;
    DVC.lat = obj.lat;
    DVC.lng = obj.lng;
    DVC.dpt = obj.dpt;
    DVC.place = obj.place;
    DVC.time = obj.time;
    
    [DVC setHidesBottomBarWhenPushed:YES];
    self.hidesBottomBarWhenPushed=NO;
}


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [webData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [webData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"fail with error");
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSDictionary *allDataDictionary = [NSJSONSerialization JSONObjectWithData:webData options:0 error:nil];
    
    NSDictionary *metadata = [allDataDictionary objectForKey:@"metadata"];
    
    NSDictionary *size = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"Arial" size:15.0],NSFontAttributeName, nil];
    
    self.navigationController.navigationBar.titleTextAttributes = size;
    
    self.title = [metadata objectForKey:@"title"];
    
    NSDictionary *features = [allDataDictionary objectForKey:@"features"];
    
    for (NSDictionary *diction in features) {
        
        Feature *myFeature = [[Feature alloc]init];
        
        NSDictionary *properties = [diction objectForKey:@"properties"];
        
        myFeature.mag = [properties objectForKey:@"mag"];
        myFeature.place = [properties objectForKey:@"place"];
        myFeature.time = [properties objectForKey:@"time"];
        
        NSDictionary *geometry = [diction objectForKey:@"geometry"];
        NSArray *coordinates = [geometry objectForKey:@"coordinates"];
        myFeature.lat = [coordinates objectAtIndex:0];
        myFeature.lng = [coordinates objectAtIndex:1];
        myFeature.dpt = [coordinates objectAtIndex:2];

        [arrayForEntry addObject:myFeature];
    }

    [[self tableView]reloadData];

}

- (IBAction)getfeed {
    [arrayForEntry removeAllObjects];
    NSURL *url = [NSURL URLWithString:@"http://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_hour.geojson"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    connection = [NSURLConnection connectionWithRequest:request delegate:self];
    
    if(connection)
    {
        webData = [[NSMutableData alloc]init];
    }
}

- (IBAction)refresh:(UIRefreshControl *)sender {
    [self getfeed];
    [sender endRefreshing];
}


@end
