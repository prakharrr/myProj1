//
//  VerifyViewController.m
//  RandomFacts
//
//  Created by Prakhar Rawat on 26/06/16.
//  Copyright © 2016 Prakhar Rawat. All rights reserved.
//
#import "VerifyViewController.h"
@interface VerifyViewController ()
{
}
@property(weak,nonatomic)IBOutlet UIWebView* webView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;

@end

@implementation VerifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSURL* urlToLoad=[NSURL URLWithString:self.urlString];
    if (!urlToLoad) {
        NSString *encodedImgUrl = [self.urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        urlToLoad=[NSURL URLWithString:encodedImgUrl];
    }
    [_webView setScalesPageToFit:YES];
    [self.webView setDelegate:self];
    [self.webView loadRequest:[NSURLRequest requestWithURL:urlToLoad]];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{



    //Show activity indicator
    [self.indicator startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    //Remove Activity indicator
    [self.indicator stopAnimating];
    [self.indicator setHidden:YES];
    [self.indicator removeFromSuperview];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    
    if (navigationType == UIWebViewNavigationTypeLinkClicked){
        
        NSURL *url = request.URL;
        [self openExternalURL:url];//Handle External URL here
        
    }
    
    return YES;
    
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
-(void)openExternalURL:(NSURL*)url
{
    [[UIApplication sharedApplication] openURL:url];
}
@end
