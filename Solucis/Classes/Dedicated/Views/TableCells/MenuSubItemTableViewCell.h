//
//  MenuSubItemTableViewCell.h
//  Solucis
//
//  Created by Lam Si Mon on 16-08-16.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuSubItemTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *subMenus;
@property (weak, nonatomic) IBOutlet UILabel *personalSalesHistoryLbl;
@property (weak, nonatomic) IBOutlet UILabel *allSalesHistoryLbl;
@property (weak, nonatomic) IBOutlet UILabel *aboutUsLbl;
@property (weak, nonatomic) IBOutlet UILabel *exclusiveStoreListingLbl;
@property (weak, nonatomic) IBOutlet UILabel *distributorEPointLbl;
@property (weak, nonatomic) IBOutlet UILabel *eAccountStatementLbl;
@property (weak, nonatomic) IBOutlet UILabel *eAccountTransferLbl;
@property (weak, nonatomic) IBOutlet UILabel *salesBonusLbl;
@property (weak, nonatomic) IBOutlet UILabel *announcementLbl;
//@property (weak, nonatomic) IBOutlet UILabel *leadManagementLbl;

@end
