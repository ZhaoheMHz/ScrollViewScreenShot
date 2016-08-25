//
//  ViewController.m
//  截屏加水印
//
//  Created by 赵赤赤 on 16/8/23.
//  Copyright © 2016年 mhz. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textfiled;
@property (weak, nonatomic) IBOutlet UIButton *button;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置button样式
    self.button.layer.masksToBounds = YES;
    self.button.layer.cornerRadius = 5;
    
    // textfield设置
    self.textfiled.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    // 设置标题
    self.title = @"请输入链接内容";
    
    // 自身设置
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (IBAction)pushAction:(id)sender {
    NSString *url;
    if (![self.textfiled.text containsString:@"http"]) {
        url = [NSString stringWithFormat:@"http://%@", self.textfiled.text];
    } else {
        url = self.textfiled.text;
    }
    
    DetailViewController *vc = [[DetailViewController alloc] init];
    vc.url = url;
    UIBarButtonItem *bar = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:0 target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:bar];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
