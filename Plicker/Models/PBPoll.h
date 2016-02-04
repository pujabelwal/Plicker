//
//  PBPoll.h
//
//  Created by Puja Belwal on 2/1/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PBQuestion, PBResponses;

@interface PBPoll : NSObject <NSCoding, NSCopying>

@property (nullable, nonatomic, copy) NSString *created;
@property (nullable, nonatomic, copy) NSString *section;
@property (nullable, nonatomic, strong) NSArray<PBResponses *> *responses;
@property (nullable, nonatomic, strong) PBQuestion *question;
@property (nullable, nonatomic, copy) NSString *modified;
@property (nullable, nonatomic, copy) NSString *internalBaseClassIdentifier;

+ (nonnull instancetype)modelObjectWithDictionary:(nonnull NSDictionary *)dict;
- (nonnull instancetype)initWithDictionary:(nonnull NSDictionary *)dict;
- (nonnull NSDictionary *)dictionaryRepresentation;

+ (nonnull NSArray<PBPoll *> *)pollsFromJSONArray:(nonnull NSArray *)jsonArray;

@end