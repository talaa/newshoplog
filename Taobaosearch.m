//
//  Taobaosearch.m
//  ttttt
//
//  Created by Tamer Alaa on 11/18/12.
//  Copyright (c) 2012 Tamer Alaa. All rights reserved.
//

#import "Taobaosearch.h"
#import "Flurry.h"

@implementation Taobaosearch
- (UIImage *)activityImage
{
    return [UIImage imageNamed:@"taobao2.png" ];
}
- (NSString *)activityTitle
{
    return @"Search Taobao";
}
- (NSString *)activityType
{
    return @"com.springmoon.Shoplog.Taobao";
}

-(BOOL)canPerformWithActivityItems:(NSArray *)activityItems
{
    for (int i = 0; i < activityItems.count; i++)
    {
        id item = activityItems[i];
        if ([item class] == [UIImage class] || [item
                                                isKindOfClass:[NSString class]])
        {
        }
        else
        {
            return NO;
        }
    }
    return YES;
}

- (void)prepareWithActivityItems:(NSArray *)activityItems
{
    for (int i = 0; i < activityItems.count; i++)
    {
        id item = activityItems[i];
        if ([item class] == [UIImage class])
        {
            self.authorImage = item;
        }
        else if ([item isKindOfClass:[NSString class]])
        {self.searchstring = item;
        }
    }
}

-(void)performActivity{
    //WebViewController *webcontrol=[[WebViewController alloc]init];
    //NSString *completeUrl=[@"http://global.rakuten.com/en/search?st=&tl=0&k=" stringByAppendingString:self.searchstring];
    NSString *completeUrl=[[NSString alloc]initWithFormat:@"http://search8.taobao.com/search?q=%@&commend=all&ssid=s5-e&pid=mm_14507416_2297358_8935934",self.searchstring ];
    //[webcontrol setBrowseuuurl:[[NSURL alloc]initWithString:completeUrl]];
    NSDictionary *flurrydicttionary2=[[NSDictionary alloc]initWithObjectsAndKeys:@"Taobao",@"searchengine", nil];
    [Flurry logEvent:@"Search_Engine" withParameters:flurrydicttionary2 timed:YES];

    NSDictionary *dict = [NSDictionary dictionaryWithObject:completeUrl forKey:@"Searchwebsite"];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"webSearchactivated" object:self userInfo:dict];
    [self activityDidFinish:YES];
    
}

@end
