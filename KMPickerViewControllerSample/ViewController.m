//
//  ViewController.m
//  KMPickerViewController
//
//  Created by Kosuke Matsuda on 2014/01/09.
//  Copyright (c) 2014年 matsuda. All rights reserved.
//

#import "ViewController.h"
#import "ViewController+Base.h"
#import "ViewController+Quantity.h"
#import "ViewController+Prefecture.h"

@interface ViewController ()

@end

@implementation ViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)tapDefaultButton:(id)sender
{
    [self presentPicker];
}

- (IBAction)tapQuantityButton:(id)sender
{
    [self presentQuantityPicker];
}

- (IBAction)tapPrefectureButton:(id)sender
{
    [self presentPrefecturePicker];
}

#pragma mark - Table view data source

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *title = nil;
    switch (section) {
        case 0:
            title = @"Base";
            break;
        case 1:
            title = @"Quantity";
            break;
        case 2:
            title = @"Prefecture";
            break;
    }
    return title;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

@end
