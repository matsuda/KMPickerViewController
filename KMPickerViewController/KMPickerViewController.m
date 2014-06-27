//
//  KMPickerViewController.m
//  KMPickerViewController
//
//  Created by Kosuke Matsuda on 2014/01/09.
//  Copyright (c) 2014年 matsuda. All rights reserved.
//

#import "KMPickerViewController.h"

@interface KMPickerViewController ()
@property (strong, nonatomic) UIView *grandView;
@property (strong, nonatomic) UIView *contentView;
@property (strong, nonatomic, readwrite) UIToolbar *toolBar;
@property (strong, nonatomic) UIBarButtonItem *cancelButton;
@property (strong, nonatomic) UIBarButtonItem *selectButton;
@property (strong, nonatomic, readwrite) UIPickerView *pickerView;
@end

@implementation KMPickerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self.view addSubview:self.grandView];
        [self.view addSubview:self.contentView];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.pickerView reloadAllComponents];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Public

- (void)showInView:(UIView *)view amimated:(BOOL)flag completion:(void (^)(BOOL))completion
{
    CGRect frame = [[UIScreen mainScreen] bounds];
    self.view.frame = frame;

    CGRect startRect = self.contentView.frame;
    startRect.origin.y = CGRectGetMaxY(self.view.frame);
    CGRect endRect = startRect;
    endRect.origin.y -= endRect.size.height;

    self.contentView.frame = startRect;
    self.grandView.alpha = 0.f;
    [view addSubview:self.view];

    if (flag) {
        [UIView animateWithDuration:0.35f delay:0
                            options:(UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionLayoutSubviews)
                         animations:^{
                             self.grandView.alpha = 0.7;
                             self.contentView.frame = endRect;
                         } completion:completion];
    } else {
        self.grandView.alpha = 0.7;
        self.contentView.frame = endRect;
        if (completion) completion(YES);
    }
}

- (void)dismissAnimated:(BOOL)flag completion:(void (^)(BOOL finished))completion
{
    CGRect startRect = self.contentView.frame;
    startRect.origin.y = CGRectGetMaxY(self.view.frame) - startRect.size.height;
    CGRect endRect = startRect;
    endRect.origin.y += endRect.size.height;

    self.contentView.frame = startRect;

    if (flag) {
        [UIView animateWithDuration:0.2f delay:0
                            options:(UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionLayoutSubviews)
                         animations:^{
                             self.grandView.alpha = 0.f;
                             self.contentView.frame = endRect;
                         } completion:^(BOOL finished) {
                             [self.view removeFromSuperview];
                             if (completion) completion(finished);
                         }];
    } else {
        self.grandView.alpha = 0.f;
        self.contentView.frame = endRect;
        [self.view removeFromSuperview];
        if (completion) completion(YES);
    }
}

#pragma mark - Actions

- (void)tapSelect:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(pickerViewController:didSelect:)]) {
        [self.delegate pickerViewController:self didSelect:self.pickerView];
    }
    [self dismissAnimated:YES completion:nil];
}

- (void)tapCancel:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(pickerViewControllerDidCancel:)]) {
        [self.delegate pickerViewControllerDidCancel:self];
    }
    [self dismissAnimated:YES completion:nil];
}

- (void)tapInGrand:(UIGestureRecognizer *)recognier
{
    UIView *view = recognier.view;
    [self tapCancel:view];
}

#pragma mark - Private

/******************************
 subviews
 ******************************/

- (UIPickerView *)pickerView
{
    if (!_pickerView) {
        UIPickerView *view = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 44.f, CGRectGetWidth(self.view.frame), 216.f)];
        view.showsSelectionIndicator = YES;
        view.backgroundColor = [UIColor whiteColor];
        _pickerView = view;
    }
    return _pickerView;
}

- (UIBarButtonItem *)selectButton
{
    if (!_selectButton) {
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"OK" style:UIBarButtonItemStyleDone target:self action:@selector(tapSelect:)];
        _selectButton = item;
    }
    return _selectButton;
}

- (UIBarButtonItem *)cancelButton
{
    if (!_cancelButton) {
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(tapCancel:)];
        _cancelButton = item;
    }
    return _cancelButton;
}

- (UIToolbar *)toolBar
{
    if (!_toolBar) {
        UIToolbar *view = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 44.f)];
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        [view setItems:@[self.cancelButton, item, self.selectButton]];
        _toolBar = view;
    }
    return _toolBar;
}

- (UIView *)contentView
{
    if (!_contentView) {
        UIToolbar *toolBar = self.toolBar;
        UIPickerView *picker = self.pickerView;
        CGFloat height = CGRectGetHeight(toolBar.frame) + CGRectGetHeight(picker.frame);
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                CGRectGetMaxY(self.view.frame) - height,
                                                                CGRectGetWidth(self.view.frame),
                                                                height)];
        view.backgroundColor = [UIColor whiteColor];
        [view addSubview:toolBar];
        [view addSubview:picker];
        _contentView = view;
    }
    return _contentView;
}

- (UIView *)grandView
{
    if (!_grandView) {
        UIView *view = [[UIView alloc] initWithFrame:self.view.bounds];
        view.backgroundColor = [UIColor blackColor];
        view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        UIGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapInGrand:)];
        [view addGestureRecognizer:gesture];
        _grandView = view;
    }
    return _grandView;
}

#pragma mark - deprecated

- (id)initWithDelegate:(id<KMPickerViewControllerDelegate>)delegate
{
    self = [self initWithNibName:nil bundle:nil];
    if (self) {
        self.delegate = delegate;
    }
    return self;
}

- (void)showInView:(UIView *)view completion:(void (^)(BOOL))completion
{
    [self showInView:view amimated:YES completion:completion];
}

- (void)dismissWithCompletion:(void (^)(BOOL finished))completion
{
    [self dismissAnimated:YES completion:completion];
}

@end
