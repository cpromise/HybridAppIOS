//
//  ViewController.m
//  HybridPrac
//
//  Created by SH on 2015. 12. 1..
//  Copyright © 2015년 SH. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIWebViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _wv.delegate = self;
    
    _wv.layer.borderColor = [UIColor redColor].CGColor;
    _wv.layer.borderWidth = 1.0f;
    
    NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
    NSString* htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
    [_wv loadHTMLString:htmlString baseURL:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btn1:(id)sender {
    NSLog(@"%s is called.",__FUNCTION__);
    [_wv stringByEvaluatingJavaScriptFromString:@"changeDocument()"];
    NSLog(@"Document Title : %@",[_wv stringByEvaluatingJavaScriptFromString:@"document.title"]);
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"Error : %@",error);
}

- (void)objcFuncFromJS{
    static int textFlag = 0;
    if (textFlag%2 == 0) {
        _lbSample.text = @"Hello World";
    } else{
        _lbSample.text = @"Bye World";
    }
    textFlag++;
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    if ([[[request URL] absoluteString] hasPrefix:@"hybrid:"]) {
        
        NSString *requestString = [[request URL] absoluteString];
        NSArray *components = [requestString componentsSeparatedByString:@"://"];
        NSString *functionName = [components objectAtIndex:1];
        
        [self performSelector:NSSelectorFromString(functionName)];
        
        return NO;
    } else{
        return YES;
    }
}

@end