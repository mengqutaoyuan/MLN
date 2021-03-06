//
//  MLNUIStack.m
//  MLNUI
//
//  Created by MOMO on 2020/3/23.
//

#import "MLNUIStack.h"
#import "MLNUIKitHeader.h"
#import "UIView+MLNUILayout.h"
#import "MLNUIViewExporterMacro.h"

@implementation MLNUIStack {
    BOOL _disableVirtualLayout;
}

- (instancetype)initWithMLNUILuaCore:(MLNUILuaCore *)luaCore disableVirtualLayout:(NSNumber *)disableVirtualLayout {
    if (self = [super initWithMLNUILuaCore:luaCore]) {
        _disableVirtualLayout = [disableVirtualLayout boolValue];
    }
    return self;
}

#pragma mark - Override

- (BOOL)luaui_isContainer {
    return YES;
}

- (BOOL)mlnui_layoutEnable {
    return YES;
}

- (BOOL)mlnui_allowVirtualLayout {
    return !_disableVirtualLayout;
}

#pragma mark - Export Lua

- (void)luaui_children:(NSArray<UIView *> *)subviews {
    if ([subviews isKindOfClass:[NSArray class]] == NO) {
        return;
    }
    [subviews enumerateObjectsUsingBlock:^(UIView *_Nonnull view, NSUInteger idx, BOOL *_Nonnull stop) {
        if ([view isKindOfClass:[UIView class]]) {
            [self luaui_addSubview:view];
        }
    }];
}

LUAUI_EXPORT_VIEW_BEGIN(MLNUIStack)
LUAUI_EXPORT_VIEW_METHOD(children, "luaui_children:", MLNUIStack)
LUAUI_EXPORT_VIEW_END(MLNUIStack, Stack, YES, "MLNUIView", "initWithMLNUILuaCore:disableVirtualLayout:")

@end

@implementation MLNUIPlaneStack

- (void)setLuaui_reverse:(BOOL)reverse {
    NSAssert(false, @"@Note: subclass should override this method.");
}

- (void)setCrossAxisSize:(CGSize)size {
    NSAssert(false, @"@Note: subclass should override this method.");
}

- (void)setCrossAxisMaxSize:(CGSize)maxSize {
    NSAssert(false, @"@Note: subclass should override this method.");
}

#pragma mark - Export Lua

LUAUI_EXPORT_VIEW_BEGIN(MLNUIPlaneStack)
LUAUI_EXPORT_VIEW_METHOD(reverse, "setLuaui_reverse:", MLNUIPlaneStack)
LUAUI_EXPORT_VIEW_END(MLNUIPlaneStack, PlaneStack, YES, "MLNUIStack", "initWithMLNUILuaCore:disableVirtualLayout:")

@end
