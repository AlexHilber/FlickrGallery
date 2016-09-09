//
//  FlickrPhotoCellView.h
//  FlickrGallery
//
//  Created by Alexandra on 9/8/16.
//  Copyright © 2016 Alexandra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlickrManager.h"

@protocol FlickrPhotoCellTappedDelegate;

@interface FlickrPhotoCellView : UICollectionViewCell

@property (weak, nonatomic) id<FlickrPhotoCellTappedDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIImageView* imageView;

- (void)setFlickrPhoto:(FlickrPhoto*)photo;
- (IBAction)cellTapped;

@end

@protocol FlickrPhotoCellTappedDelegate <NSObject>

- (void)cellTapped:(NSURL*)imagePath;

@end