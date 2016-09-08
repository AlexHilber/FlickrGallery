//
//  FlickrPhotoViewController.h
//  FlickrGallery
//
//  Created by Alexandra on 9/8/16.
//  Copyright © 2016 Alexandra. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FlickrPhotoViewController : UIViewController <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView* scrollView;
@property (weak, nonatomic) IBOutlet UIImageView* imageView;

- (void)setImagePath:(NSURL*)imagePathInput;

@end
