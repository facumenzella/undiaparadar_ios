//
//  RestkitService.h
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 9/29/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit.h>

typedef void (^RestKitCallback)(RKObjectRequestOperation*, RKMappingResult*, NSError*);

@interface RestkitService : NSObject

- (void)requestToPath:(NSString*)path
           withMethod:(RKRequestMethod)method
           withParams:(NSDictionary*)params
          withHeaders:(NSDictionary*)headers
         withCallback:(void (^)(RKMappingResult*, NSError*))cb;

- (void)requestToPath:(NSString*)path
           withMethod:(RKRequestMethod)method
          withMapping:(RKMapping*)mapping
           withParams:(NSDictionary*)params
          withHeaders:(NSDictionary*)headers
         withCallback:(void (^)(RKMappingResult*, NSError*))cb;

- (void)requestToPath:(NSString*)path
           withMethod:(RKRequestMethod)method
          withMapping:(RKMapping*)mapping
           withParams:(NSDictionary*)params
          withHeaders:(NSDictionary*)headers
          withKeyPath:(NSString*)keyPath
         withCallback:(void (^)(RKMappingResult*, NSError*))cb;

- (void)requestToPath:(NSString*)path
           withMethod:(RKRequestMethod)method
          withMapping:(RKMapping*)mapping
           withParams:(NSDictionary*)params
          withHeaders:(NSDictionary*)headers
          withKeyPath:(NSString*)keyPath
             withBody:(id)body
         withCallback:(void (^)(RKMappingResult*, NSError*))cb;

- (void)requestToPath:(NSString*)path
           withMethod:(RKRequestMethod)method
          withMapping:(RKMapping*)mapping
           withParams:(NSDictionary*)params
          withHeaders:(NSDictionary*)headers
          withKeyPath:(NSString*)keyPath
             withBody:(id)body
  withRestkitCallback:(RestKitCallback)cb;


@end
