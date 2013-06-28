//
//  ViewController.m
//  CustomTransitions
//
//  Created by ding orlando on 6/28/13.
//  Copyright (c) 2013 ding orlando. All rights reserved.
//

#import "TableViewController.h"

@interface TableViewController ()

@end

@implementation TableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self->_sections = @[@"Basic", @"Spring",@"Keyframe",@"CollectionView",@"Dynamics"];
    self.tableView.opaque = NO;
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"shadow.png"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    return NSLocalizedString(self->_sections[section], self->_sections[section]);
//}

- (CGFloat)     tableView:(UITableView *)tableView
 heightForHeaderInSection:(NSInteger)section {
    return 22;
}

//- (void)    tableView:(UITableView*) tableView
//willDisplayHeaderView:(UIView*) view
//           forSection:(NSInteger) section {
//    [[((UITableViewHeaderFooterView*) view) textLabel] setTextColor : [UIColor whiteColor]];
//}

/**
 * see http://blog.sina.com.cn/s/blog_69081e060100w72x.html
 **/
- (UIView *)    tableView:(UITableView *)tableView
   viewForHeaderInSection:(NSInteger)section {
    NSString *sectionTitle=[self tableView:tableView titleForHeaderInSection:section];
    if (sectionTitle==nil) {
        return nil;
    }
    
    // Create label with section title
    UILabel *label=[[UILabel alloc] init];
    label.frame=CGRectMake(12, 0, 300, 22);
//    label.backgroundColor=[UIColor grayColor];
    label.textColor=[UIColor blackColor];
    label.font=[UIFont fontWithName:@"Helvetica-Bold" size:14];
    label.text=sectionTitle;
    
    // Create header view and add label as a subview
    UIView *sectionView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 22)];
    [sectionView setBackgroundColor:[UIColor lightTextColor]];
    [sectionView addSubview:label];
    return sectionView;
}

//- (CGFloat)     tableView:(UITableView *)tableView
// heightForFooterInSection:(NSInteger)section {
//    return 0;
//}

@end
