// Autogenerated from Pigeon (v17.1.3), do not edit directly.
// See also: https://pub.dev/packages/pigeon

#import <Foundation/Foundation.h>

@protocol FlutterBinaryMessenger;
@protocol FlutterMessageCodec;
@class FlutterError;
@class FlutterStandardTypedData;

NS_ASSUME_NONNULL_BEGIN

@class AudioData;
@class PlaybackState;
@class BackgroundSound;
@class Speed;
@class Track;

@interface AudioData : NSObject
/// `init` unavailable to enforce nonnull fields, see the `make` class method.
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)makeWithUrl:(NSString *)url
    track:(Track *)track;
@property(nonatomic, copy) NSString * url;
@property(nonatomic, strong) Track * track;
@end

@interface PlaybackState : NSObject
/// `init` unavailable to enforce nonnull fields, see the `make` class method.
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)makeWithIsPlaying:(BOOL )isPlaying
    isBuffering:(BOOL )isBuffering
    isSeeking:(BOOL )isSeeking
    isCompleted:(BOOL )isCompleted
    position:(NSInteger )position
    duration:(NSInteger )duration
    speed:(Speed *)speed
    volume:(NSInteger )volume
    track:(Track *)track
    backgroundSound:(nullable BackgroundSound *)backgroundSound;
@property(nonatomic, assign) BOOL  isPlaying;
@property(nonatomic, assign) BOOL  isBuffering;
@property(nonatomic, assign) BOOL  isSeeking;
@property(nonatomic, assign) BOOL  isCompleted;
@property(nonatomic, assign) NSInteger  position;
@property(nonatomic, assign) NSInteger  duration;
@property(nonatomic, strong) Speed * speed;
@property(nonatomic, assign) NSInteger  volume;
@property(nonatomic, strong) Track * track;
@property(nonatomic, strong, nullable) BackgroundSound * backgroundSound;
@end

@interface BackgroundSound : NSObject
/// `init` unavailable to enforce nonnull fields, see the `make` class method.
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)makeWithUri:(nullable NSString *)uri
    title:(NSString *)title;
@property(nonatomic, copy, nullable) NSString * uri;
@property(nonatomic, copy) NSString * title;
@end

@interface Speed : NSObject
/// `init` unavailable to enforce nonnull fields, see the `make` class method.
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)makeWithSpeed:(double )speed;
@property(nonatomic, assign) double  speed;
@end

@interface Track : NSObject
/// `init` unavailable to enforce nonnull fields, see the `make` class method.
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)makeWithTitle:(NSString *)title
    description:(NSString *)description
    imageUrl:(NSString *)imageUrl
    artist:(nullable NSString *)artist
    artistUrl:(nullable NSString *)artistUrl;
@property(nonatomic, copy) NSString * title;
@property(nonatomic, copy) NSString * description;
@property(nonatomic, copy) NSString * imageUrl;
@property(nonatomic, copy, nullable) NSString * artist;
@property(nonatomic, copy, nullable) NSString * artistUrl;
@end

/// The codec used by MeditoAndroidAudioServiceManager.
NSObject<FlutterMessageCodec> *MeditoAndroidAudioServiceManagerGetCodec(void);

@protocol MeditoAndroidAudioServiceManager
- (void)startServiceWithError:(FlutterError *_Nullable *_Nonnull)error;
@end

extern void SetUpMeditoAndroidAudioServiceManager(id<FlutterBinaryMessenger> binaryMessenger, NSObject<MeditoAndroidAudioServiceManager> *_Nullable api);

/// The codec used by MeditoAudioServiceApi.
NSObject<FlutterMessageCodec> *MeditoAudioServiceApiGetCodec(void);

@protocol MeditoAudioServiceApi
/// @return `nil` only when `error != nil`.
- (nullable NSNumber *)playAudioAudioData:(AudioData *)audioData error:(FlutterError *_Nullable *_Nonnull)error;
- (void)playPauseAudioWithError:(FlutterError *_Nullable *_Nonnull)error;
- (void)stopAudioWithError:(FlutterError *_Nullable *_Nonnull)error;
- (void)setSpeedSpeed:(double)speed error:(FlutterError *_Nullable *_Nonnull)error;
- (void)seekToPositionPosition:(NSInteger)position error:(FlutterError *_Nullable *_Nonnull)error;
- (void)skip10SecondsForwardWithError:(FlutterError *_Nullable *_Nonnull)error;
- (void)skip10SecondsBackwardWithError:(FlutterError *_Nullable *_Nonnull)error;
- (void)setBackgroundSoundUri:(nullable NSString *)uri error:(FlutterError *_Nullable *_Nonnull)error;
- (void)setBackgroundSoundVolumeVolume:(double)volume error:(FlutterError *_Nullable *_Nonnull)error;
- (void)stopBackgroundSoundWithError:(FlutterError *_Nullable *_Nonnull)error;
- (void)playBackgroundSoundWithError:(FlutterError *_Nullable *_Nonnull)error;
@end

extern void SetUpMeditoAudioServiceApi(id<FlutterBinaryMessenger> binaryMessenger, NSObject<MeditoAudioServiceApi> *_Nullable api);

/// The codec used by MeditoAudioServiceCallbackApi.
NSObject<FlutterMessageCodec> *MeditoAudioServiceCallbackApiGetCodec(void);

@interface MeditoAudioServiceCallbackApi : NSObject
- (instancetype)initWithBinaryMessenger:(id<FlutterBinaryMessenger>)binaryMessenger;
- (void)updatePlaybackStateState:(PlaybackState *)state completion:(void (^)(FlutterError *_Nullable))completion;
@end

NS_ASSUME_NONNULL_END
