//
//  FlickrGalleryCollectionViewController.h
//  FlickrGallery
//
//  Created by Alexandra on 9/8/16.
//  Copyright © 2016 Alexandra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlickrPhotoCellView.h"

@interface FlickrGalleryCollectionViewController : UICollectionViewController <FlickrPhotoCellTappedDelegate>

@property (weak, nonatomic) id<FlickrPhotoCellTappedDelegate> delegate;

- (void)setFlickrPhotos:(NSArray*)array;
- (void)setEnabled:(bool)enabled;
- (void)refreshView;
- (void)cellTapped:(NSURL *)imagePath;

@end
