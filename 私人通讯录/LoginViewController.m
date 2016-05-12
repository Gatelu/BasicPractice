//
//  LoginViewController.m
//  私人通讯录
//
//  Created by Gate on 16/1/14.
//  Copyright © 2016年 Gate. All rights reserved.
//
#define XCODE_COLORS_ESCAPE_MAC @"\033["
#define XCODE_COLORS_ESCAPE_IOS @"\xC2\xA0["


#if 0
#define XCODE_COLORS_ESCAPE XCODE_COLORS_ESCAPE_IOS
#else
#define XCODE_COLORS_ESCAPE XCODE_COLORS_ESCAPE_MAC
#endif
#define AccountKey @"account"
#define PwdKey @"pwd"
#define RmbPwdKey @"rmb_pwd"
#define AutoLoginKey @"auto_login"
#import "LoginViewController.h"
#import "MBProgressHUD+MJ.h"
@interface LoginViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *accountTextField;
@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UISwitch *rmbPwdSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *autoLoginSwitch;
- (IBAction)rmbPwdChange;
- (IBAction)autoLoginChange;
- (IBAction)login;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.accountTextField];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.pwdTextField];
    // 读取上次的配置
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.accountTextField.text = [defaults objectForKey:AccountKey];
    self.rmbPwdSwitch.on = [defaults boolForKey:RmbPwdKey];
    self.autoLoginSwitch.on = [defaults boolForKey:AutoLoginKey];
    
    // 处理密码
    if (self.rmbPwdSwitch.isOn) {
        self.pwdTextField.text = [defaults objectForKey:PwdKey];
    }
    
    // 处理自动登录的情况
    if (self.autoLoginSwitch.isOn) {
        [self login]; // 点击了"登录"按钮
    }
    for (int i = 0; i <5; i++) {
        NSLog(@"dayin");
    }
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)textChange{
    self.loginBtn.enabled = (self.accountTextField.text.length && self.pwdTextField.text.length);
}
- (IBAction)rmbPwdChange {
    if (self.rmbPwdSwitch.on == NO) {
//        self.autoLoginSwitch.on = NO;
        [self.autoLoginSwitch setOn:NO animated:YES];
    }
}

- (IBAction)autoLoginChange {
    if (self.autoLoginSwitch.on == YES) {
//        self.rmbPwdSwitch.on = YES;
        [self.rmbPwdSwitch setOn:YES animated:YES];
    }
}

- (IBAction)login {
    if (![self.accountTextField.text isEqualToString:@"lcx"]) {
        [MBProgressHUD showError:@"帐号不存在"];
        return;
    }
    if (![self.pwdTextField.text isEqualToString:@"123"]) {
        [MBProgressHUD showError:@"密码错误"];
        return;
    }
//    [MBProgressHUD showMessage:@"哥正在帮你登录中...."];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:self.view];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self performSegueWithIdentifier:@"login2contacts" sender:nil];
    });
    //读取数据
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.accountTextField.text forKey:AccountKey];
    [defaults setObject:self.pwdTextField.text forKey:PwdKey];
    [defaults setBool:self.rmbPwdSwitch.isOn forKey:RmbPwdKey];
    [defaults setBool:self.autoLoginSwitch.isOn forKey:AutoLoginKey];
    [defaults synchronize];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    UIViewController *contactVc = segue.destinationViewController;
    contactVc.title = [NSString stringWithFormat:@"%@的联系人列表",self.accountTextField.text];
    //contactVc.title 等价于 contactVc.navigationItem.title
}
@end
