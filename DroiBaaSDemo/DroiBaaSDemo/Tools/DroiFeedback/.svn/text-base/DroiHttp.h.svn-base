/*
 * Copyright (c) 2016-present Shanghai Droi Technology Co., Ltd.
 * All rights reserved.
 */

#import <Foundation/Foundation.h>

#pragma mark Constants
FOUNDATION_EXPORT NSString* const DROI_IP_LIST_URL;
FOUNDATION_EXPORT NSString* const DROI_VALIDATE_SERVICE;
FOUNDATION_EXPORT NSString* const DROI_HTTP_HEADER_DROI_STATUS;
FOUNDATION_EXPORT NSString* const DROI_HTTP_HEADER_DROI_OTP;
FOUNDATION_EXPORT NSString* const DROI_HTTP_HEADER_DROI_TS;
FOUNDATION_EXPORT NSString* const DROI_HTTP_HEADER_DROI_ID;
FOUNDATION_EXPORT NSString* const DROI_KEY_APP_ID;
FOUNDATION_EXPORT NSString* const DROI_KEY_PLATFORM_ID;
FOUNDATION_EXPORT NSString* const DROI_KEY_DEVICE_ID;

FOUNDATION_EXPORT const int COMMUNICATION_PROTOCOL_VERSION;

#pragma mark Structure
typedef struct {
    uint64_t high;
    uint64_t low;
} DeviceId;

#pragma mark Enumeration
typedef NS_ENUM(int, DroiHttpError) {
    RET_OK = 0,
    UNSET = -1001,
    ENC_ERROR = -1002,
    DEC_ERROR = -1003,
    DECOMPRESS_ERROR = -1004,
    UNSUPPORTED_ENCODING_BODY_ERROR = -1005,
    HTTP_STATUS_CODE_ERROR = -1006,
    KEY_DISTRIBUTION_ERROR = -1007,
    CANCELLED_ERROR = -1008,
    PARSER_ERROR = -1009,
    DROI_STATUS_ERROR = -1010,
    NETWORK_ERROR = -1011,
    EXCEPTION_ERROR = -1012,
    IP_LIST_ERROR = -1013,
    REQUEST_ERROR = -1014,
    TIMESTAMP_UPDATE_ERROR = -1030,
    KLKEY_FILE_EMPTY_ERROR = -10201,
    KLKEY_FILE_NOT_FOUND_ERROR = -10202,
    KLKEY_FILE_IO_ERROR = -10203,
    KLKEY_EMPTY_ERROR = -10211,
    KLKEY_ALLOC_ERROR = -10212,
    KD_GENKEYVALIDATION_ERROR = -10000,
    KD_NETWORK_ERROR = -10001,
    KD_STATUSCODE_ERROR = -10002,
    KD_DROI_TS_PARSE_ERROR = -10004,
    KD_DROI_STATUS_PARSE_ERROR = -10004,
    KD_DROI_XOR_PARSE_ERROR = -10006,
    KD_DROISTATUS_ERROR = -10007,
};

#pragma mark DroiHttpRequest
/**
 *  Request for {@link DroiHttp#request:}
 */
@interface DroiHttpRequest : NSObject
/**
 *  Create instance from service name and data
 *
 *  @param service Droi service name, must start with '/'
 *  @param data    The data will be sent by POST. Data can be nil.
 *
 *  @return instance
 */
+ (instancetype) requestWithService:(NSString*) service Data:(NSData*) data;
/**
 *  Add header
 *
 *  @param value  header value
 *  @param header header name
 */
- (void) addValue:(NSString*) value withHeaderName:(NSString*) header;
@end

#pragma mark DroiHttpResponse
/**
 *  Response for {@link DroiHttp#request:}
 */
@interface DroiHttpResponse : NSObject
/**
 *  Error code. Defined in {@link DroiHttpError}
 */
@property DroiHttpError errorCode;
/**
 *  Http status code.
 */
@property int httpStatusCode;
/**
 *  Droi status code.
 */
@property int droiStatusCode;
/**
 *  Response data.
 */
@property NSData* data;
@end

#pragma mark DroiHttp
/**
 *  Droi secure http
 */
@interface DroiHttp : NSObject
/**
 *  Get singleton instance
 *
 *  @return Instance
 */
+ (instancetype) instance;
/**
 *  Get Device Id from server.
 *
 *  @return Device id
 */
- (DeviceId) getDeviceId;
/**
 *  Send Droi secure http request
 *
 *  @param request {@link DroiHttpRequest}
 *
 *  @return {@link DroiHttpResponse}
 */
- (DroiHttpResponse *) request:(DroiHttpRequest *) request;
@end

