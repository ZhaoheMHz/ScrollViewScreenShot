//
//  DetailViewController.m
//  截屏加水印
//
//  Created by 赵赤赤 on 16/8/23.
//  Copyright © 2016年 mhz. All rights reserved.
//

#import "DetailViewController.h"
#import "UIImage+WaterMark.h"
#import "QRCodeGenerator.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // webView设置
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    
    // 设置button样式
    self.button.layer.masksToBounds = YES;
    self.button.layer.cornerRadius = 5;
    
    // 自身设置
    self.view.backgroundColor = [UIColor whiteColor];
}

- (IBAction)saveAction:(id)sender {
    // 获取scrollView
    UIScrollView *scrollView = self.webView.scrollView;
    UIImage* image = nil;
    
    // 开始绘制
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(scrollView.contentSize.width, scrollView.contentSize.height+100), NO, 0.0);
    {
        // 保存原有的scrollView偏移量和frame
        CGPoint savedContentOffset = scrollView.contentOffset;
        CGRect savedFrame = scrollView.frame;
        
        // 展开scrollView
        scrollView.contentOffset = CGPointZero;
        scrollView.frame = CGRectMake(0, 0, scrollView.contentSize.width, scrollView.contentSize.height);
        
        // 将scrollView的layer渲染到上下文中
        [scrollView.layer renderInContext: UIGraphicsGetCurrentContext()];
        
        // 画背景
        UIImage *backImage = [UIImage createImageWithColor:[UIColor whiteColor]];
        [backImage drawInRect:CGRectMake(0, scrollView.contentSize.height-100, scrollView.contentSize.width, 100)];
        
        // 画二维码
        UIImage *qrImage = [QRCodeGenerator qrImageForString:self.url imageSize:300];
        [qrImage drawInRect:CGRectMake(scrollView.contentSize.width*0.5-40, scrollView.contentSize.height-100+10, 80, 80)];
        
        // 获取结果图片
        image = UIGraphicsGetImageFromCurrentImageContext();
        
        // 还原scrollView偏移量和frame
        scrollView.contentOffset = savedContentOffset;
        scrollView.frame = savedFrame;
    }
    UIGraphicsEndImageContext();
    
    if (image != nil) {
        // 写到相册
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    }
}


@end
