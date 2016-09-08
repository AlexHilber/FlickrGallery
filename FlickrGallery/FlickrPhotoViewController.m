//
//  FlickrPhotoViewController.m
//  FlickrGallery
//
//  Created by Alexandra on 9/8/16.
//  Copyright © 2016 Alexandra. All rights reserved.
//

#import "FlickrPhotoViewController.h"

//Private properties and methods
@interface FlickrPhotoViewController ()

@property (strong, nonatomic) NSURL* imagePath;

@end

@implementation FlickrPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Setup image if image view and image path are available
    if (self.imageView != nil && self.imagePath != nil) {
        NSData *imageData = [NSData dataWithContentsOfURL:self.imagePath];
        self.imageView.image = [UIImage imageWithData:imageData];
        
        //Set in user defaults that this image has been seen
        NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
        [defaults setBool:YES forKey:self.imagePath.path];
        [defaults synchronize];
    }
}

- (void)setImagePath:(NSURL *)imagePathInput {
    _imagePath = imagePathInput;
}

@end
