//
//  ViewController.m
//  RandomFacts
//
//  Created by Prakhar Rawat on 24/06/16.
//  Copyright © 2016 Prakhar Rawat. All rights reserved.
//

#import "ViewController.h"
#import "VerifyViewController.h"
#import "ImageEditViewController.h"


@interface ViewController ()
- (IBAction)verifyButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *favButton;
- (IBAction)favButtonTapped:(id)sender;


@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    NSLog(@"%.0f", [[UIScreen mainScreen] bounds].size.width);
    NSLog(@"%.0f", [[UIScreen mainScreen] bounds].size.height);
    self.bannerView.adUnitID = @"ca-app-pub-7315953313336569/1680252739";
    self.bannerView.rootViewController = self;
    [self.bannerView loadRequest:[GADRequest request]];
    GADRequest *request = [GADRequest request];
    request.testDevices = @[ kGADSimulatorID ]; //simulator
    //NSLog(@"sim id %@",kGADSimulatorID);
    [self.bannerView loadRequest:request];
    [self tapForJoke:nil];
//    [self displayContent];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)tapForJoke:(id)sender {
    NSString *fileContents = [[NSBundle mainBundle] pathForResource:@"Facts_Fun" ofType:@"plist"];
    NSDictionary *wordDic = [[NSDictionary alloc] initWithContentsOfFile:fileContents];
    
    NSMutableArray * items = [wordDic valueForKey:@"Facts"];
    int RandomJoke = arc4random() % [items count];
    NSString *word = [items objectAtIndex:RandomJoke];
    NSLog(@"Fact number out of 16 is %i",RandomJoke);
    //self.displayJoke.text=word;
    [self.displayJoke setText:[[NSString alloc] initWithFormat:@"%@", word]];
    self.factNumber.text=[NSString stringWithFormat:@"Fact #%i out of %lu",RandomJoke,(unsigned long)[items count]];
    
}


- (IBAction)settingButton:(id)sender {
    NSLog(@"setting button pressedd");
    
    UIAlertController *alertController=[UIAlertController alertControllerWithTitle:@"Settings" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action1=[UIAlertAction actionWithTitle:@"Edit Image Here!" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
//#warning handle the image editing screen here
        ImageEditViewController *imageVC=[self.storyboard instantiateViewControllerWithIdentifier:@"imageVC"];
        imageVC.title=NSLocalizedString(@"Edit your images here", nil);
        [self.navigationController pushViewController:imageVC animated:YES]; 
    }];;    UIAlertAction *action2=[UIAlertAction actionWithTitle:@"Verify this fact" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
       NSLog(@"Verify handler operation");
       
       VerifyViewController* verifyVC=[self.storyboard instantiateViewControllerWithIdentifier:@"verifyVC"];
       verifyVC.title=NSLocalizedString(@"Verify this fact on Google", nil);
       verifyVC.urlString=[NSString stringWithFormat:@"https://www.google.com/search?q=%@",self.displayJoke.text];
       
       [self.navigationController pushViewController:verifyVC animated:YES];
      
   }];
    UIAlertAction *action3=[UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleCancel handler:nil];
    
    [alertController addAction:action1];
    [alertController addAction:action2];
    [alertController addAction:action3];
 
 [self presentViewController:alertController animated:YES completion:nil];
    

    
}

-(IBAction)shareButton:(id)sender{
    NSLog(@"sharEButton Called");
    NSString *joke=[NSString stringWithString:self.displayJoke.text];
    NSString *shareString=[joke stringByAppendingString:@"Check this App out. It has over 2000 new and amazing facts."];
    
    
    UIActivityViewController *activityViewController =
    [[UIActivityViewController alloc] initWithActivityItems:@[shareString]
                                      applicationActivities:nil];
    [self.navigationController presentViewController:activityViewController
                                            animated:YES
                                          completion:^{
                                          }];
}
- (IBAction)verifyButton:(id)sender {
    
    VerifyViewController* verifyVC=[self.storyboard instantiateViewControllerWithIdentifier:@"verifyVC"];
    verifyVC.title=NSLocalizedString(@"Verify this fact on Google", nil);
    verifyVC.urlString=[NSString stringWithFormat:@"https://www.google.com/search?q=%@",self.displayJoke.text];
    [self.navigationController pushViewController:verifyVC animated:YES];
}
- (IBAction)favButtonTapped:(id)sender {
    NSArray *paths = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    //make a file name to write the data to using the documents directory:

    NSString *fileName = [documentsDirectory stringByAppendingPathComponent:@"MyFavorites.txt"];
                          //documentsDirectory];
    //create content - four lines of text
 
    //  NSString *content = @"One\nTwo\nThree\nFour\nFive";
    
    //save content to the documents directory
    NSString *fact=self.displayJoke.text;
    fact = [fact stringByAppendingString:self.displayJoke.text];
    [self.displayJoke.text writeToFile:fileName
              atomically:YES
                encoding:NSStringEncodingConversionAllowLossy
                   error:nil];
    NSError *error;
    NSString *str = [NSString stringWithContentsOfFile:fileName encoding:NSUTF8StringEncoding error:&error];
    NSLog(@"%@", str);



}

-(void) displayContent{
    //get the documents directory:
    NSArray *paths = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    //make a file name to write the data to using the documents directory:
    NSString *fileName = [NSString stringWithFormat:@"%@/textfile.txt",
                          documentsDirectory];
    NSString *content = [[NSString alloc] initWithContentsOfFile:fileName
                                                    usedEncoding:nil
                                                           error:nil];
    NSLog(@"content is %@",content);
    //use simple alert from my library (see previous post for details)    
}
@end
