//
//  SpotlightHandler.m
//  SwithNavDemo
//
//  Created by mahong on 17/3/3.
//  Copyright © 2017年 mahong. All rights reserved.
//

#import "SpotlightHandler.h"
#import <CoreSpotlight/CoreSpotlight.h>
#import <MobileCoreServices/MobileCoreServices.h>

@implementation SpotlightHandler

+ (void)setSpotlight
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        [[CSSearchableIndex defaultSearchableIndex] deleteAllSearchableItemsWithCompletionHandler:^(NSError * _Nullable error) {
            if (!error) {
                NSLog(@"删除成功");
            }
        }];
        
        NSArray *titles = @[@"title1",@"title2",@"title3",@"title4",@"title5new"];
        NSArray *contents = @[@"content1",@"content2",@"content3",@"content4",@"content5new"];
        NSArray *keys = @[@"key1",@"key2",@"key3",@"key4",@"key5"];
        NSArray *images = @[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1488789076329&di=3a29218c790f2161ca08cb47af4330b8&imgtype=0&src=http%3A%2F%2Fimg.pconline.com.cn%2Fimages%2Fupload%2Fupc%2Ftx%2Fphotoblog%2F1112%2F29%2Fc2%2F10087294_10087294_1325133605031_mthumb.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1488789076329&di=7feec1e928d833167622d74d2a95e537&imgtype=0&src=http%3A%2F%2Fmvimg2.meitudata.com%2F56074c97d79468889.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1488789076329&di=fb7de70b4f1ba06c46621b76db787cf1&imgtype=0&src=http%3A%2F%2Fmvimg2.meitudata.com%2F5680b8019782e2655.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1488789076328&di=084924c45d54e446e6d11390f0fd68a4&imgtype=0&src=http%3A%2F%2Fmvimg2.meitudata.com%2F56d2e545063391718.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1488789076328&di=7c0d2e3766a9ee6ead08fd3c226cc7d8&imgtype=0&src=http%3A%2F%2Fmvimg1.meitudata.com%2F56385ed7325a06330.jpg"];
        NSInteger count = titles.count;
        
        NSMutableArray *items = [NSMutableArray array];
        for (int i = 0; i < count; i++) {
            CSSearchableItemAttributeSet *set = [[CSSearchableItemAttributeSet alloc] initWithItemContentType:(NSString*)kUTTypeText];
            set.title = titles[i];
            set.contentDescription = contents[i];
            set.contactKeywords = @[keys[i]];
            /** 缩略图 */
            set.thumbnailData = [NSData dataWithContentsOfURL:[NSURL URLWithString:images[i]]];
            
//            CSPerson *csperson = [[CSPerson alloc] initWithDisplayName:@"马宏" handles:@[@"in"] handleIdentifier:@"identifier"];
//            CSCustomAttributeKey *customKey = [[CSCustomAttributeKey alloc] initWithKeyName:@"customkey"];
//            [set setValue:csperson forCustomKey:customKey];
//            
            /** 实际操作中 使用scheme 当做 uniqueIdentifier */
            CSSearchableItem *item  = [[CSSearchableItem alloc] initWithUniqueIdentifier:[NSString stringWithFormat:@"ybjk%@://",titles[i]] domainIdentifier:@"com.runbey" attributeSet:set];
            /** 设置失效时间 默认一个月 */
            item.expirationDate = [NSDate dateWithTimeIntervalSinceNow:15];
            [items addObject:item];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [[CSSearchableIndex defaultSearchableIndex] indexSearchableItems:items completionHandler:^(NSError * _Nullable error) {
                if (!error) {
                    NSLog(@"插入成功");
                }
            }];
        });
    });
}

@end
