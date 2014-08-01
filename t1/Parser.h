//
//  Parser.h
//  t1
//
//  Created by immago on 01.08.14.
//  Copyright (c) 2014 immago. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NewsParserDelegate<NSObject>
@optional
- (void)parseEndWithDictonary:(NSMutableDictionary *)dict;
@end

@interface Parser : NSObject <NSXMLParserDelegate>
{
    NSMutableData *rssData;
    NSMutableArray *news;
    NSString *currentElement;
    NSMutableString *currentTitle;
    NSMutableString *pubDate;
    NSMutableString *about;
    NSMutableString *pict;

    NSMutableDictionary *wordCountDict;
}

@property (nonatomic, assign)id <NewsParserDelegate> delegate;


-(NSMutableDictionary*) parseUrl:(NSString*)rssUrl;

@end
