//
//  AppDataManager.h
//  StoryTelling
//
//  Created by Zonghui Zhang on 16/6/12.
//  Copyright 2012 PhoneSoul. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppDataManager : NSObject 
{
    NSMutableArray  *m_keywords;
    NSMutableArray  *m_currentKeywords;
    NSInteger       m_currentPlayerIndex;
    NSMutableArray  *m_playerNames;
    NSMutableArray  *m_playerRatings;
}

@property (nonatomic, strong) NSMutableArray *currentKeywords;
@property (nonatomic) NSInteger currentPlayerIndex;

+ (AppDataManager *)sharedAppDataManager;
- (void)generateKeyWords;
- (void)setCurrentPlayerName:(NSString *)name;
- (void)setCurrentPlayerRating:(NSInteger)rating;
- (NSString *)keywordsString;
- (NSString *)currentPlayerName;
- (NSString *)winner;

@end
