//
//  PBChoices.m
//
//  Created by Puja Belwal on 2/1/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "PBChoices.h"


NSString *const kPBChoicesCorrect = @"correct";
NSString *const kPBChoicesBody = @"body";


@interface PBChoices ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation PBChoices

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.correct = [[self objectOrNilForKey:kPBChoicesCorrect fromDictionary:dict] boolValue];
            self.body = [self objectOrNilForKey:kPBChoicesBody fromDictionary:dict];

    }
    
    return self;
    
}

- (NSArray<PBResponses *> *)responses {
    if (!_responses) {
        _responses = [NSMutableArray array];
    }
    return _responses;
}

- (void)addResponse:(PBResponses *)response {
    NSMutableArray *responses = (NSMutableArray *)self.responses;
    if (![responses containsObject:response]) {
        [responses addObject:response];
    }
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithBool:self.correct] forKey:kPBChoicesCorrect];
    [mutableDict setValue:self.body forKey:kPBChoicesBody];

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

    self.correct = [aDecoder decodeBoolForKey:kPBChoicesCorrect];
    self.body = [aDecoder decodeObjectForKey:kPBChoicesBody];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeBool:_correct forKey:kPBChoicesCorrect];
    [aCoder encodeObject:_body forKey:kPBChoicesBody];
}

- (id)copyWithZone:(NSZone *)zone
{
    PBChoices *copy = [[PBChoices alloc] init];
    
    if (copy) {

        copy.correct = self.correct;
        copy.body = [self.body copyWithZone:zone];
    }
    
    return copy;
}


@end
