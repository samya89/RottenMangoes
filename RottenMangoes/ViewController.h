//
//  ViewController.h
//  RottenMangoes
//
//  Created by Samia Al Rahmani on 4/1/15.
//  Copyright (c) 2015 Samia Al Rahmani. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface ViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate, NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (strong, nonatomic) NSMutableArray *movies;
@property(nonatomic, weak) IBOutlet UICollectionView *collectionView;


@end



