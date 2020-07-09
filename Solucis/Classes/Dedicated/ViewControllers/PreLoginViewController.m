//
//  PreLoginViewController.m
//  Solucis
//
//  Created by Lam Si Mon on 16-08-16.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import "PreLoginViewController.h"
#import "PreLoginCollectionViewCell.h"
#import "AboutUsViewController.h"
#import "LoginViewController.h"
#import "PreProductTableViewController.h"
#import "NewMemberSignUpViewController.h"

static NSString *const PreLoginCollectionViewIdentifier = @"PreLoginTableViewCellIdentifier";

@interface PreLoginViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic , strong) NSArray *items;
@property (nonatomic, strong) NSArray *availableLocalizations;
@property (weak, nonatomic) IBOutlet UITableView *languageTableView;
@property (strong, nonatomic) IBOutlet UIView *languageView;
@property (weak, nonatomic) IBOutlet UIView *languageBackground;
@property (weak, nonatomic) IBOutlet UIButton *languageButton;
- (IBAction)languageButtonAction:(id)sender;
@end

@implementation PreLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupItems];
    [self fetchLocalizations];
    [self localizedStrings];
    [self setupLanguage];
    [self setupLanguageView];

    
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([PreLoginCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:PreLoginCollectionViewIdentifier];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:LanguageDidChangedNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        [self.collectionView reloadData];
        [self setupItems];
    }];
    
    [self.languageTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"LanguageCell"];
    
    UITapGestureRecognizer *tapBg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(languageBackgroundTouch)];
    tapBg.numberOfTapsRequired = 1;
    [self.languageBackground addGestureRecognizer:tapBg];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.items.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PreLoginCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:PreLoginCollectionViewIdentifier forIndexPath:indexPath];

    NSDictionary *data = self.items[indexPath.row];
    
    cell.icon.image = [UIImage imageNamed:data[@"icon"]];
    cell.title.text = data[@"title"];
    
    return cell;
}


#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row)
    {
        case 0:
        {
            PreProductTableViewController *controller = [[PreProductTableViewController alloc] init];
            controller.title = [NSLocalizedString(@"pre_login_products_title", "") uppercaseString];
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
        case 1:
        {
            AboutUsViewController *controller = [[AboutUsViewController alloc] init];
            controller.title = [NSLocalizedString(@"home_about_us", "") uppercaseString];
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
        case 2:
        {
            LoginViewController *controller = [[LoginViewController alloc] init];
            controller.title = [NSLocalizedString(@"login_title", "") uppercaseString];
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
        case 3:
        {
            NewMemberSignUpViewController *controller = [[NewMemberSignUpViewController alloc] init];
            controller.title = [NSLocalizedString(@"login_title", "") uppercaseString];
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
        default:
            break;
    }
}


#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat propotionalSize = [UIScreen mainScreen].bounds.size.width;
    return CGSizeMake(propotionalSize, 120.0);
}


#pragma mark - Instant Method

- (void)setupItems
{
    self.items = @[@{@"title":[NSLocalizedString(@"pre_login_products_title", "") uppercaseString],@"icon":@"btn-products"},
                   @{@"title":[NSLocalizedString(@"home_about_us", "") uppercaseString],@"icon":@"btn-about-us-large"},
                   @{@"title":[NSLocalizedString(@"login_title", "") uppercaseString],@"icon":@"btn-login"},
                   @{@"title":[NSLocalizedString(@"login_register_new_member", "") uppercaseString],@"icon":@"icon_reg_member.png"}];
    [self.languageButton setTitle:[[LocalStorage shared] selectedLanguageText] forState:UIControlStateNormal];

    self.title = NSLocalizedString(@"home_title", "");
    
}


- (void)setupLanguageView
{
    self.languageView.frame = self.view.frame;
    self.languageView.alpha = 0.0;
    self.languageTableView.layer.cornerRadius = 10.0;
    [self.view addSubview:self.languageView];
    
}

#pragma mark - Languages

- (void)setupLanguage
{
    NSString *language = [[NSLocale preferredLanguages] objectAtIndex:0];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:language];
    NSString *selectedLocale = [[NSUserDefaults standardUserDefaults] objectForKey:@"SelectedLanguageCode"];
    
    if (selectedLocale.length > 0)
    {
        locale = [[NSLocale alloc] initWithLocaleIdentifier:selectedLocale];
        //self.languageLabel.text = [[locale displayNameForKey:NSLocaleIdentifier value:selectedLocale] capitalizedString];
    }
    else
    {
        locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh-Hans"];
        //self.languageLabel.text = [[locale displayNameForKey:NSLocaleIdentifier value:language] capitalizedString];
    }
}

- (void)fetchLocalizations
{
    NSArray *localizations = [[NSBundle mainBundle] localizations];
    __block NSMutableArray *dictionaries = [[NSMutableArray alloc] initWithCapacity:localizations.count];
    
    [localizations enumerateObjectsUsingBlock:^(NSString*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop)
     {
         if (![obj isEqualToString:@"Base"])
         {
             NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:obj];
             NSString *language = [[locale displayNameForKey:NSLocaleIdentifier value:obj] capitalizedString];
             NSLog(@"Obj : %@" , language);
             NSDictionary *dict = @{@"Language" : language , @"LanguageCode" : obj};
             [dictionaries addObject:dict];
         }
     }];
    
    self.availableLocalizations = [NSArray arrayWithArray:dictionaries];
}


- (void)showLanguageList:(BOOL)show
{
    [UIView animateWithDuration:0.3 animations:^{
        self.languageView.alpha = (show) ? 1.0 : 0.0;
    }];
}

- (void)localizedStrings
{
    [self setupItems];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.availableLocalizations.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LanguageCell"];
    
    NSDictionary *dict = [self.availableLocalizations objectAtIndex:indexPath.row];
    NSString *country = [dict objectForKey:@"Language"];
    NSString *languageCode = [dict objectForKey:@"LanguageCode"];
    NSString *selectedCountryCode = [[LocalStorage shared] currentLanguage];
    
    cell.textLabel.text = country;
    cell.detailTextLabel.text = languageCode;
    
    if ([selectedCountryCode length] == 0 || selectedCountryCode == nil)
    {
        if ([cell.textLabel.text isEqualToString:@"English"])
        {
            [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
        }
    }
    else
    {
        if ([languageCode isEqualToString:selectedCountryCode])
        {
            [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
        }
        else
        {
            [cell setAccessoryType:UITableViewCellAccessoryNone];
        }
    }
    
    return cell;
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dict = [self.availableLocalizations objectAtIndex:indexPath.row];
    NSString *languageCode = [dict objectForKey:@"LanguageCode"];
    
    [NSBundle setLanguage:languageCode];
    
    [[NSUserDefaults standardUserDefaults] setObject:languageCode forKey:@"SelectedLanguageCode"];
    [[NSUserDefaults standardUserDefaults] setObject:dict[@"Language"] forKey:@"SelectedLanguageText"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:LanguageDidChangedNotification object:nil];
    [self localizedStrings];
    [self.languageTableView reloadData];
    [self showLanguageList:NO];
}

- (IBAction)languageButtonAction:(id)sender
{
    [self showLanguageList:YES];
}

- (void)languageBackgroundTouch
{
    [self showLanguageList:NO];
}

@end
