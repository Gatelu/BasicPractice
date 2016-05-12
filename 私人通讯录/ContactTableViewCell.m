//
//  ContactTableViewCell.m
//  私人通讯录
//
//  Created by Gate on 16/1/17.
//  Copyright © 2016年 Gate. All rights reserved.
//

#import "ContactTableViewCell.h"
#import "Contact.h"
@interface ContactTableViewCell()
@property (nonatomic, weak)UIView *deviderView;
@end
@implementation ContactTableViewCell

- (void)awakeFromNib {
    // Initialization code
    UIView *deviderView = [[UIView alloc] init];
    deviderView.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:deviderView];
    self.deviderView = deviderView;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.deviderView.frame = CGRectMake(0, self.frame.size.height - 1, self.frame.size.width, 1);
}
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *id = @"contact";
    
    return [tableView dequeueReusableCellWithIdentifier:id];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setContact:(Contact *)contact{
    _contact = contact;
    self.textLabel.text = contact.name;
    self.detailTextLabel.text = contact.phone;
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

}
@end
