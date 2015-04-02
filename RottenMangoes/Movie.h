//
//  Movie.h
//  RottenMangoes
//
//  Created by Samia Al Rahmani on 4/1/15.
//  Copyright (c) 2015 Samia Al Rahmani. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h> 

@interface Movie : NSObject

@property (nonatomic) NSString *title;
@property (nonatomic) NSString *synopsis;
@property (nonatomic) NSString *poster;

- (instancetype)initWithDictionary:(NSDictionary *)movieDictionary;

@end


