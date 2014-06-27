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

@interface KMQuantityPickerViewController () <UIPickerViewDataSource, UIPickerViewDelegate>

@end

@implementation KMQuantityPickerViewController

- (id)init
{
    self = [super init];
    if (self) {
        _minimumQuantity = kDefaultMinimunQuantity;
        _maximumQuantity = kDefaultMaximumQuantity;
        _unit = [kDefaultUnitString copy];
        _overUnit = [kDefaultOverUnitString copy];
        _quantity = _minimumQuantity;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.pickerView.dataSource = self;
    self.pickerView.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)presentPickerAnimated:(BOOL)flag completion:(void (^)(BOOL))completion
{
    __block NSInteger index = _quantity - _minimumQuantity;
    if (index < _minimumQuantity - 1) index = 0;
    __weak typeof(self) wself = self;
    [super presentPickerAnimated:flag completion:^(BOOL finished) {
        [wself.pickerView selectRow:index inComponent:0 animated:YES];
    }];
}

- (void)tapSelect:(id)sender
{
    NSInteger row = [self.pickerView selectedRowInComponent:0];
    NSInteger quantity = row + _minimumQuantity;
    if ([self.delegate respondsToSelector:@selector(quantityPickerViewController:didSelectQuantity:)]) {
        [self.delegate quantityPickerViewController:self didSelectQuantity:quantity];
    }
    [self dismissAnimated:YES completion:nil];
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

#pragma mark - deprecated

- (id)initWithDelegate:(id)delegate
{
    self = [super initWithDelegate:delegate];
    if (self) {
        _minimumQuantity = kDefaultMinimunQuantity;
        _maximumQuantity = kDefaultMaximumQuantity;
        _unit = [kDefaultUnitString copy];
        _overUnit = [kDefaultOverUnitString copy];
        _quantity = _minimumQuantity;
    }
    return self;
}

- (void)showInView:(UIView *)view quantity:(NSInteger)quantity completion:(void (^)(BOOL))completion
{
    self.quantity = quantity;
    [self presentPickerAnimated:YES completion:completion];
}

- (void)setQuantityDelegate:(id<KMQuantityPickerViewControllerDelegate>)quantityDelegate
{
    self.delegate = quantityDelegate;
}

- (id<KMQuantityPickerViewControllerDelegate>)quantityDelegate
{
    return (id<KMQuantityPickerViewControllerDelegate>)self.delegate;
}

@end
