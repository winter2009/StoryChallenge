//
//  AppDataManager.m
//  StoryTelling
//
//  Created by Zonghui Zhang on 16/6/12.
//  Copyright 2012 PhoneSoul. All rights reserved.
//

#import "AppDataManager.h"

static AppDataManager *singletonAppDataManager = nil;

@implementation AppDataManager
@synthesize currentTopic = m_currentTopic;
@synthesize currentPlayerIndex = m_currentPlayerIndex;

- (id)init
{
	if (( self = [super init] ))
	{
        m_currentPlayerIndex = 0;
        m_currentTopic = @"";
        m_playerNames = [[NSMutableArray alloc] initWithObjects:@"", @"", @"", nil];
        m_playerRatings = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], nil];
        
		m_topics = [[NSMutableArray alloc] init];        
        [m_topics addObject:@"上得山多终遇虎"];
        [m_topics addObject:@"蜗牛建房子"];
        [m_topics addObject:@"大战红山"];
        [m_topics addObject:@"超人不会飞"];
        [m_topics addObject:@"水淹乌节路"];
        [m_topics addObject:@"家有一老如有一宝"];
        [m_topics addObject:@"向左走向右走"];
        [m_topics addObject:@"新加坡河畔的王子"];
        [m_topics addObject:@"打肿脸皮充胖子"];
        [m_topics addObject:@"霹雳火"];
        
        m_conditions = [[NSMutableArray alloc] init];
        [m_conditions addObject:@"表演中，参赛同学必须大笑三次"];
        [m_conditions addObject:@"故事中的人物必须说三次：“好吃！”"];
        [m_conditions addObject:@"故事中必须有鱼头米粉"];
        [m_conditions addObject:@"部分故事必须发生在地铁站"];
        [m_conditions addObject:@"部分故事必须发生在屋顶上"];
        [m_conditions addObject:@"故事中的人物必须说三次：“跟我走！”"];
        [m_conditions addObject:@"部分故事中必须发生在一个婚礼上"];
        [m_conditions addObject:@"故事中的人物必须说三句吉祥话"];
        [m_conditions addObject:@"表演中，参赛同学必须跳草裙舞"];
        [m_conditions addObject:@"故事必须发生在停电的晚上"];
	}
	
	return self;
}

#pragma mark -
#pragma mark Public Methods
- (void)generateTopic
{
    m_currentTopic = [m_topics objectAtIndex:( arc4random() % m_topics.count )];
}

- (NSString *)generateCondition
{
    return [m_conditions objectAtIndex:( arc4random() % m_conditions.count )];
}

- (void)setCurrentPlayerName:(NSString *)name
{
    [m_playerNames replaceObjectAtIndex:m_currentPlayerIndex withObject:name];
}

- (void)setCurrentPlayerRating:(NSInteger)rating
{
    [m_playerRatings replaceObjectAtIndex:m_currentPlayerIndex withObject:[NSNumber numberWithInt:rating]];
}

- (NSString *)currentPlayerName
{
    NSString *playerName = [m_playerNames objectAtIndex:m_currentPlayerIndex];
    return playerName;
}

- (NSString *)winner
{
    NSInteger highestRating = 0;
    for ( NSNumber *rating in m_playerRatings )
    {
        if ( rating.intValue > highestRating )
        {
            highestRating = rating.intValue;
        }
    }
    
    NSMutableString *winnerString = [[NSMutableString alloc] init];
    for ( NSInteger i = 0; i < m_playerRatings.count; i++ )
    {
        NSNumber *rating = [m_playerRatings objectAtIndex:i];
        if ( rating.intValue == highestRating )
        {
            [winnerString appendFormat:@"%@, ", [m_playerNames objectAtIndex:i]];
        }
    }
    if ( winnerString.length > 2 )
    {
        return [winnerString substringToIndex:winnerString.length - 2];
    }
    
    return @"";
}

#pragma mark -
#pragma mark Singelton Methods
+ (AppDataManager*)sharedAppDataManager 
{
	@synchronized ( self ) 
	{
		if ( !singletonAppDataManager ) 
		{
			singletonAppDataManager = [[AppDataManager alloc] init];
		}
	}
	
	return singletonAppDataManager;
}
 
+ (id)allocWithZone:(NSZone *)zone 
{
    @synchronized ( self ) 
	{
        if ( !singletonAppDataManager ) 
		{
            singletonAppDataManager = [super allocWithZone:zone];
            return singletonAppDataManager;
        }
    }
	
    return nil;
}
 
- (id)copyWithZone:(NSZone *)zone 
{
	return self;
}

@end
