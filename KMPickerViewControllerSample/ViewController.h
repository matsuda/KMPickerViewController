//
//  ViewController.h
//  KMPickerViewController
//
//  Created by Kosuke Matsuda on 2014/01/09.
//  Copyright (c) 2014年 matsuda. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KMPickerViewController;
@class KMQuantityPickerViewController;
@class KMPrefecturePickerViewController;

@interface ViewController : UITableViewController {
    KMPickerViewController *_pickerController;
    KMQuantityPickerViewController *_quantityPickerController;
    KMPrefecturePickerViewController *_prefecturePickerController;
}

@property (weak, nonatomic) IBOutlet UIButton *defaultButton;
@property (weak, nonatomic) IBOutlet UIButton *quantityButton;
@property (weak, nonatomic) IBOutlet UIButton *prefectureButton;

@end

@interface ViewController (Protected)

- (void)deselectRowInTableView;

@end
