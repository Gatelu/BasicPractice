//
//  ContactTableViewCell.h
//  私人通讯录
//
//  Created by Gate on 16/1/17.
//  Copyright © 2016年 Gate. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Contact;
@interface ContactTableViewCell : UITableViewCell
@property (nonatomic ,strong) Contact *contact;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
