//
//  KMQuantityPickerViewController.m
//  KMPickerViewController
//
//  Created by Kosuke Matsuda on 2014/01/09.
//  Copyright (c) 2014年 matsuda. All rights reserved.
//

#import "KMQuantityPickerViewController.h"

static const NSInteger kDefaultMinimunQuantity = 0;
static const NSInteger kDefaultMaximumQuantity = 20;
static NSString *kDefaultUnitString = @"個";
static NSString *kDefaultOverUnitString = @"以上";

@interface KMQuantityPickerViewController () <UIPickerViewDataSource, UIPickerViewDelegate, KMPickerViewControllerDelegate>

@end

@implementation KMQuantityPickerViewController

- (id)initWithDelegate:(id)delegate
{
    self = [super initWithDelegate:delegate];
    if (self) {
        _minimumQuantity = kDefaultMinimunQuantity;
        _maximumQuantity = kDefaultMaximumQuantity;
        _unit = [kDefaultUnitString copy];
        _overUnit = [kDefaultOverUnitString copy];
        _quantity = _minimumQuantity;
        self.delegate = self;
        self.quantityDelegate = delegate;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showInView:(UIView *)view amimated:(BOOL)flag completion:(void (^)(BOOL))completion
{
    __block NSInteger index = _quantity - _minimumQuantity;
    if (index < _minimumQuantity - 1) index = 0;
    __weak typeof(self) wself = self;
    [super showInView:view amimated:flag completion:^(BOOL finished) {
        [wself.pickerView selectRow:index inComponent:0 animated:YES];
    }];
}

- (void)showInView:(UIView *)view quantity:(NSInteger)quantity completion:(void (^)(BOOL))completion
{
    self.quantity = quantity;
    [self showInView:view amimated:YES completion:completion];
}

#pragma mark - UIPickerViewDataSource & UIPickerViewDelegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return (_maximumQuantity - _minimumQuantity) + 1;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSInteger quantity = row + _minimumQuantity;
    if (quantity == _maximumQuantity) {
        return [NSString stringWithFormat:@"%ld%@%@", (long)quantity, self.unit, self.overUnit];
    }
    return [NSString stringWithFormat:@"%ld%@", (long)quantity, self.unit];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
}

#pragma mark - KMPickerViewControllerDelegate

- (void)pickerViewController:(KMPickerViewController *)controller didSelect:(UIPickerView *)pickerView
{
    NSInteger row = [pickerView selectedRowInComponent:0];
    NSInteger quantity = row + _minimumQuantity;
    if ([self.quantityDelegate respondsToSelector:@selector(quantityPickerViewController:didSelectQuantity:)]) {
        [self.quantityDelegate quantityPickerViewController:self didSelectQuantity:quantity];
    }
}

- (void)pickerViewControllerDidCancel:(KMPickerViewController *)controller
{
    if ([self.quantityDelegate respondsToSelector:@selector(quantityPickerViewControllerDidCancel:)]) {
        [self.quantityDelegate quantityPickerViewControllerDidCancel:self];
    }
}

@end
