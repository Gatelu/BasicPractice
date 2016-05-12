//
//  ContactsViewController.m
//  私人通讯录
//
//  Created by Gate on 16/1/14.
//  Copyright © 2016年 Gate. All rights reserved.
//
#define ContactsFilepath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"contacts.data"]
#import "ContactsViewController.h"
#import "AddViewController.h"
#import "Contact.h"
#import "EditViewController.h"
#import "ContactTableViewCell.h"
#import "MBProgressHUD+MJ.h"
@interface ContactsViewController ()<AddViewControllerDeldegate,EditViewControllerDelegate>
- (IBAction)logOut:(id)sender;
@property (nonatomic ,strong) NSMutableArray *contacts;

@end

@implementation ContactsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [MBProgressHUD hideHUD];
//    [MBProgressHUD hideHUDForView:self.view];
//    [MBProgressHUD hideHUDForView:self.view animated:YES];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}
- (NSMutableArray *)contacts{
    if (_contacts == nil) {
        _contacts = [NSKeyedUnarchiver unarchiveObjectWithFile:ContactsFilepath];
        if (_contacts == nil) {
            _contacts = [NSMutableArray array];

        }
    }
    return _contacts;
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"%lu-----------------",(unsigned long)_contacts.count);
    NSLog(@"%lu-----------------",(unsigned long)self.contacts.count);

    return self.contacts.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ContactTableViewCell*cell = [ContactTableViewCell cellWithTableView:tableView];
    cell.contact = self.contacts[indexPath.row];
    return cell;
}
#pragma mark - 代理方法
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) { // 提交的是删除操作
        // 1.删除模型数据
        [self.contacts removeObjectAtIndex:indexPath.row];
        
        // 2.刷新表格
//        [self.tableView reloadData];
        // 局部刷新某些行(使用前提:模型数据的行数不变)
        //        [self.tableView reloadRowsAtIndexPaths:<#(NSArray *)#> withRowAnimation:<#(UITableViewRowAnimation)#>];
//        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
        //        [self.tableView reloadData];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationMiddle];
        // 3.归档
        [NSKeyedArchiver archiveRootObject:self.contacts toFile:ContactsFilepath];
    }
}
- (IBAction)logOut:(id)sender {
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"确定要注销？" message:nil preferredStyle:0];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:0 handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [ac addAction:action];
    [ac addAction:action2];
    [self.navigationController presentViewController:ac animated:YES completion:^{}];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    id vc = segue.destinationViewController;
    if ([vc isKindOfClass:[AddViewController class]]) {
        AddViewController *addVc = vc;
        addVc.delagate = self;
    }else if([vc isKindOfClass:[EditViewController class]]){
        EditViewController *editVc = vc;
        NSIndexPath *path = [self.tableView indexPathForSelectedRow];
        editVc.contact = self.contacts[path.row];
        editVc.delegate = self;
    }

    
}
- (void)addViewController:(AddViewController *)addVc DidAddContact:(Contact *)contact{
    [self.contacts addObject:contact];
    [self.tableView reloadData];
    [NSKeyedArchiver archiveRootObject:self.contacts toFile:ContactsFilepath];
}
/**
 *  代理方法
 */
- (void)editViewController:(EditViewController *)editVc didSaveContact:(Contact *)contact{
    [self.tableView reloadData];
    
    [NSKeyedArchiver archiveRootObject:self.contacts toFile:ContactsFilepath];

}
@end
