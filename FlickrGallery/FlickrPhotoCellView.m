//
//  FlickrPhotoCellView.m
//  FlickrGallery
//
//  Created by Alexandra on 9/8/16.
//  Copyright © 2016 Alexandra. All rights reserved.
//

#import "FlickrPhotoCellView.h"
#import "AnimationUtils.h"

//Private properties and methods
@interface FlickrPhotoCellView()

@property (strong, nonatomic) NSURL* imagePath;
@property (strong, nonatomic) FlickrPhoto* flickrPhoto;
@property (strong, nonatomic) NSTimer* animationTimer;

@end

@implementation FlickrPhotoCellView

static int const wiggleAnimationMinInterval = 5; //seconds
static int const wiggleAnimationMaxInterval = 15; //seconds
static CGFloat const seenLowAlpha = 0.4f;
static NSString* const flickrThumbnailSizeRef = @"m";
static NSString* const flickrLargeImageSizeRef = @"b";

- (void)setFlickrPhoto:(FlickrPhoto *)photo {
    _flickrPhoto = photo;
    
    if (photo != nil) {
        _imagePath = [photo flickrImageURLWithSize:flickrThumbnailSizeRef];
        [self setPhoto];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setPhoto];
    [self animateWiggle];
}

- (void)setPhoto {
    //Setup image if image view and image path are available
    if (self.imageView != nil && self.imagePath != nil) {
        NSData *imageData = [NSData dataWithContentsOfURL:self.imagePath];
        self.imageView.image = [UIImage imageWithData:imageData];
        
        //Check user defaults to see if this image has already been viewed. If so, reduce opacity
        NSURL* largeImagePath = [self.flickrPhoto flickrImageURLWithSize:flickrLargeImageSizeRef];
        NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
        if ([defaults boolForKey:largeImagePath.path]) {
            self.imageView.alpha = seenLowAlpha;
        } else {
            self.imageView.alpha = 1.0f;
        }
    }
}

- (IBAction)cellTapped {
    //Pass up message to main vc to open new page with large size image of this photo
    if(self.delegate != nil && [self.delegate respondsToSelector:@selector(cellTapped:)]) {
        if (self.flickrPhoto != nil) {
            [self.delegate cellTapped:[self.flickrPhoto flickrImageURLWithSize:flickrLargeImageSizeRef]];
            self.imageView.alpha = seenLowAlpha;
        }
    }
}

- (void)animateWiggle {
    //Wiggle at random intervals of about 10 seconds for visual intereset while browsing
    if (self.animationTimer != nil && self.hidden == NO) {
        [UIView animateWithDuration:0
                         animations:^{[self.layer addAnimation:[AnimationUtils wiggleAnimation] forKey:@"rotation"];}];
    }
    [self.animationTimer invalidate];
    self.animationTimer = nil;
    
    int randomTimeInterval = wiggleAnimationMinInterval + arc4random_uniform(wiggleAnimationMaxInterval-wiggleAnimationMinInterval);
    self.animationTimer = [NSTimer scheduledTimerWithTimeInterval:randomTimeInterval target:self selector:@selector(animateWiggle) userInfo:nil repeats:NO];
}

@end