//
//  PBQuestion.m
//
//  Created by Puja Belwal on 2/1/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "PBQuestion.h"
#import "PBChoices.h"


NSString *const kPBQuestionBody = @"body";
NSString *const kPBQuestionId = @"id";
NSString *const kPBQuestionCreated = @"created";
NSString *const kPBQuestionImage = @"image";
NSString *const kPBQuestionModified = @"modified";
NSString *const kPBQuestionChoices = @"choices";


@interface PBQuestion ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation PBQuestion

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
            self.body = [self objectOrNilForKey:kPBQuestionBody fromDictionary:dict];
            self.questionIdentifier = [self objectOrNilForKey:kPBQuestionId fromDictionary:dict];
            self.created = [self objectOrNilForKey:kPBQuestionCreated fromDictionary:dict];
            self.image = [self objectOrNilForKey:kPBQuestionImage fromDictionary:dict];
            self.modified = [self objectOrNilForKey:kPBQuestionModified fromDictionary:dict];
    NSObject *receivedPBChoices = [dict objectForKey:kPBQuestionChoices];
    NSMutableArray *parsedPBChoices = [NSMutableArray array];
    if ([receivedPBChoices isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedPBChoices) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedPBChoices addObject:[PBChoices modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedPBChoices isKindOfClass:[NSDictionary class]]) {
       [parsedPBChoices addObject:[PBChoices modelObjectWithDictionary:(NSDictionary *)receivedPBChoices]];
    }

    self.choices = [NSArray arrayWithArray:parsedPBChoices];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.body forKey:kPBQuestionBody];
    [mutableDict setValue:self.questionIdentifier forKey:kPBQuestionId];
    [mutableDict setValue:self.created forKey:kPBQuestionCreated];
    [mutableDict setValue:self.image forKey:kPBQuestionImage];
    [mutableDict setValue:self.modified forKey:kPBQuestionModified];
    NSMutableArray *tempArrayForChoices = [NSMutableArray array];
    for (NSObject *subArrayObject in self.choices) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForChoices addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForChoices addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForChoices] forKey:kPBQuestionChoices];

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

    self.body = [aDecoder decodeObjectForKey:kPBQuestionBody];
    self.questionIdentifier = [aDecoder decodeObjectForKey:kPBQuestionId];
    self.created = [aDecoder decodeObjectForKey:kPBQuestionCreated];
    self.image = [aDecoder decodeObjectForKey:kPBQuestionImage];
    self.modified = [aDecoder decodeObjectForKey:kPBQuestionModified];
    self.choices = [aDecoder decodeObjectForKey:kPBQuestionChoices];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_body forKey:kPBQuestionBody];
    [aCoder encodeObject:_questionIdentifier forKey:kPBQuestionId];
    [aCoder encodeObject:_created forKey:kPBQuestionCreated];
    [aCoder encodeObject:_image forKey:kPBQuestionImage];
    [aCoder encodeObject:_modified forKey:kPBQuestionModified];
    [aCoder encodeObject:_choices forKey:kPBQuestionChoices];
}

- (id)copyWithZone:(NSZone *)zone
{
    PBQuestion *copy = [[PBQuestion alloc] init];
    
    if (copy) {

        copy.body = [self.body copyWithZone:zone];
        copy.questionIdentifier = [self.questionIdentifier copyWithZone:zone];
        copy.created = [self.created copyWithZone:zone];
        copy.image = [self.image copyWithZone:zone];
        copy.modified = [self.modified copyWithZone:zone];
        copy.choices = [self.choices copyWithZone:zone];
    }
    
    return copy;
}


@end
