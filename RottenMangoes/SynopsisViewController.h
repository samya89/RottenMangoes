//
//  SynopsisViewController.h
//  RottenMangoes
//
//  Created by Samia Al Rahmani on 4/1/15.
//  Copyright (c) 2015 Samia Al Rahmani. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Movie;

@interface SynopsisViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *detailImageView;
@property (weak, nonatomic) IBOutlet UILabel *detailTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailSynopsisLabel;

@property (nonatomic, strong) Movie *movie;
@property (strong, nonatomic) NSMutableArray *movies;

- (void)setDetailItem:(Movie *)newMovie;


@end
