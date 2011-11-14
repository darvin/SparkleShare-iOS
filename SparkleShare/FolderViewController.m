//
//  FolderViewController.m
//  SparkleShare
//
//  Created by Sergey Klimov on 13.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "FolderViewController.h"
#import "FileViewController.h"
#import "GitInfoFormatter.h"
#import "SSFolder.h"
#import "SSRootFolder.h"
#import "SSFile.h"
#import "FileSizeFormatter.h"
#import "UIColor+ApplicationColors.h"
#import "SVProgressHUD.h"
@implementation FolderViewController
@synthesize folder=_folder;


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.tintColor = [UIColor navBarColor];

    self.clearsSelectionOnViewWillAppear = NO;

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [SVProgressHUD show];
    [self.folder loadItems];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source


// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.folder.items count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"FolderCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    SSItem* item = [self.folder.items objectAtIndex:indexPath.row];
    cell.textLabel.text = item.name;
    if ([item isKindOfClass:[SSFolder class]]){
        if ([self.folder isKindOfClass:[SSRootFolder class]])
        {
            cell.detailTextLabel.text = [NSString stringWithFormat:@"rev %@   %d items",[GitInfoFormatter stringFromGitRevision:((SSRootFolder*)item).revision], ((SSRootFolder*)item).count];
        }else {
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%d items", ((SSFolder*)item).count];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    }
    else if ([item isKindOfClass:[SSFile class]]){
        FileSizeFormatter* sizeFormatter = [[FileSizeFormatter alloc] init];
        NSString* sizeString = [sizeFormatter stringFromNumber: [NSNumber numberWithInt: ((SSFile*)item).filesize ]];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@  %@", 
                                     ((SSFile*)item).mime, sizeString];
        cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    }
        
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SSItem* item = [self.folder.items objectAtIndex:indexPath.row];
    if ([item isKindOfClass:[SSFolder class]]){
        FolderViewController *newFolderViewController = [[FolderViewController alloc] initWithFolder:(SSFolder*)item];
        [self.navigationController pushViewController:newFolderViewController animated:YES];
    } else if ([item isKindOfClass:[SSFile class]]) {
        SSFile* file = (SSFile*)item;
        file.delegate = self;
        [SVProgressHUD show];
        [file loadContent];
    }
}


#pragma mark - SSFolder stuff
- (id)initWithFolder:(SSFolder*) folder{
    if (self = [super init]) {
        self.folder = folder;
        self.folder.delegate = self;
        self.folder.infoDelegate = self;
        self.title = self.folder.name;
    }
    return self;
}


-(void) folder:(SSFolder*) folder itemsLoaded:(NSArray*) items
{
    [self.tableView reloadData];
    for (SSItem* item in self.folder.items) {
        if ([item isKindOfClass:[SSFolder class]]) {
            SSFolder* folder = (SSFolder*)item;
            folder.infoDelegate = self;
            [folder loadRevision];
            [folder loadCount];
        }
    }
    [SVProgressHUD dismiss];
}
-(void) reloadOneItem:(SSItem*) item
{
    int i = [self.folder.items indexOfObject:item];
    
    NSIndexPath* indexPath = [NSIndexPath indexPathForRow:i inSection:0]; 
    
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
-(void) folderLoadingFailed:(SSFolder*) folder
{
    [SVProgressHUD dismiss];
}
-(void) folder:(SSFolder*) folder countLoaded:(int) count
{
    [self reloadOneItem:folder];
}

-(void) folder:(SSFolder*) folder revisionLoaded:(NSString*) revision
{
    [self reloadOneItem:folder];
}
-(void) folder:(SSFolder*) folder overallCountLoaded:(int) count
{
    [self reloadOneItem:folder];
}
-(void) folderInfoLoadingFailed:(SSFolder*) folder
{
}





-(void) file:(SSFile*) file contentLoaded:(NSData*) content
{
    
    FilePreview* filePreview = [[FilePreview alloc] initWithFile:file];
    
    FileViewController* newFileViewController = [[FileViewController alloc] initWithFilePreview:filePreview filename:file.name];
    [SVProgressHUD dismiss];
    [self.navigationController pushViewController:newFileViewController animated:YES];
}

-(void) fileContentLoadingFailed:(SSFile*) file
{
    [SVProgressHUD dismiss];
}


@end
