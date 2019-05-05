//
//  NBULogFormatter.m
//  NBULog
//
//  Created by Ernesto Rivera on 2013/11/12.
//  Copyright (c) 2012-2017 CyberAgent Inc.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

#import "NBULogFormatter.h"

static NSString * _processName;

@implementation NBULogFormatter

+ (void)initialize
{
    if (self == [NBULogFormatter class])
    {
        _processName = [[NSProcessInfo processInfo] processName];
    }
}

- (NSString *)formatLogMessage:(DDLogMessage *)logMessage
{
    // One-charecter log level
    NSString * logLevel;
    switch (logMessage->_flag)
    {
        case DDLogFlagError   : logLevel = @"‼️‼️‼️"; break;
        case DDLogFlagWarning : logLevel = @"⚠️⚠️⚠️"; break;
        case DDLogFlagInfo    : logLevel = @"ℹ️ℹ️ℹ️"; break;
        case DDLogFlagDebug   : logLevel = @"🔹🔹🔹"; break;
        default               : logLevel = @"🗯🗯🗯"; break;
    }
    
    return [NSString stringWithFormat:@"%@ %@[%@] %@ %@:%@ %@",
            [self stringFromDate:(logMessage->_timestamp)],
            _processName,
            [self queueThreadLabelForLogMessage:logMessage],
            logLevel,
            logMessage->_fileName,
            @(logMessage->_line),
            logMessage->_message];
}

@end

