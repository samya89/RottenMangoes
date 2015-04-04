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

static NSString *CellIdentifier = @"AFCollectionViewCell";

@interface ViewController ()

@property (nonatomic, strong) NSMutableDictionary *objectChanges;
@property (nonatomic, strong) NSMutableDictionary *sectionChanges;

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

//        Movie *movie = [[Movie alloc]initWithDictionary:movieDictionary];

//        [self.movies addObject:movie];
    }
    [self.collectionView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    return [sectionInfo numberOfObjects];
}

- (BOOL) shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}

-(NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return [[self.fetchedResultsController sections] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    MovieCollectionViewCell *cell = (MovieCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSManagedObject *object = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
//    MovieCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"imageCell" forIndexPath:indexPath];
    
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

#pragma mark - segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"viewDetail"]) {
        NSIndexPath *indexPath = [[self.collectionView indexPathsForSelectedItems] objectAtIndex:0];
        Movie *selectedMovie = [Movie new];
        selectedMovie = self.movies[indexPath.row];
        SynopsisViewController *movieDetailVC = [segue destinationViewController];
        [movieDetailVC setDetailItem:selectedMovie];
    }
}

#pragma mark - fetch results controller

- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Movie" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"poster" ascending:NO];
    NSArray *sortDescriptors = @[sortDescriptor];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:@"Master"];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
    NSError *error = nil;
    if (![self.fetchedResultsController performFetch:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _fetchedResultsController;
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    self.objectChanges = [NSMutableDictionary dictionary];
    self.sectionChanges = [NSMutableDictionary dictionary];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    if (type == NSFetchedResultsChangeInsert || type == NSFetchedResultsChangeDelete) {
        NSMutableIndexSet *changeSet = self.sectionChanges[@(type)];
        if (changeSet != nil) {
            [changeSet addIndex:sectionIndex];
        } else {
            self.sectionChanges[@(type)] = [[NSMutableIndexSet alloc] initWithIndex:sectionIndex];
        }
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    NSMutableArray *changeSet = self.objectChanges[@(type)];
    if (changeSet == nil) {
        changeSet = [[NSMutableArray alloc] init];
        self.objectChanges[@(type)] = changeSet;
    }
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [changeSet addObject:newIndexPath];
            break;
        case NSFetchedResultsChangeDelete:
            [changeSet addObject:indexPath];
            break;
        case NSFetchedResultsChangeUpdate:
            [changeSet addObject:indexPath];
            break;
        case NSFetchedResultsChangeMove:
            [changeSet addObject:@[indexPath, newIndexPath]];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    NSMutableArray *moves = self.objectChanges[@(NSFetchedResultsChangeMove)];
    if (moves.count > 0) {
        NSMutableArray *updatedMoves = [[NSMutableArray alloc] initWithCapacity:moves.count];
        
        NSMutableIndexSet *insertSections = self.sectionChanges[@(NSFetchedResultsChangeInsert)];
        NSMutableIndexSet *deleteSections = self.sectionChanges[@(NSFetchedResultsChangeDelete)];
        for (NSArray *move in moves) {
            NSIndexPath *fromIP = move[0];
            NSIndexPath *toIP = move[1];
            
            if ([deleteSections containsIndex:fromIP.section]) {
                if (![insertSections containsIndex:toIP.section]) {
                    NSMutableArray *changeSet = self.objectChanges[@(NSFetchedResultsChangeInsert)];
                    if (changeSet == nil) {
                        changeSet = [[NSMutableArray alloc] initWithObjects:toIP, nil];
                        self.objectChanges[@(NSFetchedResultsChangeInsert)] = changeSet;
                    } else {
                        [changeSet addObject:toIP];
                    }
                }
            } else if ([insertSections containsIndex:toIP.section]) {
                NSMutableArray *changeSet = self.objectChanges[@(NSFetchedResultsChangeDelete)];
                if (changeSet == nil) {
                    changeSet = [[NSMutableArray alloc] initWithObjects:fromIP, nil];
                    self.objectChanges[@(NSFetchedResultsChangeDelete)] = changeSet;
                } else {
                    [changeSet addObject:fromIP];
                }
            } else {
                [updatedMoves addObject:move];
            }
        }
        
        if (updatedMoves.count > 0) {
            self.objectChanges[@(NSFetchedResultsChangeMove)] = updatedMoves;
        } else {
            [self.objectChanges removeObjectForKey:@(NSFetchedResultsChangeMove)];
        }
    }
    
    NSMutableArray *deletes = self.objectChanges[@(NSFetchedResultsChangeDelete)];
    if (deletes.count > 0) {
        NSMutableIndexSet *deletedSections = self.sectionChanges[@(NSFetchedResultsChangeDelete)];
        [deletes filterUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(NSIndexPath *evaluatedObject, NSDictionary *bindings) {
            return ![deletedSections containsIndex:evaluatedObject.section];
        }]];
    }
    
    NSMutableArray *inserts = self.objectChanges[@(NSFetchedResultsChangeInsert)];
    if (inserts.count > 0) {
        NSMutableIndexSet *insertedSections = self.sectionChanges[@(NSFetchedResultsChangeInsert)];
        [inserts filterUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(NSIndexPath *evaluatedObject, NSDictionary *bindings) {
            return ![insertedSections containsIndex:evaluatedObject.section];
        }]];
    }
    
    UICollectionView *collectionView = self.collectionView;
    
    [collectionView performBatchUpdates:^{
        NSIndexSet *deletedSections = self.sectionChanges[@(NSFetchedResultsChangeDelete)];
        if (deletedSections.count > 0) {
            [collectionView deleteSections:deletedSections];
        }
        
        NSIndexSet *insertedSections = self.sectionChanges[@(NSFetchedResultsChangeInsert)];
        if (insertedSections.count > 0) {
            [collectionView insertSections:insertedSections];
        }
        
        NSArray *deletedItems = self.objectChanges[@(NSFetchedResultsChangeDelete)];
        if (deletedItems.count > 0) {
            [collectionView deleteItemsAtIndexPaths:deletedItems];
        }
        
        NSArray *insertedItems = self.objectChanges[@(NSFetchedResultsChangeInsert)];
        if (insertedItems.count > 0) {
            [collectionView insertItemsAtIndexPaths:insertedItems];
        }
        
        NSArray *reloadItems = self.objectChanges[@(NSFetchedResultsChangeUpdate)];
        if (reloadItems.count > 0) {
            [collectionView reloadItemsAtIndexPaths:reloadItems];
        }
        
        NSArray *moveItems = self.objectChanges[@(NSFetchedResultsChangeMove)];
        for (NSArray *paths in moveItems) {
            [collectionView moveItemAtIndexPath:paths[0] toIndexPath:paths[1]];
        }
    } completion:nil];
    
    self.objectChanges = nil;
    self.sectionChanges = nil;
}





@end
