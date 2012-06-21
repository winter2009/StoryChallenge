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
    NSMutableArray  *m_topics;
    NSMutableArray  *m_conditions;
    NSString        *m_currentTopic;
    NSInteger       m_currentPlayerIndex;
    NSMutableArray  *m_playerNames;
    NSMutableArray  *m_playerRatings;
}

@property (nonatomic, strong) NSString *currentTopic;
@property (nonatomic) NSInteger currentPlayerIndex;

+ (AppDataManager *)sharedAppDataManager;
- (void)generateTopic;
- (NSString *)generateCondition;
- (void)setCurrentPlayerName:(NSString *)name;
- (void)setCurrentPlayerRating:(NSInteger)rating;
- (NSString *)currentPlayerName;
- (NSString *)winner;

@end
