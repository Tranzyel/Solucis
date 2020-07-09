//
//  DeliveryInfoPickUpTableViewCell.h
//  Solucis
//
//  Created by Lam Si Mon on 16-04-27.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DeliveryInfoPickUpDelegate;

@interface DeliveryInfoPickUpTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *radioButton;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (nonatomic, assign) id <DeliveryInfoPickUpDelegate> delegate;
- (IBAction)radioButtonDidTouchUp:(id)sender;

@end

@protocol DeliveryInfoPickUpDelegate <NSObject>

- (void)deliveryInfoPickUpRadioButtonDidTouchUp:(DeliveryInfoPickUpTableViewCell *)sender;

@end