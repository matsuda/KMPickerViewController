//
//  ViewController+Quantity.m
//  KMPickerViewController
//
//  Created by Kosuke Matsuda on 2014/01/10.
//  Copyright (c) 2014年 matsuda. All rights reserved.
//

#import "ViewController+Quantity.h"

@implementation ViewController (Quantity)

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

@end
