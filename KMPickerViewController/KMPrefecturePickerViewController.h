//
//  KMPrefecturePickerViewController.h
//  KMPickerViewController
//
//  Created by Kosuke Matsuda on 2014/01/09.
//  Copyright (c) 2014年 matsuda. All rights reserved.
//

#import "KMPickerViewController.h"

@protocol KMPrefecturePickerViewControllerDelegate;

@interface KMPrefecturePickerViewController : KMPickerViewController

@property (weak, nonatomic) id <KMPrefecturePickerViewControllerDelegate> prefectureDelegate;
@property (copy, nonatomic) NSString *prefecture;
@property (strong, nonatomic) NSLocale *locale;

- (void)showInView:(UIView *)view prefecture:(NSString *)prefecture
        completion:(void (^)(BOOL finished))completion __attribute__((deprecated));
+ (NSArray *)prefectures;

@end

@protocol KMPrefecturePickerViewControllerDelegate <NSObject>

- (void)prefecturePickerViewController:(KMPrefecturePickerViewController *)controller
                   didSelectPrefecture:(NSString *)prefecture;
- (void)prefecturePickerViewControllerDidCancel:(KMPrefecturePickerViewController *)controller;

@end
