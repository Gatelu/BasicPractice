//
//  AddViewController.m
//  私人通讯录
//
//  Created by Gate on 16/1/14.
//  Copyright © 2016年 Gate. All rights reserved.
//

#import "AddViewController.h"
#import "Contact.h"
@interface AddViewController ()
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
- (IBAction)add;

@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.phoneField];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.nameField];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.nameField becomeFirstResponder];
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)textChange{
    self.addBtn.enabled = (self.nameField.text.length && self.phoneField.text.length);
}
- (IBAction)add {
    [self.navigationController popViewControllerAnimated:YES];
    //通知代理
    
    if ([self.delagate respondsToSelector:@selector(addViewController:DidAddContact:)]) {
        Contact *contact = [[Contact alloc] init];
        contact.name = self.nameField.text;
        contact.phone = self.phoneField.text;
        [self.delagate addViewController:self DidAddContact:contact];
    }
}








@end
