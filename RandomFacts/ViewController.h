//
//  ViewController.h
//  RandomFacts
//
//  Created by Prakhar Rawat on 24/06/16.
//  Copyright © 2016 Prakhar Rawat. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "TodayViewController.h"
@import GoogleMobileAds;

@interface ViewController : UIViewController
- (IBAction)tapForJoke:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *displayJoke;
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UILabel *factNumber;
- (IBAction)settingButton:(id)sender;
-(IBAction)shareButton:(id)sender;
@property (weak, nonatomic) IBOutlet GADBannerView *bannerView;
@property (weak, nonatomic) IBOutlet UIView *animatedViewShowFact;
@property (weak, nonatomic) IBOutlet UILabel *animatedViewFactNumber;
@property (weak, nonatomic) IBOutlet UIButton *tapForFact;


@end

