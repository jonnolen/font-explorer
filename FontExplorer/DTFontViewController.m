//
//  DTFontViewController.m
//  FontExplorer
//
//  Created by Jonathan Nolen on 1/24/13.
//  Copyright (c) 2013 Developertown. All rights reserved.
//

#import "DTFontViewController.h"

@interface DTFontViewController ()

@property (nonatomic, strong) NSArray *fonts;

@end

@implementation DTFontViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(NSArray *)fonts{
    if (!_fonts){
        _fonts = [[UIFont fontNamesForFamilyName:self.fontFamily] sortedArrayUsingComparator:^(NSString *font1, NSString *font2){return [font1 compare:font2];}];
    }
    return _fonts;
}

-(void)setFontFamily:(NSString *)fontFamily{
    _fontFamily = fontFamily;
    self.fonts = nil;
    [self.tableView reloadData];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.fonts.count;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return self.fontFamily;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"font.cell"];
    
    cell.textLabel.text = self.fonts[indexPath.row];
    cell.textLabel.font = [UIFont fontWithName:self.fonts[indexPath.row] size:[UIFont labelFontSize]];

    return cell;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
