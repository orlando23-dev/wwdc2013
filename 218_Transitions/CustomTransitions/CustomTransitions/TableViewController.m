//
//  ViewController.m
//  CustomTransitions
//
//  Created by ding orlando on 6/28/13.
//  Copyright (c) 2013 ding orlando. All rights reserved.
//
//  see https://devforums.apple.com/thread/190664?tstart=100
//  see https://devforums.apple.com/message/834386
//  see https://devforums.apple.com/message/828441
//  core reference, see https://devforums.apple.com/message/829685
//  see https://devforums.apple.com/message/831522#831522
//

#import "TableViewController.h"
#import "NavigatedViewController.h"
#import "NavigatedTransitionController.h"
#import "NavigateUIVControllerAnimatedTransitioning.h"
#import "ResourceUtil.h"

static float iHeightOfHeader = 18.0f;

@interface TableViewController ()

@property (nonatomic) NavigatedTransitionController *transitionController;

@end

@implementation TableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    // see https://devforums.apple.com/message/838984#838984 for hidden status bar
//    self->_sections = @[@"Basic", @"Spring",@"Keyframe",@"CollectionView",@"Dynamics"];

#ifdef TRACEUISIZE
    NSLog(@"[ApplicationFrame] x - %f, y - %f, width - %f, height - %f", [UIScreen mainScreen].applicationFrame.origin.x, [UIScreen mainScreen].applicationFrame.origin.y, [UIScreen mainScreen].applicationFrame.size.width, [UIScreen mainScreen].applicationFrame.size.height);
    NSLog(@"[UIScreen] width - %f, height - %f", [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    NSLog(@"[TableView] x - %f, y - %f, width - %f, height - %f", self.tableView.bounds.origin.x, self.tableView.bounds.origin.y, self.tableView.bounds.size.width, self.tableView.bounds.size.height);
    NSLog(@"%@", self.tableView.tableHeaderView);
    NSLog(@"%@", self.tableView.tableFooterView);
    NSLog(@"scale - %f", [[UIScreen mainScreen] scale]);
#endif
    
    self.tableView.backgroundColor = [ResourceUtil tableBackgroundImage];
    
#ifdef TRACEUISIZE
    NSLog(@"[BackgroundView] x - %f, y - %f, width - %f, height - %f", self.tableView.bounds.origin.x, self.tableView.bounds.origin.y, self.tableView.bounds.size.width, self.tableView.bounds.size.height);
#endif
    
    // desc - navigation controller embedded - disable navigation delegate via default transition
    [self navigationController].delegate = self;
    self.transitionController = [NavigatedTransitionController new];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - table presetation

//- (NSString *)      tableView:(UITableView *)tableView
//      titleForHeaderInSection:(NSInteger)section{
//    return NSLocalizedString(self->_sections[section], self->_sections[section]);
//}

- (CGFloat)     tableView:(UITableView *)tableView
 heightForHeaderInSection:(NSInteger)section {
    return iHeightOfHeader;
}

/**
 * just show 0.0f at the bottom, 0.0f will show the default size, so workaround here.
 **/
- (CGFloat)     tableView:(UITableView *)tableView
 heightForFooterInSection:(NSInteger)section {
    return 0.001f;
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
    
    float _fLabelSize = 12.0f;
    // Create label with section title
    UILabel *label=[[UILabel alloc] init];
    label.frame=CGRectMake(_fLabelSize, 0, 300, iHeightOfHeader);
//    label.backgroundColor=[UIColor grayColor];
    label.textColor=[UIColor blackColor];
    label.font=[UIFont fontWithName:@"Helvetica-Bold" size:_fLabelSize];
    label.text=sectionTitle;
    
    // Create header view and add label as a subview
    UIView *sectionView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, iHeightOfHeader)];
    [sectionView setBackgroundColor:[UIColor lightTextColor]];
    [sectionView addSubview:label];
    return sectionView;
}

- (void)        tableView:(UITableView *)tableView
  didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    [self presentNavigation:indexPath];
}

// see navigation via Segue delegate
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    if ([[segue identifier] isEqualToString:@"ShowDetails"]) {
//        NavigatedViewController *detailViewController = [segue destinationViewController];
//        detailViewController.modalPresentationStyle = UIModalPresentationCustom;
//        [detailViewController setTransitioningDelegate:self];
//        [self presentViewController:detailViewController animated:YES completion:nil];
//    }
//}

#pragma mark - UINavigationControllerDelegate

- (void)presentNavigation:(NSIndexPath *)indexPath{
    if (0 == [indexPath section]) {
        UIViewController *vc = [[self storyboard] instantiateViewControllerWithIdentifier:@"NavigatedVC"];
        [self setTransitioningDelegate:self];
        [[self navigationController] pushViewController:vc
                                               animated:YES];
    }
}

/**
 * enable navigation delegate see line 36
 **/
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC {
    // desc - where to enable transiation
    if (!navigationController) {
        return  nil;
    }
    
    return self.transitionController;
}

#pragma mark - customized preseted viewcontroller

- (void)presentNavigationVCBySelfCode:(NSIndexPath *)indexPath{
    if(0 == [indexPath section]){
        NavigatedViewController *controller  = [[self storyboard] instantiateViewControllerWithIdentifier:@"NavigatedVC"];
        controller.modalPresentationStyle = UIModalPresentationCustom;
        [controller setTransitioningDelegate:self];
//        controller.delegate = self;
        [self presentViewController:controller animated:YES completion:nil];
    }
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source{
    if (!presented) {
        return  nil;
    }
    
    return self.transitionController;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    if (!self.transitionController) {
        return  nil;
    }
    
    return self.transitionController;
}

@end
