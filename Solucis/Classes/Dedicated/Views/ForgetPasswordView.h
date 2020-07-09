//
//  ForgetPasswordView.h
//  Solucis
//
//  Created by Lam Si Mon on 18-10-10.
//  Copyright © 2018 Lam Si Mon. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@protocol ForgetPasswordViewDelegate;

@interface ForgetPasswordView : UIView
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UITextField *memberCodeTF;
@property (weak, nonatomic) IBOutlet UITextField *emailTF;
@property (weak, nonatomic) IBOutlet UILabel *memberCodeLoc;
@property (weak, nonatomic) IBOutlet UILabel *emailCodeLoc;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;

@property (weak, nonatomic) IBOutlet UITapGestureRecognizer *singleTapGesture;
@property (nonatomic, assign) id <ForgetPasswordViewDelegate> delegate;
- (IBAction)singleTapAction:(id)sender;
- (id)initNib;
- (IBAction)submitButton:(id)sender;
- (void)hideView;
@end

@protocol ForgetPasswordViewDelegate <NSObject>
- (void)submitButtonDidTouchUp:(ForgetPasswordView *)view;
@end

NS_ASSUME_NONNULL_END
