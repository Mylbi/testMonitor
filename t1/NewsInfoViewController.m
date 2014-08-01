//
//  NewsInfoViewController.m
//  t1
//
//  Created by immago on 01.08.14.
//  Copyright (c) 2014 immago. All rights reserved.
//

#import "NewsInfoViewController.h"

@interface NewsInfoViewController ()

@end

@implementation NewsInfoViewController


-(void)setUrl:(NSString*)url
{
    urlString = url;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    wordCountDict = [[NSMutableDictionary alloc]init];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    Parser *parser = [[Parser alloc]init];
    parser.delegate = self;
    [parser parseUrl:urlString];
    
}

#pragma mark - Parser Delegate Methods

- (void)parseEndWithDictonary:(NSMutableDictionary *)dict
{
    wordCountDict = dict;
    [self.tableView reloadData];
}

#pragma mark - Tabale view methods

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [wordCountDict count];
    
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    
    
    NSString *key = [[wordCountDict allKeys]objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ :%i",
                           key,
                           [[wordCountDict objectForKey:key] integerValue]];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
