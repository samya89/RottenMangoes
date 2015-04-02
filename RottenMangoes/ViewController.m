//
//  ViewController.m
//  RottenMangoes
//
//  Created by Samia Al Rahmani on 4/1/15.
//  Copyright (c) 2015 Samia Al Rahmani. All rights reserved.
//

#import "ViewController.h"
#import "MovieCollectionViewCell.h"
#import "SynopsisViewController.h"
#import "Movie.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
//    [self.collectionView registerClass:[MovieCollectionViewCell class] forCellWithReuseIdentifier:@"imageCell"];
    
    NSURL *movieURL = [NSURL URLWithString:@"https://www.kimonolabs.com/api/b556wofw?apikey=aRNY7R61fgpsobkeybrdMRkYywRTJPUF"];
    
    NSData *jsonData = [NSData dataWithContentsOfURL:movieURL];
    
    NSError *error = nil;
    
    NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
    
    NSLog(@"JSON %@", dataDictionary);
    
    self.movies = [NSMutableArray array];
    
    
    NSDictionary *resultsDictionary = [dataDictionary objectForKey:@"results"];
    
    NSMutableArray *movieArray = [resultsDictionary objectForKey:@"collection1"];
    
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
    
    return [self.movies count];
}
- (BOOL) shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}
-(NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    MovieCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"imageCell" forIndexPath:indexPath];
    
    Movie *thisMovie = [self.movies objectAtIndex:indexPath.row];
    
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"viewDetail"]) {
        NSIndexPath *indexPath = [[self.collectionView indexPathsForSelectedItems] objectAtIndex:0];
        Movie *selectedMovie = [Movie new];
        selectedMovie = self.movies[indexPath.row];
        SynopsisViewController *movieDetailVC = [segue destinationViewController];
        [movieDetailVC setDetailItem:selectedMovie];
    }
}



@end
