//
//  PlaceOrderCell.m
//  Solucis
//
//  Created by Lam Si Mon on 16-04-04.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import "PlaceOrderCell.h"

@interface PlaceOrderCell ()
@property (weak, nonatomic) IBOutlet UILabel *gstLoc;
@end

@implementation PlaceOrderCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    
    self.gstLoc.text = NSLocalizedString(@"rep_gst", "");
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)addButtonDidTouchUp:(id)sender {
}

- (IBAction)minusButtonDidTouchUp:(id)sender {
}
@end
