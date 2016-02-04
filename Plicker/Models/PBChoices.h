//
//  PBChoices.h
//
//  Created by Puja Belwal on 2/1/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@class PBResponses;

@interface PBChoices : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) BOOL correct;
@property (nonatomic, copy) NSString *body;
/*! Responses that have selected this choice */
@property (nonatomic, strong) NSArray<PBResponses *> *responses;

@property (nonatomic, copy) NSString *choiceAlphabet;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

- (void)addResponse:(PBResponses *)response;

@end
