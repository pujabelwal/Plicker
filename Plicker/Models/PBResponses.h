//
//  PBResponses.h
//
//  Created by Puja Belwal on 2/1/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@class PBChoices;

@interface PBResponses : NSObject <NSCoding, NSCopying>

@property (nullable, nonatomic, copy) NSString *student;
@property (nonnull, nonatomic, copy) NSString *answer;
@property (nonatomic, assign) double card;

@property (nullable, nonatomic, weak) PBChoices *choice;

+ (nonnull instancetype)modelObjectWithDictionary:(nonnull NSDictionary *)dict;
- (nonnull instancetype)initWithDictionary:(nonnull NSDictionary *)dict;
- (nonnull NSDictionary *)dictionaryRepresentation;

@end
