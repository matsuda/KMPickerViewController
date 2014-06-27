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
        // _quantityPickerController = [[KMQuantityPickerViewController alloc] initWithDelegate:self];
        _quantityPickerController = [KMQuantityPickerViewController new];
        _quantityPickerController.delegate = self;
        _quantityPickerController.minimumQuantity = 1;
        _quantityPickerController.maximumQuantity = 11;
        _quantityPickerController.unit = @"枚";
    }
    return _quantityPickerController;
}

- (void)presentQuantityPicker
{
    [self.view endEditing:YES];
    KMQuantityPickerViewController *picker = self.quantityPickerController;
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    NSInteger quantity = [self.quantityButton.titleLabel.text integerValue];
    // [picker showInView:window quantity:quantity completion:nil];
    picker.quantity = quantity;
    [picker showInView:window amimated:YES completion:nil];
}

#pragma mark - KMQuantityPickerViewControllerDelegate

- (void)quantityPickerViewController:(KMQuantityPickerViewController *)controller
                   didSelectQuantity:(NSInteger)quantity
{
    [self.quantityButton setTitle:[NSString stringWithFormat:@"%ld", (long)quantity] forState:UIControlStateNormal];
}

@end
