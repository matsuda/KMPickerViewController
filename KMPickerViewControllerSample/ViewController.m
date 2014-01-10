//
//  ViewController.m
//  KMPickerViewController
//
//  Created by Kosuke Matsuda on 2014/01/09.
//  Copyright (c) 2014年 matsuda. All rights reserved.
//

#import "ViewController.h"
#import "KMPickerViewController.h"
#import "KMQuantityPickerViewController.h"
#import "KMPrefecturePickerViewController.h"

@interface ViewController () <
KMPickerViewControllerDelegate,
KMQuantityPickerViewControllerDelegate,
KMPrefecturePickerViewControllerDelegate>

@property (strong, nonatomic) KMPickerViewController *pickerController;
@property (strong, nonatomic) KMQuantityPickerViewController *quantityPickerController;
@property (strong, nonatomic) KMPrefecturePickerViewController *prefecturePickerController;

@property (weak, nonatomic) IBOutlet UIButton *defaultButton;
@property (weak, nonatomic) IBOutlet UIButton *quantityButton;
@property (weak, nonatomic) IBOutlet UIButton *prefectureButton;

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

- (void)deselectRowInTableView
{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    if (indexPath) {
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
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

#pragma mark - KMPickerViewController

- (KMQuantityPickerViewController *)quantityPickerController
{
    if (!_quantityPickerController) {
        _quantityPickerController = [[KMQuantityPickerViewController alloc] initWithDelegate:self];
    }
    return _quantityPickerController;
}

- (void)presentQuantityPicker
{
    [self.view endEditing:YES];
    KMQuantityPickerViewController *picker = self.quantityPickerController;
    picker.minimumQuantity = 1;
    picker.maximumQuantity = 11;
    picker.unit = @"枚";
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    NSInteger quantity = [self.quantityButton.titleLabel.text integerValue];
    [picker showInView:window quantity:quantity completion:nil];
}

#pragma mark - KMQuantityPickerViewControllerDelegate

- (void)quantityPickerViewController:(KMQuantityPickerViewController *)controller
                   didSelectQuantity:(NSInteger)quantity
{
    [self.quantityButton setTitle:[NSString stringWithFormat:@"%d", quantity] forState:UIControlStateNormal];
    [self deselectRowInTableView];
}

- (void)quantityPickerViewControllerDidCancel:(KMQuantityPickerViewController *)controller
{
    [self deselectRowInTableView];
}

#pragma mark - KMPrefecturePickerViewController

- (KMPrefecturePickerViewController *)prefecturePickerController
{
    if (!_prefecturePickerController) {
        _prefecturePickerController = [[KMPrefecturePickerViewController alloc] initWithDelegate:self];
    }
    return _prefecturePickerController;
}

- (void)presentPrefecturePicker
{
    [self.view endEditing:YES];
    KMPrefecturePickerViewController *picker = self.prefecturePickerController;
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    [picker showInView:window prefecture:self.prefectureButton.titleLabel.text completion:nil];
}

#pragma mark - KMPrefecturePickerViewControllerDelegate

- (void)prefecturePickerViewController:(KMPrefecturePickerViewController *)controller
                   didSelectPrefecture:(NSString *)prefecture
{
    [self.prefectureButton setTitle:prefecture forState:UIControlStateNormal];
    [self deselectRowInTableView];
}

- (void)prefecturePickerViewControllerDidCancel:(KMPrefecturePickerViewController *)controller
{
    [self deselectRowInTableView];
}

@end
