//
//  NewsInfoViewController.h
//  t1
//
//  Created by immago on 01.08.14.
//  Copyright (c) 2014 immago. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Parser.h"

@interface NewsInfoViewController : UIViewController <NewsParserDelegate, UITableViewDelegate, UITableViewDataSource>
{
    NSMutableDictionary *wordCountDict;
    NSString *urlString;
}

@property (nonatomic, retain) IBOutlet UITableView *tableView;

-(void)setUrl:(NSString*)url;

@end
