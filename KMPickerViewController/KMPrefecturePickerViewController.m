//
//  KMPrefecturePickerViewController.m
//  KMPickerViewController
//
//  Created by Kosuke Matsuda on 2014/01/09.
//  Copyright (c) 2014年 matsuda. All rights reserved.
//

#import "KMPrefecturePickerViewController.h"

@interface KMPrefecturePickerViewController () <UIPickerViewDataSource, UIPickerViewDelegate, KMPickerViewControllerDelegate>

@end

@implementation KMPrefecturePickerViewController

- (id)initWithDelegate:(id)delegate
{
    self = [super initWithDelegate:delegate];
    if (self) {
        self.delegate = self;
        self.prefectureDelegate = delegate;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showInView:(UIView *)view amimated:(BOOL)flag completion:(void (^)(BOOL))completion
{
    __block NSInteger index = [[[self class] prefectures] indexOfObject:_prefecture];
    if (index == NSNotFound) index = 0;
    __weak typeof(self) wself = self;
    [super showInView:view amimated:flag completion:^(BOOL finished) {
        [wself.pickerView selectRow:index inComponent:0 animated:YES];
    }];
}

- (void)showInView:(UIView *)view completion:(void (^)(BOOL))completion
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must use %@ method.",
                                           NSStringFromSelector(@selector(showInView:prefecture:completion:))]
                                 userInfo:nil];
}

- (void)showInView:(UIView *)view prefecture:(NSString *)prefecture completion:(void (^)(BOOL))completion
{
    self.prefecture = prefecture;
    [self showInView:view amimated:YES completion:completion];
}

#pragma mark - UIPickerViewDataSource & UIPickerViewDelegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [[[self class] prefectures] count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [[self class] prefectures][row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
}

#pragma mark - KMPickerViewControllerDelegate

- (void)pickerViewController:(KMPickerViewController *)controller didSelect:(UIPickerView *)pickerView
{
    NSInteger row = [pickerView selectedRowInComponent:0];
    NSString *title = [[self class] prefectures][row];
    [self.prefectureDelegate prefecturePickerViewController:self didSelectPrefecture:title];
}

- (void)pickerViewControllerDidCancel:(KMPickerViewController *)controller
{
    [self.prefectureDelegate prefecturePickerViewControllerDidCancel:self];
}

+ (NSArray *)prefectures
{
    static dispatch_once_t onceToken;
    static NSArray *_prefectures = nil;
    dispatch_once(&onceToken, ^{
        _prefectures = [self loadPropertyList];
    });
    return _prefectures;
}

+ (NSArray *)loadPropertyList
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"KMPickerViewController.bundle/prefectures" ofType:@"plist"];
    return [NSArray arrayWithContentsOfFile:path];
}

@end
