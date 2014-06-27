//
//  KMPickerViewController.h
//  KMPickerViewController
//
//  Created by Kosuke Matsuda on 2014/01/09.
//  Copyright (c) 2014年 matsuda. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KMPickerViewControllerDelegate;

@interface KMPickerViewController : UIViewController

@property (strong, nonatomic, readonly) UIToolbar *toolBar;
@property (strong, nonatomic, readonly) UIPickerView *pickerView;
@property (weak, nonatomic) id <KMPickerViewControllerDelegate> delegate;

- (id)initWithDelegate:(id)delegate;
- (void)showInView:(UIView *)view amimated:(BOOL)flag completion:(void (^)(BOOL finished))completion;
- (void)dismissAnimated:(BOOL)flag completion:(void (^)(BOOL finished))completion;

- (void)showInView:(UIView *)view completion:(void (^)(BOOL finished))completion __attribute__((deprecated));
- (void)dismissWithCompletion:(void (^)(BOOL finished))completion __attribute__((deprecated));

@end

@protocol KMPickerViewControllerDelegate <UIPickerViewDataSource, UIPickerViewDelegate>

@optional
- (void)pickerViewController:(KMPickerViewController *)controller didSelect:(UIPickerView *)pickerView;
- (void)pickerViewControllerDidCancel:(KMPickerViewController *)controller;

@end
