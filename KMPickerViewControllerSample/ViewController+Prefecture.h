//
//  ViewController+Prefecture.h
//  KMPickerViewController
//
//  Created by Kosuke Matsuda on 2014/01/10.
//  Copyright (c) 2014年 matsuda. All rights reserved.
//

#import "ViewController.h"
#import "KMPrefecturePickerViewController.h"

@interface ViewController (Prefecture) <KMPrefecturePickerViewControllerDelegate>

- (KMPrefecturePickerViewController *)prefecturePickerController;
- (void)presentPrefecturePicker;

@end
