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

- (void)presentPickerAnimated:(BOOL)flag completion:(void (^)(BOOL finished))completion;
- (void)dismissAnimated:(BOOL)flag completion:(void (^)(BOOL finished))completion;

- (id)initWithDelegate:(id)delegate __attribute__((deprecated));
- (void)showInView:(UIView *)view completion:(void (^)(BOOL finished))completion __attribute__((deprecated));
- (void)dismissWithCompletion:(void (^)(BOOL finished))completion __attribute__((deprecated));

@end


@interface KMPickerViewController (Protected)

- (void)tapSelect:(id)sender;
- (void)tapCancel:(id)sender;

@end


@protocol KMPickerViewControllerDelegate <NSObject>

@optional
- (void)pickerViewControllerDidSelect:(KMPickerViewController *)controller;
- (void)pickerViewControllerDidCancel:(KMPickerViewController *)controller;

@end
