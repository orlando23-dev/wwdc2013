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

@interface TableViewController ()

@property (nonatomic) NavigatedTransitionController *transitionController;

@end

@implementation TableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
//    self->_sections = @[@"Basic", @"Spring",@"Keyframe",@"CollectionView",@"Dynamics"];
    self.tableView.opaque = NO;
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"shadow.png"]];
    // desc - navigation controller embedded - disable navigation delegate via default transition
//    [self navigationController].delegate = self;
    self.transitionController = [NavigatedTransitionController new];
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

- (void)        tableView:(UITableView *)tableView
  didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
//    //create that only once
//    NavigatedViewController *controller  = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"NavigatedVC"];
//    controller.modalPresentationStyle = UIModalPresentationCustom;
//    [controller setTransitioningDelegate:self];
////    controller.delegate = self;
//    [self presentViewController:controller animated:YES completion:nil];
    if (0 == [indexPath section]) {
        UIViewController *vc = [[self storyboard] instantiateViewControllerWithIdentifier:@"NavigatedVC"];
        vc.modalPresentationStyle = UIModalPresentationCustom;
//        [vc setTransitioningDelegate: self];
        [self setTransitioningDelegate:self];
        [[self navigationController] pushViewController:vc
                                               animated:YES];
    }
}

#pragma mark - UINavigationControllerDelegate

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

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    if ([[segue identifier] isEqualToString:@"ShowDetails"]) {
//        NavigatedViewController *detailViewController = [segue destinationViewController];
//        detailViewController.modalPresentationStyle = UIModalPresentationCustom;
//        [detailViewController setTransitioningDelegate:self];
////        [self presentViewController:detailViewController animated:YES completion:nil];
//    }
//}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source{
    // desc - where to enable transiation
    if (!presented) {
        return  nil;
    }
    
    return self.transitionController;
}


- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    // desc - where to enable transiation
    if (!self.transitionController) {
        return  nil;
    }
    
    return self.transitionController;
}

//- (CGFloat)     tableView:(UITableView *)tableView
// heightForFooterInSection:(NSInteger)section {
//    return 0;
//}

@end
