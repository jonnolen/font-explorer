//
//  DTFontFamilyControllerViewController.m
//  FontExplorer
//
//  Created by Jonathan Nolen on 1/24/13.
//  Copyright (c) 2013 Developertown. All rights reserved.
//

#import "DTFontFamilyControllerViewController.h"
#import "DTFontViewController.h"

@interface DTFontFamilyControllerViewController ()
@property (nonatomic, strong) NSArray *fontFamilies;
@property (nonatomic, strong) NSMutableDictionary *fontsByFamily;
@end

@implementation DTFontFamilyControllerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

-(NSArray *)fontFamilies{
    if (!_fontFamilies){
        _fontFamilies = [[UIFont familyNames] sortedArrayUsingComparator:^(NSString *fam1, NSString *fam2){
            return [fam1 compare:fam2];
        }];
    }
    return _fontFamilies;
}
-(NSMutableDictionary *)fontsByFamily{
    if (!_fontsByFamily){
        _fontsByFamily = [NSMutableDictionary dictionaryWithCapacity:self.fontFamilies.count];
    }
    return _fontsByFamily;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

    self.fontsByFamily = nil;
    self.fontFamilies = nil;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.fontFamilies.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"Get SOME >>>");
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"family.cell"];
    
    NSString *currentFamily = self.fontFamilies[indexPath.row];
    cell.textLabel.text = currentFamily;
    
    NSArray *fonts = [self fontNamesForFamilyName:currentFamily];
    if (fonts.count > 1){
        cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    }
    else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    cell.textLabel.font = [UIFont fontWithName:fonts[0] size:[UIFont labelFontSize]];
    return cell;
}

-(NSArray *)fontNamesForFamilyName:(NSString *)familyName{
    if (!self.fontsByFamily[familyName]){
        self.fontsByFamily[familyName] = [[UIFont fontNamesForFamilyName:familyName] sortedArrayUsingComparator:^(NSString *font1, NSString *font2){return [font1 compare:font2];}];
    }
    
    return self.fontsByFamily[familyName];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"show.fontfamily"]){
        DTFontViewController *fontController = (DTFontViewController *)segue.destinationViewController;
        fontController.fontFamily = self.fontFamilies[[self.tableView indexPathForCell:sender].row];
        
    }
}
@end
