//
//  PBQuestion.h
//
//  Created by Puja Belwal on 2/1/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PBChoices;

@interface PBQuestion : NSObject <NSCoding, NSCopying>

@property (nullable, nonatomic, copy) NSString *body;
@property (nonnull, nonatomic, copy) NSString *questionIdentifier;
@property (nonnull, nonatomic, copy) NSString *created;
@property (nullable, nonatomic, copy) NSString *image;
@property (nullable, nonatomic, copy) NSString *modified;
@property (nonnull, nonatomic, strong) NSArray<PBChoices *> *choices;

+ (nonnull instancetype)modelObjectWithDictionary:(nonnull NSDictionary *)dict;
- (nonnull instancetype)initWithDictionary:(nonnull NSDictionary *)dict;
- (nonnull NSDictionary *)dictionaryRepresentation;

@end
