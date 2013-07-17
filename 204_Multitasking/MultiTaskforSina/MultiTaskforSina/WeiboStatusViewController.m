//
//  WeiboStatusViewController.h
//  MultiTaskforSina
//
//  Created by ding orlando on 7/12/13.
//  Copyright (c) 2013 ding orlando. All rights reserved.
//

#import "SinaWeibo.h"
#import "SinaWeibo+StatusExtension.h"
#import "AppDelegate.h"
#import "WeiboStatusViewController.h"
#import "SettingViewController.h"
#import "FlippingNavigationController.h"
#import "WeiboItem.h"

@interface WeiboStatusViewController () {
    NSMutableArray *_objects;
}

//desc - transition controller
@property (nonatomic) FlippingNavigationController *transitionController;

@end

@implementation WeiboStatusViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self setTransitionController:[FlippingNavigationController new]];
    [self.navigationController setDelegate:self];
    
    // desc - refershing control in table
    self.refreshControl = [[UIRefreshControl alloc]init];
    [self.refreshControl addTarget:self
                            action:@selector(refreshedByPullingTable:)
                  forControlEvents:UIControlEventValueChanged];
    
    SinaWeibo *sinaWeioHelper = [SettingViewController sinaweibo];
    if (!sinaWeioHelper) {
        [self navigateToSetting];
    }
}

// desc - refreshed by pulling table
- (void)refreshedByPullingTable: (id)sender{
    [self.refreshControl beginRefreshing];
    // desc - do default refresh
    [[SettingViewController sinaweibo] sinaweiboGetLatestStatuses:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)navigateToSetting{
    [[self navigationController] pushViewController:[[self storyboard] instantiateViewControllerWithIdentifier:@"settingView"]
                                           animated:YES];
}

/**
 * fliping transition
 **/
- (IBAction)flipping:(id)sender{
    [self navigateToSetting];
}

#pragma mark - UINavigationControllerDelegate

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC {
    if (!navigationController) {
        return  nil;
    }
    
    return [self transitionController];
}
- (void)insertNewObject:(id)sender
{
    if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }
    [_objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    WeiboItem* object = _objects[indexPath.row];
    cell.textLabel.text = object.userId;
    cell.detailTextLabel.text = object.content;
//    cell.imageView.image = [UIImage imageNamed:]
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
//    if ([[segue identifier] isEqualToString:@"showDetail"]) {
//        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
//        NSDate *object = _objects[indexPath.row];
//        [[segue destinationViewController] setDetailItem:object];
//    }
}

#pragma mark - SinaWeiboRequestDelegate <NSObject>

- (void)request:(SinaWeiboRequest *)request didReceiveResponse:(NSURLResponse *)response{
    
}

- (void)request:(SinaWeiboRequest *)request didReceiveRawData:(NSData *)data{
    
}

- (void)request:(SinaWeiboRequest *)request didFailWithError:(NSError *)error{
    
}

- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result{
    if ([request.url hasSuffix:@"statuses/friends_timeline.json"]){
        NSArray *statuses = [result objectForKey:@"statuses"];
//        NSLog(@"%@", statuses);
        WeiboItem* weiboItem = [WeiboItem new];
        for (id item in statuses) {
            NSString* content = [item valueForKey:@"text"];
            NSString* create_at = [item valueForKey:@"created_at"];
            NSString* userName = [item valueForKeyPath:@"user.name"];
            NSString* profile_image_url = [item valueForKeyPath:@"user.profile_image_url"];
            NSLog(@"%@, %@, %@, %@", content, create_at, userName, profile_image_url);
            weiboItem.content = content;
            weiboItem.userId = userName;
            weiboItem.createAt = create_at;
            weiboItem.imageURL = profile_image_url;
            if (!_objects) {
                _objects = [[NSMutableArray alloc] init];
            }
            [self->_objects addObject:item];
        }
        //desc - update UI status
        [self.refreshControl endRefreshing];
//        [self.tableView reloadData];
        if (!_objects) {
            _objects = [[NSMutableArray alloc] init];
        }
        [_objects insertObject:weiboItem atIndex:0];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}


@end
