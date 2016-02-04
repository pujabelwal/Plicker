//
//  PBResponses.m
//
//  Created by Puja Belwal on 2/1/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "PBResponses.h"

NSString *const kPBResponsesStudent = @"student";
NSString *const kPBResponsesAnswer = @"answer";
NSString *const kPBResponsesCard = @"card";


@interface PBResponses ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation PBResponses

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.student = [self objectOrNilForKey:kPBResponsesStudent fromDictionary:dict];
            self.answer = [self objectOrNilForKey:kPBResponsesAnswer fromDictionary:dict];
            self.card = [[self objectOrNilForKey:kPBResponsesCard fromDictionary:dict] doubleValue];

    }
    return self;
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.student forKey:kPBResponsesStudent];
    [mutableDict setValue:self.answer forKey:kPBResponsesAnswer];
    [mutableDict setValue:[NSNumber numberWithDouble:self.card] forKey:kPBResponsesCard];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.student = [aDecoder decodeObjectForKey:kPBResponsesStudent];
    self.answer = [aDecoder decodeObjectForKey:kPBResponsesAnswer];
    self.card = [aDecoder decodeDoubleForKey:kPBResponsesCard];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_student forKey:kPBResponsesStudent];
    [aCoder encodeObject:_answer forKey:kPBResponsesAnswer];
    [aCoder encodeDouble:_card forKey:kPBResponsesCard];
}

- (id)copyWithZone:(NSZone *)zone
{
    PBResponses *copy = [[PBResponses alloc] init];
    
    if (copy) {

        copy.student = [self.student copyWithZone:zone];
        copy.answer = [self.answer copyWithZone:zone];
        copy.card = self.card;
    }
    
    return copy;
}


@end
