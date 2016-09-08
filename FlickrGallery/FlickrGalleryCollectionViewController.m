//
//  FlickrGalleryCollectionViewController.m
//  FlickrGallery
//
//  Created by Alexandra on 9/8/16.
//  Copyright © 2016 Alexandra. All rights reserved.
//

#import "FlickrGalleryCollectionViewController.h"
#import "FlickrManager.h"

//Private properties and methods
@interface FlickrGalleryCollectionViewController()

@property (strong, nonatomic) NSArray* flickrPhotos;

@end

@implementation FlickrGalleryCollectionViewController

static NSString* const reuseIdentifier = @"FlickrPhotoCellView";
static CGFloat const photoBufferSize = 10.0f;
static CGFloat const defaultThumbnailSize = 125.0f;

- (void)setFlickrPhotos:(NSArray *)array {
    _flickrPhotos = array;
}

- (void)setEnabled:(bool)enabled {
    self.collectionView.userInteractionEnabled = enabled;
}

- (void)refreshView {
    [self.collectionView reloadData];
}

#pragma mark - FlickrPhotoCellTappedDelegate

- (void)cellTapped:(NSURL*)imagePath {
    if(self.delegate != nil && [self.delegate respondsToSelector:@selector(cellTapped:)]) {
        [self.delegate cellTapped:imagePath];
    }
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.flickrPhotos.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    return CGSizeMake(defaultThumbnailSize, defaultThumbnailSize);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(photoBufferSize, photoBufferSize, photoBufferSize, photoBufferSize);
}

- (FlickrPhotoCellView *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FlickrPhotoCellView *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.delegate = self;
    FlickrPhoto* flickrPhoto = (FlickrPhoto*)[self.flickrPhotos objectAtIndex:indexPath.row];
    [cell setFlickrPhoto:flickrPhoto];
    
    return cell;
}

@end
