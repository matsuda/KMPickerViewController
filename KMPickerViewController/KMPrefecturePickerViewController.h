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

@property (weak, nonatomic) id <KMPickerViewControllerDelegate, KMPrefecturePickerViewControllerDelegate> delegate;
@property (copy, nonatomic) NSString *prefecture;
@property (strong, nonatomic) NSLocale *locale;

+ (NSArray *)prefectures;

@property (weak, nonatomic) id <KMPrefecturePickerViewControllerDelegate> prefectureDelegate __attribute__((deprecated));
- (void)showInView:(UIView *)view prefecture:(NSString *)prefecture
        completion:(void (^)(BOOL finished))completion __attribute__((deprecated));

@end

@protocol KMPrefecturePickerViewControllerDelegate <NSObject, KMPickerViewControllerDelegate>

@optional
- (void)prefecturePickerViewController:(KMPrefecturePickerViewController *)controller
                   didSelectPrefecture:(NSString *)prefecture;

@end
