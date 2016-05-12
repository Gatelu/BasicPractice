//
//  AddViewController.h
//  私人通讯录
//
//  Created by Gate on 16/1/14.
//  Copyright © 2016年 Gate. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AddViewController,Contact;
@protocol AddViewControllerDeldegate <NSObject>

@optional
- (void)addViewController:(AddViewController *)addVc DidAddContact:(Contact *)contact;

@end

@interface AddViewController : UIViewController
@property (nonatomic, weak) id<AddViewControllerDeldegate> delagate;
@end
