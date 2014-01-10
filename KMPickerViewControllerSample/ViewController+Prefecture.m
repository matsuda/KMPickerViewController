//
//  ViewController+Prefecture.m
//  KMPickerViewController
//
//  Created by Kosuke Matsuda on 2014/01/10.
//  Copyright (c) 2014年 matsuda. All rights reserved.
//

#import "ViewController+Prefecture.h"

@implementation ViewController (Prefecture)

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
