//
//  JZEntryListTableViewController.m
//  JournalObjC
//
//  Created by XMS_JZhan on 2/11/19.
//  Copyright © 2019 XMS_JZhan. All rights reserved.
//

#import "JZEntryListTableViewController.h"
#import "JZEntryController.h"
#import "JZEntryDetailViewController.h"

@interface JZEntryListTableViewController ()

@end

@implementation JZEntryListTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [JZEntryController.shared loadFromPersistentStorage];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return JZEntryController.shared.entries.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"entryCell" forIndexPath:indexPath];
    [cell.textLabel setText:[JZEntryController.shared.entries[indexPath.row] title]];
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [JZEntryController.shared removeEntry:JZEntryController.shared.entries[indexPath.row]];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // IIDOO
    if ([[segue identifier] isEqualToString:@"editSegue"]) {
        JZEntryDetailViewController *destVC = [segue destinationViewController];
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        destVC.entry = JZEntryController.shared.entries[indexPath.row];
    }
}
@end
