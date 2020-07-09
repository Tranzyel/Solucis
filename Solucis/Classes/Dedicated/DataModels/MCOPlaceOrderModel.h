//
//  MCOPlaceOrderModel.h
//  Solucis
//
//  Created by Lam Si Mon on 16-04-27.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCOPlaceOrderModel : MTLModel <MTLJSONSerializing>
@property(nonatomic, strong)NSString *f_is_promo;
@property(nonatomic, strong)NSString *f_products_type;
@property(nonatomic, strong)NSString *f_unit_bv;
@property(nonatomic, strong)NSString *f_unit_discount;
@property(nonatomic, strong)NSString *f_unit_pv;
@property(nonatomic, strong)NSString *f_unit_tax;
@property(nonatomic, strong)NSString *image;
@property(nonatomic, strong)NSString *name;
@property(nonatomic, strong)NSString *products_aftax_price;
@property(nonatomic, strong)NSString *products_id;
@property(nonatomic, strong)NSString *products_weight;
@property(nonatomic, strong)NSString *sku;
@property(nonatomic, strong)NSString *products_description;
@property(nonatomic, strong)NSString *products_short_description;
@property(nonatomic, strong)UIImage *productImage;
@property(nonatomic, assign)NSInteger totalSelectedItem;
@property(nonatomic, assign)CGFloat itemTotalPrice;
@end
