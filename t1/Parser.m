//
//  Parser.m
//  t1
//
//  Created by immago on 01.08.14.
//  Copyright (c) 2014 immago. All rights reserved.
//

#import "Parser.h"

@implementation Parser
@synthesize delegate;


-(NSMutableDictionary*) parseUrl:(NSString*)rssUrl
{
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    NSURL *url=[NSURL URLWithString:rssUrl];
    NSURLRequest *theRequest=[NSURLRequest requestWithURL:url
                                              cachePolicy:NSURLRequestUseProtocolCachePolicy
                                          timeoutInterval:60.0];
    NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    if (theConnection)
    {
        rssData=[NSMutableData data];
    } else
    {
        NSLog(@"fail");
    }

    
    return Nil;
}


-(void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [rssData appendData:data ];
}


-(void) connectionDidFinishLoading:(NSURLConnection *)connection {
    
    news=[NSMutableArray array];
    NSXMLParser *rssParser=[[NSXMLParser alloc] initWithData:rssData];
    rssParser.delegate=self;
    [rssParser parse];
}


-(void) parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    currentElement=elementName;
    if ([elementName isEqualToString:@"item"]) {
        currentTitle=[NSMutableString string];
        pubDate =[NSMutableString string];
        about =[NSMutableString string];
        pict = [NSMutableString string];
        
    }
}


-(void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    if ([currentElement isEqualToString:@"title"])
    {
        [currentTitle appendString:string];
    } else if ([currentElement isEqualToString:@"pubDate"]) {
        [pubDate appendString:string];
    }
    else if ([currentElement isEqualToString:@"description"]) {
        [about appendString:string];
    }
    else if ([currentElement isEqualToString:@"image"]) {
        [pict appendString:string];
        
        
    }
    
}


-(void) parser:(NSXMLParser *)parser
 didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    if ([elementName isEqualToString:@"item"]) {
        NSDictionary *newsItem =[NSDictionary dictionaryWithObjectsAndKeys:
                                 currentTitle, @"title",
                                 pubDate, @"pubDate",
                                 about, @"description",
                                 pict, @"image",nil];
        
        [news addObject:newsItem];
        currentTitle=nil;
        pubDate=nil;
        currentElement =nil;
        about=nil;
        pict=nil;
        
    }
}



-(void)parserDidEndDocument:(NSXMLParser *)parser
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];

    
    /* some useful info
     [NSString stringWithFormat:@"%c", 255]  - non breaking space
     http://www.theasciicode.com.ar/ascii-control-characters/unit-separator-ascii-code-31.html
     */
    
    
    /*** separate ***/
    
    NSMutableArray *wordsArray = [[NSMutableArray alloc]init];
    for (NSDictionary *newsDict in news)
    {
        NSString *descriptionString = [newsDict objectForKey: @"description"];
        
        //separate by space
        NSArray *separatedBySpace = [descriptionString componentsSeparatedByString:@" "];
        
        //separate by dot
        NSMutableArray *separatedByDot = [[NSMutableArray alloc] init];
        for (NSString *word in separatedBySpace)
            [separatedByDot addObjectsFromArray:[word componentsSeparatedByString:@"."]];
        
        //separate by comma
        NSMutableArray *separatedByComma = [[NSMutableArray alloc] init];
        for (NSString *word in separatedByDot)
            [separatedByComma addObjectsFromArray:[word componentsSeparatedByString:@","]];
        
        
        //finally
        [wordsArray addObjectsFromArray:separatedByComma];
    }
    
    /*** format ***/
    
#warning Неопознаный нечитаемый разделитель не удалается; при дебаге отображается как @""
    //clean empty strings
    for (int i=0; i < [wordsArray count]; i++)
        if ( ([[wordsArray objectAtIndex:i] isEqualToString:@""]) ||
            ([[wordsArray objectAtIndex:i] length] < 1) ||
            ([[wordsArray objectAtIndex:i] isEqualToString:[NSString stringWithFormat:@"%c", 255]]) )
            
            [wordsArray removeObjectAtIndex:i];
    
    // lower case
    NSMutableArray *tmpArray = [[NSMutableArray alloc] initWithArray:wordsArray];
    [wordsArray removeAllObjects];
    for (NSString *word in tmpArray)
        [wordsArray addObject:[word lowercaseString]];
    
    
    
    /*** count ***/
    
    wordCountDict =  [[NSMutableDictionary alloc]init];
    for (NSString *word in wordsArray)//fArr)
    {
        if ([wordCountDict objectForKey:word] == nil)
        {
            [wordCountDict setObject:[NSNumber numberWithInt:1] forKey:word];
        }else
        {
            int counter = [[wordCountDict objectForKey:word] integerValue]+1;
            [wordCountDict setObject:[NSNumber numberWithInt:counter] forKey:word];
        }
        
    }

    
    SEL selector = @selector(parseEndWithDictonary:);
	if (delegate && [delegate respondsToSelector:selector]) {
		[delegate performSelector:selector withObject:wordCountDict];
	}
    
}



-(void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{NSLog (@"%@", parseError);
}



@end