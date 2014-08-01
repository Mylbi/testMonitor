//
//  ViewController.h
//  t1
//
//  Created by Денис Раскин on 28.06.14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <NSXMLParserDelegate, UITableViewDataSource, UITableViewDelegate>
{
    NSMutableData *rssData;
    NSMutableArray *news;
    NSString *currentElement;
    NSMutableString *currentTitle;
    NSMutableString *pubDate;
    NSMutableString *about;
    NSMutableString *pict;
    UIImageView *imm;
    NSString *corrURl;
    NSArray *array4news;
    
    NSMutableDictionary *wordCountDict;
}

@property (nonatomic, retain) NSMutableData *rssData;
@property (nonatomic, retain) NSMutableArray *news;
@property (nonatomic, retain) NSMutableString *currentTitle;
@property (nonatomic, retain) NSString *currentElement;
@property (nonatomic, retain) NSMutableString *pubDate;
@property (nonatomic, retain) UIViewController *detailViewController;
@property (nonatomic, retain) NSMutableString *about;
@property (nonatomic, retain) NSMutableString *pict;
@property (nonatomic, retain) UIImageView *imm;
@property (nonatomic, retain) NSString *corrURl;


@property (nonatomic, retain) IBOutlet UITableView *mainTableView;

@end
