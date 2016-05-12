//
//  EditViewController.m
//  私人通讯录
//
//  Created by Gate on 16/1/14.
//  Copyright © 2016年 Gate. All rights reserved.
//

#import "EditViewController.h"
#import "Contact.h"
@interface EditViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *editBTN;
- (IBAction)edit:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;
@property (weak, nonatomic) IBOutlet UIButton *save;
- (IBAction)saveBtnClick:(id)sender;

@end

@implementation EditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.nameField.text = self.contact.name;
    self.phoneField.text = self.contact.phone;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)edit:(id)sender {
    if (self.nameField.enabled) {
        [self.editBTN setTitle:@"编辑"];
        self.saveBtn.hidden = YES;
        self.nameField.enabled = NO;
        self.phoneField.enabled = NO;
        [self.view endEditing:YES];
        self.phoneField.text = self.contact.phone;
        self.nameField.text = self.contact.name;
    }else{
        [self.editBTN setTitle:@"取消"];
        self.saveBtn.hidden = NO;
        self.nameField.enabled = YES;
        self.phoneField.enabled = YES;
        [self.phoneField becomeFirstResponder];
    }
    
}
- (IBAction)saveBtnClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    if ([self.delegate respondsToSelector:@selector(editViewController:didSaveContact:)]) {
        //更新模型数据
        self.contact.name = self.nameField.text;
        self.contact.phone = self.phoneField.text;
        [self.delegate editViewController:self didSaveContact:self.contact];
    }
    
}
@end
