//
//  ViewController.m
//  RottenMangoes
//
//  Created by Samia Al Rahmani on 4/1/15.
//  Copyright (c) 2015 Samia Al Rahmani. All rights reserved.
//

#import "ViewController.h"
#import "MovieCollectionViewCell.h"
#import "Movie.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    [self.collectionView registerClass:[MovieCollectionViewCell class] forCellWithReuseIdentifier:@"imageCell"];

    NSURL *movieURL = [NSURL URLWithString:@"https://www.kimonolabs.com/api/b556wofw?apikey=aRNY7R61fgpsobkeybrdMRkYywRTJPUF"];
    
    NSData *jsonData = [NSData dataWithContentsOfURL:movieURL];
    
    NSError *error = nil;
    
    NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
    
    NSLog(@"JSON %@", dataDictionary);
    
    self.movies = [NSMutableArray array];
    
    NSDictionary *resultsDictionary = [dataDictionary objectForKey:@"results"];
    
    NSMutableArray *movieArray = [resultsDictionary objectForKey:@"collection1"];
//    movie.title =  [collectionDictionary objectForKey:@"title"];
          //  movie.title = [collectionDictionary objectForKey:@"title"];
           // movie.synopsis = [collectionDictionary objectForKey:@"synopsis"];
            //movie.poster = [collectionDictionary objectForKey:@"poster"];
    
    
    for (NSDictionary *movieDictionary in movieArray) {

        Movie *movie = [[Movie alloc]initWithDictionary:movieDictionary];

        [self.movies addObject:movie];
    }
    [self.collectionView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
   // NSArray *sectionArray = self.movies[section];
    
    return 1;//[sectionArray count];
}

-(NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return [self.movies count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    MovieCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"imageCell" forIndexPath:indexPath];
    
    Movie *thisMovie = [self.movies objectAtIndex:indexPath.section];
    
    NSURL *imageURL = [NSURL URLWithString:thisMovie.poster];
    NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
    [cell.posterImageView setImage:[UIImage imageWithData:imageData]];
    cell.movieTitleLabel.text = thisMovie.title;
    
    return cell;
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath{
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]){
        UICollectionReusableView *headerView = [self.collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"sectionHeader" forIndexPath:indexPath];
        return headerView;
    }
    return nil;
}


@end
