//
//  ViewController+Quantity.h
//  KMPickerViewController
//
//  Created by Kosuke Matsuda on 2014/01/10.
//  Copyright (c) 2014年 matsuda. All rights reserved.
//

#import "ViewController.h"
#import "KMQuantityPickerViewController.h"

@interface ViewController (Quantity) <KMQuantityPickerViewControllerDelegate>

- (KMQuantityPickerViewController *)quantityPickerController;
- (void)presentQuantityPicker;

@end
