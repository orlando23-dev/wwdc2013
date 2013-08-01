//
//  WeiboStatusViewController.h
//  MultiTaskforSina
//
//  Created by ding orlando on 7/12/13.
//  Copyright (c) 2013 ding orlando. All rights reserved.
//

//#define ENABLE_TRACE

#import "SinaWeibo.h"
#import "SinaWeibo+StatusExtension.h"
#import "AppDelegate.h"
#import "WeiboStatusViewController.h"
#import "SettingViewController.h"
#import "FlippingNavigationController.h"
#import "WeiboItem.h"
#import "WeiboItemCell.h"

static float sfTextWidth = 266.f;

@interface WeiboStatusViewController () {
    NSMutableArray *_objects;
    NSMutableDictionary *_idPreExists;
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
    // desc - register table cell calss
//    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    
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

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _objects.count;
}

// desc - http://blog.sina.com.cn/s/blog_6123f9650100kmse.html
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WeiboItemCell *cell = (WeiboItemCell*)[tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    WeiboItem* object = _objects[indexPath.row];
    
    // desc - userId
    [cell.userId setText:object.userId];
    
    // desc - content with flexiable text
    NSMutableParagraphStyle *style = [[NSParagraphStyle
                                       defaultParagraphStyle] mutableCopy];
    [style setLineBreakMode:NSLineBreakByWordWrapping];
    [style setAlignment:NSTextAlignmentLeft];
    
    NSMutableAttributedString *attributedContent =
    [[NSMutableAttributedString alloc] initWithString: object.content
                                           attributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       style,NSParagraphStyleAttributeName,nil]];
    [cell.content setAttributedText:attributedContent];
    
    // desc - user Icon
    NSURL *url = [NSURL URLWithString:object.imageURL];
    NSData *data = [NSData dataWithContentsOfURL:url];
    cell.userIcon.image = [[UIImage alloc] initWithData:data];
    
    // desc - creation time
    [cell.createAt setText:object.createAt];
    
    NSNumber* _isExist = self->_idPreExists[object.contentId];
    if(0 == [_isExist intValue]){
        cell.alpha = 0.55f;
        cell.backgroundColor = [UIColor greenColor];
        self->_idPreExists[object.contentId] = @YES;
    }
    else{
        cell.alpha = 1.0f;
        cell.backgroundColor = [self.tableView backgroundColor];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    WeiboItem* object = _objects[indexPath.row];
    // desc - see http://stackoverflow.com/questions/12084760/nsstring-boundingrectwithsize-slightly-underestimating-the-correct-height-why
    CGRect _rContent = [object.content boundingRectWithSize:CGSizeMake(sfTextWidth, MAXFLOAT)
                                                    options:NSStringDrawingUsesLineFragmentOrigin
                                                 attributes:[NSDictionary dictionaryWithObjectsAndKeys: [UIFont systemFontOfSize:12], NSFontAttributeName, [NSParagraphStyle defaultParagraphStyle], NSParagraphStyleAttributeName, nil]
                                                    context:nil];
    CGRect _rUserId = [object.userId boundingRectWithSize:CGSizeMake(sfTextWidth, MAXFLOAT)
                                                  options:NSStringDrawingUsesLineFragmentOrigin
                                               attributes:nil
                                                  context:nil];
    CGRect _rCreateAt = [object.createAt boundingRectWithSize:CGSizeMake(sfTextWidth, MAXFLOAT)
                                                      options:NSStringDrawingUsesLineFragmentOrigin
                                                   attributes:nil
                                                      context:nil];
    
    float _rightSize = _rContent.size.height +  _rUserId.size.height + _rCreateAt.size.height + 4.f;
    
#ifdef ENABLE_TRACE
    NSLog(@"%f", _rightSize);
#endif
    
    return _rightSize > 50.f ? _rightSize : 50.f;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
//    if ([[segue identifier] isEqualToString:@"showDetail"]) {
//        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
//        NSDate *object = _objects[indexPath.row];
//        [[segue destinationViewController] setDetailItem:object];
//    }
}

#pragma mark - SinaWeiboRequestDelegate <NSObject>

//- (void)request:(SinaWeiboRequest *)request didReceiveResponse:(NSURLResponse *)response{
//    
//}
//
//- (void)request:(SinaWeiboRequest *)request didReceiveRawData:(NSData *)data{
//    
//}

/**
 * if refreshment failed, have to reset content, so cache should be managed
 **/
- (void)request:(SinaWeiboRequest *)request didFailWithError:(NSError *)error{
    if ([request.url hasSuffix:@"statuses/friends_timeline.json"])
    {
        [self.refreshControl endRefreshing];
    }
}

/**
 * finish loading friends - will change into
 **/
- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result{
    if ([request.url hasSuffix:@"statuses/friends_timeline.json"]){
        NSArray *statuses = [result objectForKey:@"statuses"];
        
#ifdef ENABLE_TRACE
        NSLog(@"%@", statuses);
#endif
        
        if (!self->_objects) {
            self->_objects = [[NSMutableArray alloc] init];
        }
        
        if (!self->_idPreExists) {
            self->_idPreExists = [[NSMutableDictionary alloc] init];
        }
        
        int _iSizeOfIdWeiboContent = [self->_objects count];
        
        for (id item in statuses) {
#ifdef ENABLE_TRACE
            NSLog(@"%@", item);
#endif
            
            NSString* contentId = [item valueForKey:@"idstr"];
            NSString* content = [item valueForKey:@"text"];
            NSString* create_at = [item valueForKey:@"created_at"];
            NSString* userName = [item valueForKeyPath:@"user.name"];
            NSString* profile_image_url = [item valueForKeyPath:@"user.profile_image_url"];
            
#ifdef ENABLE_TRACE
            NSLog(@"%@, %@, %@, %@", content, create_at, userName, profile_image_url);
#endif
            
            WeiboItem* weiboItem = [WeiboItem new];
            weiboItem.contentId = contentId;
            weiboItem.content = content;
            weiboItem.userId = userName;
            weiboItem.createAt = create_at;
            weiboItem.imageURL = profile_image_url;
            
            // desc - see literal of objective-c http://clang.llvm.org/docs/ObjectiveCLiterals.html
            if (nil == [self->_idPreExists valueForKey:contentId]) {
                self->_idPreExists[contentId] = @NO;
                [self->_objects insertObject:weiboItem atIndex:0];
            }
            
        }
        
        if (_iSizeOfIdWeiboContent < [self->_objects count]) {
            NSLog(@"already with new content updated");
        }
        
        //desc - update UI status
        [self.refreshControl endRefreshing];
        [self.tableView reloadData];
    }
}


@end
