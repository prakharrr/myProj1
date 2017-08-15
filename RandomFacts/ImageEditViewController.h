//
//  ImageEditViewController.h
//  RandomFacts
//
//  Created by Prakhar Rawat on 02/07/16.
//  Copyright © 2016 Prakhar Rawat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLImageEditor.h"

@interface ImageEditViewController : UIViewController<UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITabBarDelegate, UIActionSheetDelegate, UIScrollViewDelegate>
{
    IBOutlet __weak UIScrollView *_scrollView;
    IBOutlet __weak UIImageView *_imageView;
}

@end
