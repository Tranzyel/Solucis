//
//  MCOPickerView.m
//  Solucis
//
//  Created by Lam Si Mon on 16-05-11.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import "MCOPickerView.h"
#import "MCOCountryList.h"
#import "MCOStateList.h"
#import "MCOZoneCodeModel.h"

typedef void (^SelectedStringCompletionBlock)(NSString *code, NSString *description, NSString *mobileCountryCode, NSString *identityCode);
typedef void (^CancelPickerBlock)();

@interface MCOPickerView ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneBarButtonItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancelBarItemButton;
@property (weak, nonatomic) IBOutlet UIPickerView *picker;
@property (nonatomic, copy) SelectedStringCompletionBlock completeBlock;
@property (nonatomic, copy) CancelPickerBlock cancelBlock;
@property (nonatomic, assign) PickerType type;
@property (nonatomic, strong) NSArray *data;
@property (nonatomic, strong) NSString *code , *desc , *mobileCountryCode, *identityCode;
@end

@implementation MCOPickerView

- (id)initWithNib
{
    NSArray *array = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([MCOPickerView class]) owner:self options:nil];
    
    for (id obj in array)
    {
        if ([obj isKindOfClass:[MCOPickerView class]])
        {
            MCOPickerView *picker = (MCOPickerView *)obj;
            [picker.cancelBarItemButton setTitle:NSLocalizedString(@"picker_cancel", "")];
            [picker.doneBarButtonItem setTitle:NSLocalizedString(@"picker_done", "")];
            
            return picker;
        }
    }
    return nil;
}

#pragma mark - UIPickerViewDelegate

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (self.type == PickerTypeCountry)
    {
        MCOCountryList *country = self.data[row];
        self.code = country.f_code;
        self.desc = country.f_description;
        self.identityCode = country.f_id;
        NSLog(@"Code : %@" , self.code);
    }
    else if (self.type == PickerTypeMobileCountryCode)
    {
        MCOZoneCodeModel *model = [[LocalStorage shared] zoneCodes][row];
        self.code = model.f_mobile_zone;
        self.mobileCountryCode = [[LocalStorage shared] filteredZoneCodes][row];
    }
    else
    {
        MCOStateList *state = self.data[row];
        self.code = state.f_code;
        self.desc = state.f_description;
        self.identityCode = state.f_id;
    }
}

#pragma mark - UIPickerViewDataSource
- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (self.type == PickerTypeCountry)
    {
        MCOCountryList *country = self.data[row];
        return country.f_description;
    }
    else if (self.type == PickerTypeMobileCountryCode)
    {
        return [[LocalStorage shared] filteredZoneCodes][row];
    }
    else
    {
        MCOStateList *state = self.data[row];
        return state.f_description;
    }
    return @"-";
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.data.count;
}


#pragma mark - Method 

- (void)reloadData
{
    [self.picker reloadAllComponents];
}


#pragma mark - IBAction

- (IBAction)cancelBarButtonDidTouchUp:(id)sender
{
    NSLog(@"Cancel");
    if (self.cancelBlock)
    {
        self.cancelBlock();
    }    
}


- (IBAction)doneButtonDidTouchUp:(id)sender
{
    if (self.completeBlock)
    {
        self.completeBlock(self.code,self.desc,self.mobileCountryCode,self.identityCode);
    }
    
    NSLog(@"Done");
}

- (void)showPickerViewWithType:(PickerType)type withCompletion:(void(^)(NSString *code , NSString *description , NSString *countryCode , NSString *identityCode))completion cancelBlock:(void(^)())cancelBlock;
{
    self.type = type;
    
    if (completion)
    {
        self.completeBlock = completion;
    }
    
    if (cancelBlock)
    {
        self.cancelBlock = cancelBlock;
    }
    
    if (self.type == PickerTypeCountry)
    {
        self.data = [[LocalStorage shared] countryLists];
        MCOCountryList *country = self.data[0];
        self.code = country.f_code;
        self.desc = country.f_description;
        self.identityCode = country.f_id;
    }
    else if (self.type == PickerTypeMobileCountryCode)
    {
        self.data = [[LocalStorage shared] filteredZoneCodes];
        self.mobileCountryCode = [[LocalStorage shared] filteredZoneCodes][0];

    }
    else
    {
        self.data = [[LocalStorage shared] stateLists];
        
        MCOStateList *list = (MCOStateList *)self.data[0];
        self.desc = list.f_description;
        self.identityCode = list.f_id;
    }
    
    [self.picker reloadAllComponents];
}

@end
