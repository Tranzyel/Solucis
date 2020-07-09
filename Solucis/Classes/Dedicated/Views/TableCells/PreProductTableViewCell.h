//
//  PreProductTableViewCell.h
//  Solucis
//
//  Created by Lam Si Mon on 16-09-16.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PreProductTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *productName;
@property (weak, nonatomic) IBOutlet UILabel *productPrice;
@property (weak, nonatomic) IBOutlet UILabel *productGST;
@property (weak, nonatomic) IBOutlet UILabel *productBV;
@property (weak, nonatomic) IBOutlet UILabel *productPV;
@property (weak, nonatomic) IBOutlet UILabel *gstLoc;
@property (weak, nonatomic) IBOutlet UIImageView *productImage;
@property (weak, nonatomic) IBOutlet UILabel *productShortDetails;

@end
