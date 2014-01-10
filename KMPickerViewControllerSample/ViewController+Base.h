//
//  ViewController+Base.h
//  KMPickerViewController
//
//  Created by Kosuke Matsuda on 2014/01/10.
//  Copyright (c) 2014年 matsuda. All rights reserved.
//

#import "ViewController.h"
#import "KMPickerViewController.h"

@interface ViewController (Base)

- (KMPickerViewController *)pickerController;
- (void)presentPicker;

@end
