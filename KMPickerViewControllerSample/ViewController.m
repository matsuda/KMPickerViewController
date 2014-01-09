//
//  ViewController.m
//  KMPickerViewController
//
//  Created by Kosuke Matsuda on 2014/01/09.
//  Copyright (c) 2014年 matsuda. All rights reserved.
//

#import "ViewController.h"
#import "KMPickerViewController.h"

@interface ViewController () <KMPickerViewControllerDelegate>
@property (strong, nonatomic) KMPickerViewController *pickerController;
@property (weak, nonatomic) IBOutlet UIButton *defaultButton;
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

- (void)deselectRowInTableView
{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    if (indexPath) {
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}

#pragma mark - Table view data source

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

#pragma mark - UIPickerViewDataSource & UIPickerViewDelegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 100;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [NSString stringWithFormat:@"%d", row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
}

#pragma mark - KMPickerViewController

- (KMPickerViewController *)pickerController
{
    if (!_pickerController) {
        _pickerController = [[KMPickerViewController alloc] initWithDelegate:self];
    }
    return _pickerController;
}

- (void)presentPicker
{
    [self.view endEditing:YES];
    KMPickerViewController *picker = self.pickerController;
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    [picker showInView:window completion:nil];
}

#pragma mark - KMPickerViewControllerDelegate

- (void)pickerViewController:(KMPickerViewController *)controller didSelect:(UIPickerView *)pickerView
{
    NSInteger row = [pickerView selectedRowInComponent:0];
    [self.defaultButton setTitle:[NSString stringWithFormat:@"%d", row] forState:UIControlStateNormal];
    [self deselectRowInTableView];
}

- (void)pickerViewControllerDidCancel:(KMPickerViewController *)controller
{
    [self deselectRowInTableView];
}

@end
