//
//  ViewController.m
//  TestApp
//
//  Created by Anand on 10/15/15.
//  Copyright (c) 2015 Anand. All rights reserved.
//

#import "ViewController.h"
#import "UIView+AutolayoutHelper.h"


@interface ViewController ()

@end

@implementation ViewController

@synthesize feedsTableView;
@synthesize feedsArray;

ContentsTableViewCell *cell;
static NSString *CellIdentifier = @"ContentsTableViewCell";
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.title=@"Telstra";
    
    feedsArray=[[NSMutableArray alloc]init];
    
    self.feedsTableView = [UITableView new];
    self.feedsTableView.delegate=self;
    self.feedsTableView.dataSource=self;
    self.feedsTableView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.feedsTableView];
    [self.view fitView:self.feedsTableView];
    
    activityIndicator=[[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(self.view.center.x-25, self.view.center.y-25, 50, 50)];
    activityIndicator.color=[UIColor blackColor];
    [self.view addSubview:activityIndicator];
    activityIndicator.hidden=YES;
    
    UIBarButtonItem *flipButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Refresh"
                                   style:UIBarButtonItemStylePlain
                                   target:self
                                   action:@selector(loadData)];
    self.navigationItem.rightBarButtonItem = flipButton;
    
    self.feedsTableView.estimatedRowHeight = 110.0;
    self.feedsTableView.rowHeight = UITableViewAutomaticDimension;
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    
    self.feedsTableView.rowHeight = UITableViewAutomaticDimension;
    
    [self loadData];

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.feedsTableView reloadData];
}

/*
 @method        loadData
 @abstract      gets the data from server and load in to UITableview
 @param         nil
 @return        void
 */

-(void)loadData
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible=YES;
    BOOL isConnectedToInternet = [[Reachability reachabilityForInternetConnection] currentReachabilityStatus] != NotReachable;
    activityIndicator.hidden = NO;
    [activityIndicator startAnimating];
    self.view.userInteractionEnabled=NO;
    if (isConnectedToInternet) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),  ^{
            feedsArray=[HelperClass feedsList];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
                [activityIndicator stopAnimating];
                activityIndicator.hidden = YES;
                self.view.userInteractionEnabled=YES;
                [self.feedsTableView reloadData];
            });
        });
    }else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"Please check your network connection." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // The number of sections is based on the number of items in the data property list.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return feedsArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 110;
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ContentsTableViewCell";
    
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[ContentsTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    if (indexPath.row<[self.feedsArray count]) {
        FeedsData *feedsDetail=[feedsArray objectAtIndex:indexPath.row];
        
        // set default user image while image is being downloaded
        [cell.itemImage setImage:[UIImage imageNamed:@"1.png"]];
        
        if (feedsDetail.imageCache) {
            cell.itemImage.image = feedsDetail.imageCache;
        } else {
            // download the image asynchronously
            NSURL *imageURL = [NSURL URLWithString:feedsDetail.feedImageUrl];
            [self downloadImageWithURL:imageURL completionBlock:^(BOOL succeeded, UIImage *image) {
                if (succeeded) {
                    // change the image in the cell
                    cell.itemImage.image = image;
                    
                    feedsDetail.imageCache=image;
                }
            }];
        }
        
        [cell.itemTitle setText:feedsDetail.feedTitle];
        [cell.itemDescription setText:feedsDetail.feedDescription];
    }
    
    return cell;
    
}

/*
 @method        downloadImageWIthURL
 @abstract      gets the image from server and load in to UITableview
 @param         ImageUrl
 @return        void
 */

- (void)downloadImageWithURL:(NSURL *)url completionBlock:(void (^)(BOOL succeeded, UIImage *image))completionBlock
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               if ( !error )
                               {
                                   UIImage *image = [[UIImage alloc] initWithData:data];
                                   completionBlock(YES,image);
                               } else{
                                   completionBlock(NO,nil);
                               }
                           }];
}



/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
