//
//  UserTableViewController.h
//  Emotion Diary
//
//  Created by 范志康 on 16/5/3.
//  Copyright © 2016年 范志康. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

#define UNLOCK_TYPE @"unlockType"

typedef NS_ENUM(NSInteger, EmotionDiaryUnlockType) {
    EmotionDiaryUnlockTypeSelfie,
    EmotionDiaryUnlockTypeTouchID
};

@interface UserTableViewController : UITableViewController <MFMailComposeViewControllerDelegate> {
    NSMutableArray<EmotionDiary *> *shareData;
}

@end
