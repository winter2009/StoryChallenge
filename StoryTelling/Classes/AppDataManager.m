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
@synthesize currentKeywords = m_currentKeywords;
@synthesize currentPlayerIndex = m_currentPlayerIndex;

- (id)init
{
	if (( self = [super init] ))
	{
        m_currentPlayerIndex = 0;
        m_currentKeywords = [[NSMutableArray alloc] initWithCapacity:3];
        m_playerNames = [[NSMutableArray alloc] initWithObjects:@"", @"", @"", nil];
        m_playerRatings = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], nil];
		m_keywords = [[NSMutableArray alloc] init];
        [m_keywords addObject:@"猴子"];
        [m_keywords addObject:@"小孩"];
        [m_keywords addObject:@"学习"];
        [m_keywords addObject:@"吃饭"];
        [m_keywords addObject:@"打猎"];
        [m_keywords addObject:@"电脑"];
        [m_keywords addObject:@"水"];
        [m_keywords addObject:@"葡萄"];
        [m_keywords addObject:@"摔倒"];
        [m_keywords addObject:@"血"];
        [m_keywords addObject:@"妈妈"];
        [m_keywords addObject:@"忧伤"];
        [m_keywords addObject:@"爱"];
        [m_keywords addObject:@"痛苦"];
	}
	
	return self;
}

#pragma mark -
#pragma mark Public Methods
- (void)generateKeyWords
{
    NSMutableArray *tempKeyWords = [[NSMutableArray alloc] initWithArray:m_keywords copyItems:YES];
    [m_currentKeywords removeAllObjects];
    
    NSInteger count = 3;
    while ( count > 0 )
    {
        NSInteger index = (NSInteger)floor((rand() * 1.0 / RAND_MAX) * tempKeyWords.count);
        [m_currentKeywords addObject:[tempKeyWords objectAtIndex:index]];
        [tempKeyWords removeObjectAtIndex:index];
        count--;
    }
    
    // reset player names and player ratings
    m_currentPlayerIndex = 0;
    for ( int i = 0; i < 3; i++ ) 
    {
        [m_playerNames replaceObjectAtIndex:i withObject:@""];
        [m_playerRatings replaceObjectAtIndex:i withObject:[NSNumber numberWithInt:0]];
    }
}

- (void)setCurrentPlayerName:(NSString *)name
{
    [m_playerNames replaceObjectAtIndex:m_currentPlayerIndex withObject:name];
}

- (void)setCurrentPlayerRating:(NSInteger)rating
{
    [m_playerRatings replaceObjectAtIndex:m_currentPlayerIndex withObject:[NSNumber numberWithInt:rating]];
}

- (NSString *)keywordsString
{
    NSMutableString *keywords = [[NSMutableString alloc] init];
    for ( NSInteger i = 0; i < self.currentKeywords.count-1; i++ )
    {
        [keywords appendFormat:@"%@, ", [self.currentKeywords objectAtIndex:i]];
    }
    [keywords appendFormat:@"%@", [self.currentKeywords objectAtIndex:self.currentKeywords.count-1]];
    
    return keywords;
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
