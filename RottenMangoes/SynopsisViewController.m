//
//  SynopsisViewController.m
//  RottenMangoes
//
//  Created by Samia Al Rahmani on 4/1/15.
//  Copyright (c) 2015 Samia Al Rahmani. All rights reserved.
//

#import "SynopsisViewController.h"
#import "MapViewController.h"
#import "Movie.h"

@interface SynopsisViewController ()

@end

@implementation SynopsisViewController

- (void)setDetailItem:(Movie *)newMovie{
    if (_movie != newMovie) {
        _movie = newMovie;
        
        [self configureView];
    }
}

- (void)configureView {
    if (self.movie) {
        self.detailTitleLabel.text = [self.movie title];
        self.detailSynopsisLabel.text = [self.movie synopsis];
        NSURL *imageURL = [NSURL URLWithString:self.movie.poster];
        NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
        [self.detailImageView setImage:[UIImage imageWithData:imageData]];
//        self.detailImageView.image = [self.movie poster];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configureView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"theatreDetail"]) {
        Movie *selectedMovie = self.movie;
        MapViewController *movieDetailVC = [segue destinationViewController];
        [movieDetailVC setDetailItem:selectedMovie];
    }
}


@end
