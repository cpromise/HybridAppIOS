//
//  ViewController.h
//  HybridPrac
//
//  Created by SH on 2015. 12. 1..
//  Copyright © 2015년 SH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIWebView *wv;
- (IBAction)btn1:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lbSample;

@end

