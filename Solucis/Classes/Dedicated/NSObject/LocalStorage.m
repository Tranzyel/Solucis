//
//  LocalStorage.m
//  Solucis
//
//  Created by Lam Si Mon on 16-04-21.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import "LocalStorage.h"
#import "MCONationalityModel.h"
#import "MCORegisterTypeModel.h"
#import "MCOLanguageModel.h"
#import "MCOZoneCodeModel.h"
#import "MCOIDTypeModel.h"
#import "MCOChinaBankList.h"
#import "MCOChinaBankStateList.h"
#import "MCOCountryList.h"
#import "MCOStateList.h"

@implementation LocalStorage

+(instancetype)shared
{
    static LocalStorage *localStorage = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        localStorage = [[self alloc] init];
    });
    
    return localStorage;
}


#pragma mark - Property

- (NSString *)userToken
{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:UserTokenKey];
    
    if (token.length > 0)
    {
        return token;
    }
    return @"";
    
}

- (NSString *)userName
{
    NSString *userName = [[NSUserDefaults standardUserDefaults] objectForKey:UserNameKey];
    
    if (userName.length > 0)
    {
        return userName;
    }
    return @"";
}

#pragma mark - Method

- (void)storeObject:(id)object forKey:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] setObject:object forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


- (id)getUserDefaultsObjectForKey:(NSString *)key
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}


#pragma mark - Registration Distributor Member
- (NSArray<NSString*> *)filteredCountryList
{
    NSMutableArray *countries;
    
    if (self.countryLists.count > 0)
    {
        countries = [[NSMutableArray alloc] initWithCapacity:self.countryLists.count];
        
        [self.countryLists enumerateObjectsUsingBlock:^(MCOCountryList* obj, NSUInteger idx, BOOL * _Nonnull stop)
         {
             [countries addObject:obj.f_description];
         }];
    }
    
    return [NSArray arrayWithArray:countries];
}


- (NSArray<NSString*> *)filteredStateList
{
    NSMutableArray *states;
    
    if (self.stateLists.count > 0)
    {
        states = [[NSMutableArray alloc] initWithCapacity:self.stateLists.count];
        
        [self.stateLists enumerateObjectsUsingBlock:^(MCOStateList* obj, NSUInteger idx, BOOL * _Nonnull stop)
         {
             [states addObject:obj.f_description];
         }];
    }
    
    return [NSArray arrayWithArray:states];
}


- (NSArray<NSString*> *)filteredCorrStateList
{
    NSMutableArray *states;
    
    if (self.corrStateLists.count > 0)
    {
        states = [[NSMutableArray alloc] initWithCapacity:self.corrStateLists.count];
        
        [self.corrStateLists enumerateObjectsUsingBlock:^(MCOStateList* obj, NSUInteger idx, BOOL * _Nonnull stop)
         {
             [states addObject:obj.f_description];
         }];
    }
    
    return [NSArray arrayWithArray:states];
}


- (NSArray<NSString*> *)filteredShipStateList
{
    NSMutableArray *states;
    
    if (self.shipStateLists.count > 0)
    {
        states = [[NSMutableArray alloc] initWithCapacity:self.shipStateLists.count];
        
        [self.shipStateLists enumerateObjectsUsingBlock:^(MCOStateList* obj, NSUInteger idx, BOOL * _Nonnull stop)
         {
             [states addObject:obj.f_description];
         }];
    }
    
    return [NSArray arrayWithArray:states];
}


- (NSArray<NSString*> *)filteredNationalities
{
    NSMutableArray *nationalities;
    
    if (self.nationalities.count > 0)
    {
        nationalities = [[NSMutableArray alloc] initWithCapacity:self.nationalities.count];
        
        [self.nationalities enumerateObjectsUsingBlock:^(MCONationalityModel* obj, NSUInteger idx, BOOL * _Nonnull stop)
        {
            [nationalities addObject:obj.f_description];
        }];
    }
    
    return [NSArray arrayWithArray:nationalities];
}


- (NSArray<NSString*> *)filteredRegisteredType
{
    NSMutableArray *registeredType;
    
    if (self.registerTypes.count > 0)
    {
        registeredType = [[NSMutableArray alloc] initWithCapacity:self.registerTypes.count];
        
        [self.registerTypes enumerateObjectsUsingBlock:^(MCORegisterTypeModel* obj, NSUInteger idx, BOOL * _Nonnull stop)
         {
             [registeredType addObject:obj.f_description];
         }];
    }
    
    return [NSArray arrayWithArray:registeredType];
}

- (NSArray<NSString*> *)filteredLanguages
{
    NSMutableArray *languages;
    
    if (self.languages.count > 0)
    {
        languages = [[NSMutableArray alloc] initWithCapacity:self.languages.count];
        
        [self.languages enumerateObjectsUsingBlock:^(MCOLanguageModel* obj, NSUInteger idx, BOOL * _Nonnull stop)
         {
             [languages addObject:obj.f_description];
         }];
    }
    
    return [NSArray arrayWithArray:languages];
}

- (NSArray<NSString*> *)filteredZoneCodes
{
    NSMutableArray *zoneCodes;
    
    if (self.zoneCodes.count > 0)
    {
        zoneCodes = [[NSMutableArray alloc] initWithCapacity:self.zoneCodes.count];
        
        [self.zoneCodes enumerateObjectsUsingBlock:^(MCOZoneCodeModel* obj, NSUInteger idx, BOOL * _Nonnull stop)
         {
             [zoneCodes addObject:obj.zoneCodeWithState];
         }];
    }
    
    return [NSArray arrayWithArray:zoneCodes];
}


- (NSArray<NSString*> *)filteredPaypalZoneCodes
{
    NSMutableArray *zoneCodes;
    
    if (self.zoneCodes.count > 0)
    {
        zoneCodes = [[NSMutableArray alloc] initWithCapacity:self.zoneCodes.count];
        
        [self.zoneCodes enumerateObjectsUsingBlock:^(MCOZoneCodeModel* obj, NSUInteger idx, BOOL * _Nonnull stop)
         {
             [zoneCodes addObject:obj.f_description];
         }];
    }
    
    return [NSArray arrayWithArray:zoneCodes];
}


- (NSArray<NSString*> *)filteredIDTypes
{
    NSMutableArray *idTypes;
    
    if (self.idTypes.count > 0)
    {
        idTypes = [[NSMutableArray alloc] initWithCapacity:self.idTypes.count];
        
        [self.idTypes enumerateObjectsUsingBlock:^(MCOIDTypeModel* obj, NSUInteger idx, BOOL * _Nonnull stop)
         {
             [idTypes addObject:obj.f_description];
         }];
    }
    
    return [NSArray arrayWithArray:idTypes];
}


- (NSArray<NSString*> *)filteredChinaBankStateLists
{
    NSMutableArray *bankStateLists;
    
    if (self.chinaBankStateLists.count > 0) {
        bankStateLists = [[NSMutableArray alloc] initWithCapacity:self.chinaBankStateLists.count];
        
        [self.chinaBankStateLists enumerateObjectsUsingBlock:^(MCOChinaBankStateList* obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [bankStateLists addObject:obj.f_description];
        }];
    }
    return [NSArray arrayWithArray:bankStateLists];
}


- (NSArray<NSString*> *)filteredChinaBankLists
{
    NSMutableArray *bankLists;
    
    if (self.chinaBankLists.count > 0) {
        bankLists = [[NSMutableArray alloc] initWithCapacity:self.chinaBankLists.count];
        
        [self.chinaBankLists enumerateObjectsUsingBlock:^(MCOChinaBankList* obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [bankLists addObject:obj.f_description];
        }];
    }
    return [NSArray arrayWithArray:bankLists];
}


- (NSArray<NSString*> *)filteredChinaBankDistrictLists
{
    NSMutableArray *districtLists;
    
    if (self.chinaBankDistrictLists.count > 0) {
        districtLists = [[NSMutableArray alloc] initWithCapacity:self.chinaBankDistrictLists.count];
        
        [self.chinaBankDistrictLists enumerateObjectsUsingBlock:^(MCOChinaBankList* obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [districtLists addObject:obj.f_description];
        }];
    }
    return [NSArray arrayWithArray:districtLists];
}


- (NSString *)currentLanguage
{
    NSString *selectedLanguage = [[NSUserDefaults standardUserDefaults] objectForKey:@"SelectedLanguageCode"];
    
    if ([selectedLanguage length] > 0)
    {
        return selectedLanguage;
    }
    return @"zh-Hans";
}

- (NSString *)selectedLanguageText
{
    NSString *selectedLanguage = [[NSUserDefaults standardUserDefaults] objectForKey:@"SelectedLanguageText"];
    
    if ([selectedLanguage length] > 0)
    {
        return selectedLanguage;
    }
    return @"中文（简体)";
}

@end

