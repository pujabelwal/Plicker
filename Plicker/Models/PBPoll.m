//
//  PBPoll.m
//
//  Created by Puja Belwal on 2/1/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "PBPoll.h"
#import "PBResponses.h"
#import "PBQuestion.h"
#import "PBChoices.h"

NSString *const kPBPollCreated = @"created";
NSString *const kPBPollSection = @"section";
NSString *const kPBPollResponses = @"responses";
NSString *const kPBPollQuestion = @"question";
NSString *const kPBPollModified = @"modified";
NSString *const kPBPollId = @"id";

static NSDictionary *AlphabetLookup;

@interface PBPoll ()

@property (nonatomic, strong) NSDictionary *dictionary;

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation PBPoll

+ (NSArray *)pollsFromJSONArray:(NSArray *)jsonArray {
    NSMutableArray *pollsArray = [NSMutableArray array];
    for (NSDictionary *jsonDictionary in jsonArray) {
        PBPoll *poll = [self modelObjectWithDictionary:jsonDictionary];
        if (poll) {
            [pollsArray addObject:poll];
        }
    }
    return pollsArray;
}

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
            self.created = [self objectOrNilForKey:kPBPollCreated fromDictionary:dict];
            self.section = [self objectOrNilForKey:kPBPollSection fromDictionary:dict];
    NSObject *receivedPBResponses = [dict objectForKey:kPBPollResponses];
    NSMutableArray *parsedPBResponses = [NSMutableArray array];
    if ([receivedPBResponses isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedPBResponses) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedPBResponses addObject:[PBResponses modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedPBResponses isKindOfClass:[NSDictionary class]]) {
       [parsedPBResponses addObject:[PBResponses modelObjectWithDictionary:(NSDictionary *)receivedPBResponses]];
    }

    self.responses = [NSArray arrayWithArray:parsedPBResponses];
    self.question = [PBQuestion modelObjectWithDictionary:[dict objectForKey:kPBPollQuestion]];
    self.modified = [self objectOrNilForKey:kPBPollModified fromDictionary:dict];
    self.internalBaseClassIdentifier = [self objectOrNilForKey:kPBPollId fromDictionary:dict];

        for (PBResponses *response in self.responses) {
            NSInteger index = [[self class]indexFromAlphabet:response.answer];
            if (index != NSNotFound && index < self.question.choices.count) {
                PBChoices *choice = self.question.choices[index];
                [choice addResponse:response];
                response.choice = choice;
            } else {
                NSLog(@"index:%@, choice count:%@", @(index), @(self.question.choices.count));
            }
        }
    }
    
    return self;
    
}

+ (NSInteger)indexFromAlphabet:(NSString *)alphabet {
    if (!alphabet) {
        return NSNotFound;
    }
    if (!AlphabetLookup) {
        AlphabetLookup = @{@"A":@0, @"B": @1, @"C":@2, @"D":@3, @"E":@4, @"F":@5,
                           @"G":@6, @"H":@7};
    }
    NSNumber *index = AlphabetLookup[alphabet];
    return index ? index.integerValue : NSNotFound;
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.created forKey:kPBPollCreated];
    [mutableDict setValue:self.section forKey:kPBPollSection];
    NSMutableArray *tempArrayForResponses = [NSMutableArray array];
    for (NSObject *subArrayObject in self.responses) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForResponses addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForResponses addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForResponses] forKey:kPBPollResponses];
    [mutableDict setValue:[self.question dictionaryRepresentation] forKey:kPBPollQuestion];
    [mutableDict setValue:self.modified forKey:kPBPollModified];
    [mutableDict setValue:self.internalBaseClassIdentifier forKey:kPBPollId];

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

    self.created = [aDecoder decodeObjectForKey:kPBPollCreated];
    self.section = [aDecoder decodeObjectForKey:kPBPollSection];
    self.responses = [aDecoder decodeObjectForKey:kPBPollResponses];
    self.question = [aDecoder decodeObjectForKey:kPBPollQuestion];
    self.modified = [aDecoder decodeObjectForKey:kPBPollModified];
    self.internalBaseClassIdentifier = [aDecoder decodeObjectForKey:kPBPollId];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_created forKey:kPBPollCreated];
    [aCoder encodeObject:_section forKey:kPBPollSection];
    [aCoder encodeObject:_responses forKey:kPBPollResponses];
    [aCoder encodeObject:_question forKey:kPBPollQuestion];
    [aCoder encodeObject:_modified forKey:kPBPollModified];
    [aCoder encodeObject:_internalBaseClassIdentifier forKey:kPBPollId];
}

- (id)copyWithZone:(NSZone *)zone
{
    PBPoll *copy = [[PBPoll alloc] init];
    
    if (copy) {

        copy.created = [self.created copyWithZone:zone];
        copy.section = [self.section copyWithZone:zone];
        copy.responses = [self.responses copyWithZone:zone];
        copy.question = [self.question copyWithZone:zone];
        copy.modified = [self.modified copyWithZone:zone];
        copy.internalBaseClassIdentifier = [self.internalBaseClassIdentifier copyWithZone:zone];
    }
    
    return copy;
}


@end
