//
//  ExclusiveStoreListTableViewCell.h
//  Solucis
//
//  Created by Lam Si Mon on 16-08-16.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExclusiveStoreListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *memberCode;
@property (weak, nonatomic) IBOutlet UILabel *memberName;
@property (weak, nonatomic) IBOutlet UILabel *sponsorCode;
@property (weak, nonatomic) IBOutlet UILabel *mobileNum;
@property (weak, nonatomic) IBOutlet UILabel *joinedDate;
@property (weak, nonatomic) IBOutlet UILabel *rank;

//Localization

@property (weak, nonatomic) IBOutlet UILabel *memberCodeLoc;
@property (weak, nonatomic) IBOutlet UILabel *nameLoc;
@property (weak, nonatomic) IBOutlet UILabel *sponsorCodeLoc;
@property (weak, nonatomic) IBOutlet UILabel *mobileLoc;
@property (weak, nonatomic) IBOutlet UILabel *joinedDateLoc;
@property (weak, nonatomic) IBOutlet UILabel *rankLoc;

@end
