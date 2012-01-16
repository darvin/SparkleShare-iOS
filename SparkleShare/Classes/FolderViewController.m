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
#import "SSFolderItem.h"
#import "FileSizeFormatter.h"
#import "UIColor+ApplicationColors.h"
#import "SVProgressHUD.h"
#import "UIViewController+AutoPlatformNibName.h"
#import "UIImage+FileType.h"

@implementation FolderViewController
@synthesize folder = _folder, iconSize = _iconSize;


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
	[super viewDidLoad];
	self.navigationController.navigationBar.tintColor = [UIColor navBarColor];

	self.clearsSelectionOnViewWillAppear = NO;
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)])
        self.iconSize = 40*[[UIScreen mainScreen] scale];
    else
        self.iconSize = 40;
    
}

- (void)viewDidUnload {
	[super viewDidUnload];
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

- (void)viewWillAppear: (BOOL) animated {
	[super viewWillAppear: animated];
	[SVProgressHUD show];
	[self.folder loadItems];
}

- (void)viewDidAppear: (BOOL) animated {
	[super viewDidAppear: animated];
}

- (void)viewWillDisappear: (BOOL) animated {
	[super viewWillDisappear: animated];
}

- (void)viewDidDisappear: (BOOL) animated {
	[super viewDidDisappear: animated];
}


- (BOOL)shouldAutorotateToInterfaceOrientation: (UIInterfaceOrientation) interfaceOrientation {
	return YES;
}

#pragma mark - Table view data source


// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView: (UITableView *) tableView {
	return 1;
}

- (NSInteger)tableView: (UITableView *) tableView numberOfRowsInSection: (NSInteger) section {
	return [self.folder.items count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView: (UITableView *) tableView cellForRowAtIndexPath: (NSIndexPath *) indexPath {
	static NSString *CellIdentifier = @"FolderCell";

	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier];
	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleSubtitle reuseIdentifier: CellIdentifier];
	}

	SSFolderItem *item = [self.folder.items objectAtIndex: indexPath.row];
	cell.textLabel.text = item.name;
	if ([item isKindOfClass: [SSFolder class]]) {
		if ([self.folder isKindOfClass: [SSRootFolder class]]) {
			cell.detailTextLabel.text = [NSString stringWithFormat: @"rev %@   %d items", [GitInfoFormatter stringFromGitRevision: ( (SSRootFolder *)item ).revision], ( (SSRootFolder *)item ).count];
		}
		else {
			cell.detailTextLabel.text = [NSString stringWithFormat: @"%d items", ( (SSFolder *)item ).count];
		}
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}
	else if ([item isKindOfClass: [SSFile class]]) {
		FileSizeFormatter *sizeFormatter = [[FileSizeFormatter alloc] init];
		NSString *sizeString = [sizeFormatter stringFromNumber: [NSNumber numberWithInt: ( (SSFile *)item ).filesize]];
		cell.detailTextLabel.text = [NSString stringWithFormat: @"%@  %@",
		                             ( (SSFile *)item ).mime, sizeString];
		cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
	}


    [cell.imageView setImage:[UIImage imageForMimeType:item.mime size:self.iconSize]];
    
	return cell;
}


#pragma mark - Table view delegate

- (void)tableView: (UITableView *) tableView didSelectRowAtIndexPath: (NSIndexPath *) indexPath {
	SSFolderItem *item = [self.folder.items objectAtIndex: indexPath.row];
    if (!item.completely_loaded) {
        return;
    }
	if ([item isKindOfClass: [SSFolder class]]) {
		FolderViewController *newFolderViewController = [[FolderViewController alloc] initWithFolder: (SSFolder *)item];
		[self.navigationController pushViewController: newFolderViewController animated: YES];
	}
	else if ([item isKindOfClass: [SSFile class]]) {
		SSFile *file = (SSFile *)item;
		file.delegate = self;
		[SVProgressHUD show];
		[file loadContent];
	}
}

#pragma mark - SSFolder stuff
- (id)initWithFolder: (SSFolder *) folder {
	if (self = [super initWithAutoPlatformNibName]) {
		self.folder = folder;
		self.folder.delegate = self;
		self.folder.infoDelegate = self;
		self.title = self.folder.name;
	}
	return self;
}

- (void) folder: (SSFolder *) folder itemsLoaded: (NSArray *) items {
	[self.tableView reloadData];
	for (SSFolderItem *item in self.folder.items) {
		if ([item isKindOfClass: [SSFolder class]]) {
			SSFolder *folder = (SSFolder *)item;
			folder.infoDelegate = self;
			[folder loadRevision];
			[folder loadCount];
		}
	}
	[SVProgressHUD dismiss];
    [self dataSourceDidFinishLoadingNewData];
}

- (void) reloadOneItem: (SSFolderItem *) item {
	int i = [self.folder.items indexOfObject: item];

	NSIndexPath *indexPath = [NSIndexPath indexPathForRow: i inSection: 0];

	[self.tableView reloadRowsAtIndexPaths: [NSArray arrayWithObject: indexPath] withRowAnimation: UITableViewRowAnimationNone];
}

- (void) folderLoadingFailed: (SSFolder *) folder {
	[SVProgressHUD dismissWithError:@"Folder data loading failed"];
    [self dataSourceDidFinishLoadingNewData];

}

- (void) folder: (SSFolder *) folder countLoaded: (int) count {
	[self reloadOneItem: folder];
}

- (void) folder: (SSFolder *) folder revisionLoaded: (NSString *) revision {
	[self reloadOneItem: folder];
}

- (void) folder: (SSFolder *) folder overallCountLoaded: (int) count {
	[self reloadOneItem: folder];
}

- (void) folderInfoLoadingFailed: (SSFolder *) folder {
}

- (void) file: (SSFile *) file contentLoaded: (NSData *) content {
	FilePreview *filePreview = [[FilePreview alloc] initWithFile: file];

	FileViewController *newFileViewController = [[FileViewController alloc] initWithFilePreview: filePreview filename: file.name];
	[SVProgressHUD dismiss];
	[self.navigationController pushViewController: newFileViewController animated: YES];
}

- (void) fileContentLoadingFailed: (SSFile *) file {
	[SVProgressHUD dismissWithError:@"File content loading failed"];
}



#pragma mark - refreshHeaderView Methods

- (void) reloadTableViewDataSource
{
	[self.folder loadItems];
}


@end