//
//  ViewController.m
//  t1
//
//  Created by Денис Раскин on 28.06.14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize rssData;
@synthesize news;
@synthesize currentTitle;
@synthesize currentElement;
@synthesize pubDate;
@synthesize detailViewController;
@synthesize about;
@synthesize pict;
@synthesize imm;
@synthesize corrURl;
@synthesize array4news;

@synthesize fArr;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title=@"News";
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    NSURL *url=[NSURL URLWithString:@"http://news.yandex.ru/world.rss"];
    NSURLRequest *theRequest=[NSURLRequest requestWithURL:url
                                              cachePolicy:NSURLRequestUseProtocolCachePolicy
                                          timeoutInterval:60.0];
    NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    if (theConnection)
    {
        self.rssData=[NSMutableData data];
    } else
    {
        NSLog(@"fail :(");
    }
    //[theConnection release];
    
    
    
    
    
}


-(void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [rssData appendData:data ];
}


-(void) connectionDidFinishLoading:(NSURLConnection *)connection {
    //NSString *result = [[NSString alloc] initWithData:rssData encoding:NSUTF8StringEncoding];
    //NSLog(@"%@", result);
    //   [result release];
    
    self.news=[NSMutableArray array];
    NSXMLParser *rssParser=[[NSXMLParser alloc] initWithData:rssData];
    rssParser.delegate=self;
    [rssParser parse];
    //  [rssParser release];
}

-(void) parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    self.currentElement=elementName;
    if ([elementName isEqualToString:@"item"]) {
        self.currentTitle=[NSMutableString string];
        self.pubDate =[NSMutableString string];
        self.about =[NSMutableString string];
        self.pict = [NSMutableString string];
        
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
        self.array4news = [NSMutableArray array];
        
        //      NSString *secondString  = [[NSString alloc] initWithData:[newsItem objectForKey:@"description"] encoding:NSUTF8StringEncoding];
        //  NSData *d = [[NSData alloc] initWithData:[newsItem objectForKey:@"description" ]];
        /*        fArr = [[NSMutableArray alloc] init];
         
         NSString *sStr = [[NSString alloc] initWithString:about] ;
         // NSLog(@"%@", sStr);
         array4news = [sStr componentsSeparatedByString:@" "];
         // NSLog(@"%@",[ array4news objectAtIndex:3]);
         for (int i=0; i<[array4news count]; i++) {
         [fArr addObject:[array4news objectAtIndex:i]];// I вариант
         }
         NSLog(@"%@", [fArr objectAtIndex:3]);*/
        [news addObject:newsItem];
        self.currentTitle=nil;
        self.pubDate=nil;
        self.currentElement =nil;
        self.about=nil;
        self.pict=nil;
        
    }
    // NSLog(@"%@", [fArr objectAtIndex:3]);
    // NSLog(@"==%@", [[news objectAtIndex:3]objectForKey:@"description"]);// II вариант
    
}


/*-(void) gettingFinalArray: (NSDictionary *)dictionary {
 array4news = [[NSArray alloc] init];
 int j=0;
 for (int i = 0; i<[news count]; i++) {
 NSString *sStr = [[NSString alloc] initWithString:about] ;
 array4news = [sStr componentsSeparatedByString:@" "];
 
 for (j=j; j<j+[array4news count]; j++) {
 [fArr addObject:[array4news objectAtIndex:j]];
 }
 
 j=j+[array4news count];
 }
 NSLog(@"%@", fArr);
 }
 
 */


-(void)parserDidEndDocument:(NSXMLParser *)parser {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    //  NSLog(@"==%@", [[news objectAtIndex:3]objectForKey:@"description"]);// II вариант
    

    /* ftw
     NSMutableArray *countingArray = [[NSMutableArray alloc] init];
     int c=0;
     for (int k=0; k<[fArr count]; k++) {
     NSString *str1 = [[NSString alloc] init];
     str1 = [fArr objectAtIndex:k];
     // str1=@"в";
     
     
     for ( int l=1; l<[fArr count]-1; l++) {
     
     if ([fArr objectAtIndex:l]==str1) {
     c=c+1;
     // NSLog(@"%d", c);
     // NSLog(@"%d", l);
     }
     NSNumber *anumber = [NSNumber numberWithInteger:c];
     [countingArray addObject:anumber];
     NSLog(@"%@", countingArray);
     }
     
     }
     
     */
    
 
    
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
    
    NSMutableDictionary *wordCountDict =  [[NSMutableDictionary alloc]init];
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
    
    //NSLog(@"%@", wordCountDict);
    
              /********************
             исправить подсчет с
             посмотреть как должно изменяться l относительно k и что вообще за хрень
             кодировка (лайфхак: NSLog(@"%@", [array4words objectAtIndex:l]); )
             ********************/
    
}



-(void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{NSLog (@"%@", parseError);
}


-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [news count];
    
}



-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

/*
 -(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
 {
 static NSString *CellIdentifier = @"Cell";
 
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
 if (cell == nil) {
 cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
 reuseIdentifier:CellIdentifier] ; //]autorelease];
 //   ImagesForTables *immag1=[[[ImagesForTables alloc]init] autorelease];
 //   LabelsForTables *lab1=[[[LabelsForTables alloc] initWithFrame:CGRectMake(60, 2, 350, 15)] autorelease];
 //   LabelsForTables *lab2=[[[LabelsForTables alloc] initWithFrame:CGRectMake(60, 20 , 350, 15)] autorelease];
 
 //   lab1.tag=12;
 //  lab2.tag=13;
 
 // [immag loadImageFromURL];
 
 //immag.imageView=imm;
 
 // immag1.tag=10;
 
 //NSData *dat=[NSData dataWithContentsOfURL:url];
 //imm=[UIImage imageWithData:dat];
 //cell.imageView.image=imm;
 
 //  [cell.contentView addSubview:immag1];
 //  [cell.contentView addSubview:lab1];
 //  [cell.contentView addSubview:lab2];
 }
 
 NSDictionary *newsItem = [news objectAtIndex:indexPath.row];
 
 // cell.textLabel.text = [newsItem objectForKey:@"title"];
 
 // cell.detailTextLabel.text = [newsItem objectForKey:@"pubDate"];
 
 //  LabelsForTables *lab=(LabelsForTables *)[cell.contentView viewWithTag:12];
 //  lab.text=[newsItem objectForKey:@"title"];
 
 //  [cell.contentView bringSubviewToFront:lab];
 
 
 //  LabelsForTables *labe=(LabelsForTables *)[cell.contentView viewWithTag:13];
 //  labe.text=[newsItem objectForKey:@"pubDate"];
 
 
 //  [cell.contentView bringSubviewToFront:labe];
 
 //NSLog(@"%@", lab.text);
 
 
 NSString *str=[[news objectAtIndex:indexPath.row ] objectForKey:@"image"];//NSLog(@"%@", str);
 
 
 NSString *imagelink=[NSString stringWithFormat:@"%@%@",@"http://www.imaladec.net", str];
 
 NSString *corrURl1 = [imagelink stringByReplacingOccurrencesOfString:@"\n\t\t    " withString:@""];
 
 
 
 NSURL *url=[NSURL URLWithString:corrURl1];
 //  ImagesForTables *immag= (ImagesForTables *)[cell.contentView viewWithTag:10];
 //  if (immag.imageView && immag.imageView.image) immag.imageView.image=nil;
 
 
 //  [immag loadImageFromURL:url];
 //  [cell.contentView bringSubviewToFront:immag];
 
 return cell;
 
 }
 
 - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
 {
 
 //  NewsViewController *detailViewController1 = [[NewsViewController alloc]
 //                                              initWithNibName:@"NewsViewController" bundle:nil];
 //  detailViewController1.selectedNews = [news objectAtIndex:indexPath.row];
 //   [self.navigationController pushViewController:detailViewController1 animated:YES];
 //  [detailViewController1 release];
 
 }
 
 */

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"%@", error);
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc
{
    //[super dealloc];
}


@end

