//
//  KCArgList.m
//  kerkee
//
//  Created by zihong on 15/11/16.
//  Copyright © 2015年 zihong. All rights reserved.
//

#import "KCArgList.h"
#import "KCBaseDefine.h"
#import "KCJSDefine.h"

@interface KCArgList()
{
    NSMutableDictionary *m_Args;
}

@end

@implementation KCArgList

- (id)init
{
    self = [super init];
    if(self)
    {
        m_Args = [[NSMutableDictionary alloc] initWithCapacity:5];
     }
    
    return self;
}

- (void)dealloc
{
    m_Args = nil;
    
    KCDealloc(super);
}



- (BOOL) addArg:(KCArg *)aArg
{
    if(nil == aArg)
    {
        return NO;
    }
    
    [m_Args setObject:aArg forKey:[aArg getArgName]];
    
    //KCLog(@"Arg--%@",[aArg toString]);
    
    return YES;
}

- (BOOL)has:(NSString*)aKey
{
    return [self getArgValule:aKey] ? YES : NO;
}

- (id) getArgValule:(NSString *)aKey
{
    if(nil == aKey)
    {
        return nil;
    }
    
    KCArg *arg = [m_Args objectForKey:aKey];
    if(nil == arg)
    {
        return nil;
    }
    
    return [arg getValue];
}

- (NSString *)getArgValueString:(NSString *)aKey
{
    return [self getString:aKey];
}

- (NSString*)getString:(NSString*)aKey
{
    id value = [self getArgValule:aKey];
    return value ? [value description] : value;
}

- (KCJSCallback*)getCallback
{
    return [self getArgValule:kJS_callbackId];
}

- (NSString *)toString
{
    if(nil == m_Args || [m_Args count] <= 0)
        return nil;
    
    __block NSMutableString *str = [NSMutableString string];
    [m_Args enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop)
    {
        KCArg* arg = [[KCArg alloc] initWithObject:obj name:key];
        [str appendString:[arg toString]];
        [str appendString:@";"];
    }];
    
    return str;
}

- (NSInteger)count
{
    return [m_Args count];
}

@end


