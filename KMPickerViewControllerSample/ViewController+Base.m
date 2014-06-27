//
//  ViewController+Base.m
//  KMPickerViewController
//
//  Created by Kosuke Matsuda on 2014/01/10.
//  Copyright (c) 2014年 matsuda. All rights reserved.
//

#import "ViewController+Base.h"

@implementation ViewController (Base)

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
    return [NSString stringWithFormat:@"%ld", (long)row];
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
    // [picker showInView:window amimated:YES completion:nil];
    [picker showInView:window amimated:NO completion:nil];
}

#pragma mark - KMPickerViewControllerDelegate

- (void)pickerViewController:(KMPickerViewController *)controller didSelect:(UIPickerView *)pickerView
{
    NSInteger row = [pickerView selectedRowInComponent:0];
    [self.defaultButton setTitle:[NSString stringWithFormat:@"%ld", (long)row] forState:UIControlStateNormal];
    [self deselectRowInTableView];
}

- (void)pickerViewControllerDidCancel:(KMPickerViewController *)controller
{
    [self deselectRowInTableView];
}

@end
