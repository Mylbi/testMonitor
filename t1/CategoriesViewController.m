//
//  CategoriesViewController.m
//  t1
//
//  Created by immago on 01.08.14.
//  Copyright (c) 2014 immago. All rights reserved.
//

#import "CategoriesViewController.h"
#import "NewsInfoViewController.h"

@interface CategoriesViewController ()

@end

@implementation CategoriesViewController


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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{

    if ([[segue identifier] isEqualToString:@"All"])
    {
        NewsInfoViewController *vc = [segue destinationViewController];
        [vc setUrl:@"http://news.yandex.ru/world.rss"];
    }else if ([[segue identifier] isEqualToString:@"Politic"])
    {
        NewsInfoViewController *vc = [segue destinationViewController];
        [vc setUrl:@"http://news.yandex.ru/politics.rss"];
    }else if ([[segue identifier] isEqualToString:@"Social"])
    {
        NewsInfoViewController *vc = [segue destinationViewController];
        [vc setUrl:@"http://news.yandex.ru/society.rss"];
    }else if ([[segue identifier] isEqualToString:@"Business"])
    {
        NewsInfoViewController *vc = [segue destinationViewController];
        [vc setUrl:@"http://news.yandex.ru/business.rss"];
    }else if ([[segue identifier] isEqualToString:@"Incident"])
    {
        NewsInfoViewController *vc = [segue destinationViewController];
        [vc setUrl:@"http://news.yandex.ru/incident.rss"];
    }
}

@end
