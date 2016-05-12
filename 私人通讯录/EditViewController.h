//
//  EditViewController.h
//  私人通讯录
//
//  Created by Gate on 16/1/14.
//  Copyright © 2016年 Gate. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Contact,EditViewController;
@protocol EditViewControllerDelegate <NSObject>

@optional
- (void)editViewController:(EditViewController *)editVc didSaveContact:(Contact *)contact;
@end
@interface EditViewController : UIViewController
@property (nonatomic ,strong) Contact *contact;
@property (nonatomic ,weak) id <EditViewControllerDelegate> delegate;

@end
