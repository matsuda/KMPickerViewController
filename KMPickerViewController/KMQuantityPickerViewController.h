//
//  KMQuantityPickerViewController.h
//  KMPickerViewController
//
//  Created by Kosuke Matsuda on 2014/01/09.
//  Copyright (c) 2014年 matsuda. All rights reserved.
//

#import "KMPickerViewController.h"

@protocol KMQuantityPickerViewControllerDelegate;

@interface KMQuantityPickerViewController : KMPickerViewController

@property (weak, nonatomic) id <KMQuantityPickerViewControllerDelegate> quantityDelegate;
@property (assign, nonatomic) NSInteger quantity;
@property (assign, nonatomic) NSInteger minimumQuantity;
@property (assign, nonatomic) NSInteger maximumQuantity;
@property (copy, nonatomic) NSString *unit;
@property (copy, nonatomic) NSString *overUnit;

- (id)initWithDelegate:(id)delegate;
- (void)showInView:(UIView *)view quantity:(NSInteger)quantity
        completion:(void (^)(BOOL finished))completion __attribute__((deprecated));

@end

@protocol KMQuantityPickerViewControllerDelegate <NSObject>

@optional
- (void)quantityPickerViewController:(KMQuantityPickerViewController *)controller
                   didSelectQuantity:(NSInteger)quantity;
- (void)quantityPickerViewControllerDidCancel:(KMQuantityPickerViewController *)controller;

@end
