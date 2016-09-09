//
//  ViewController.h
//  FlickrGallery
//
//  Created by Alexandra on 9/8/16.
//  Copyright © 2016 Alexandra. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>
#import "FlickrGalleryCollectionViewController.h"

@interface MainViewController : UIViewController <FlickrPhotoCellTappedDelegate, CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UIButton* refreshButton;

- (IBAction)loadFlickrPhotos;
- (void)cellTapped:(NSURL*)imagePath;

@end