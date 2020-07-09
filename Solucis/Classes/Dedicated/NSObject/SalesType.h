//
//  SalesType.h
//  Solucis
//
//  Created by Lam Si Mon on 16-05-07.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#ifndef SalesType_h
#define SalesType_h

typedef NS_ENUM(NSUInteger,SalesType)
{
    PersonalSalesHistoryType = 0,
    AllSalesHistoryType,
    SalesBonusType
};

typedef NS_ENUM(NSUInteger,FlowType)
{
    EAccountType = 0,
    EPointType
};

typedef NS_ENUM (NSUInteger , PickerType)
{
    PickerTypeCountry,
    PickerTypeState,
    PickerTypeMobileCountryCode
};

typedef NS_ENUM (NSUInteger , RDMemberPickerType)
{
    PickerTypeNationality,
    PickerTypeRegisterType,
    PickerTypeDOB,
    PickerTypeLanguage,
    PickerTypeID
};

typedef NS_ENUM (NSUInteger , RDDeliveryInfoType)
{
    DeliveryInfoAddress,
    DeliveryInfoReceiverName,
    DeliveryInfoPostCode,
    DeliveryInfoCity,
    DeliveryInfoMobilePhone,
    DeliveryInfoAddress2,
    DeliveryInfoAddress3,
    DeliveryInfoAddress4,
    DeliveryICNumber
};

typedef NS_ENUM (NSUInteger , RDBankAccountPickerType)
{
    BankInfoPickerChinaBank,
    BankInfoPickerChinaState,
    BankInfoPickerChinaDistrict
};

typedef NS_ENUM(NSUInteger , BankAccountInfoSectionDropDown)
{
    BankInfoChinaBank,
    BankInfoChinaState,
    BankInfoChinaDistrict
};

#endif /* SalesType_h */
