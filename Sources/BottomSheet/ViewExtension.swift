//
//  ViewExtension.swift
//  BottomSheet
//
//  Created by Tieda Wei on 2020-04-25.
//  Copyright © 2020 Tieda Wei. All rights reserved.
//

import SwiftUI

#if !os(macOS)
public extension View {
    func bottomSheet<Content: View>(
        isPresented: Binding<Bool>,
        isAllowedBackgroundTouching: Binding<Bool>,
        height: CGFloat,
        topBarHeight: CGFloat = 30,
        topBarCornerRadius: CGFloat? = nil,
        contentBackgroundColor: Color = Color(.systemBackground),
        topBarBackgroundColor: Color = Color(.systemBackground),
        backgroundOpacity: CGFloat = 0,
        showTopIndicator: Bool = true,
        onDismiss: (() -> Void)? = nil,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View {
        ZStack {
            self
            BottomSheet(isPresented: isPresented,
                        isAllowedBackgroundTouching: isAllowedBackgroundTouching,
                        height: height,
                        topBarHeight: topBarHeight,
                        topBarCornerRadius: topBarCornerRadius,
                        topBarBackgroundColor: topBarBackgroundColor,
                        contentBackgroundColor: contentBackgroundColor,
                        backgroundOpacity: backgroundOpacity,
                        showTopIndicator: showTopIndicator,
                        onDismiss: onDismiss,
                        content: content)
        }
    }
    
    func bottomSheet<Item: Identifiable, Content: View>(
        item: Binding<Item?>,
        height: CGFloat,
        topBarHeight: CGFloat = 30,
        topBarCornerRadius: CGFloat? = nil,
        contentBackgroundColor: Color = Color(.systemBackground),
        topBarBackgroundColor: Color = Color(.systemBackground),
        showTopIndicator: Bool = true,
        backgroundOpacity: CGFloat = 0,
        onDismiss: (() -> Void)? = nil,
        @ViewBuilder content: @escaping (Item) -> Content
    ) -> some View {
        let isPresented = Binding {
            item.wrappedValue != nil
        } set: { value in
            if !value {
                item.wrappedValue = nil
            }
        }
        
        let isAllowedBackgroundTouching = Binding {
            item.wrappedValue != nil
        } set: { value in
            if !value {
                item.wrappedValue = nil
            }
        }
        
        return bottomSheet(
            isPresented: isPresented,
            isAllowedBackgroundTouching: isAllowedBackgroundTouching,
            height: height,
            topBarHeight: topBarHeight,
            topBarCornerRadius: topBarCornerRadius,
            contentBackgroundColor: contentBackgroundColor,
            topBarBackgroundColor: topBarBackgroundColor,
            backgroundOpacity: backgroundOpacity,
            showTopIndicator: showTopIndicator,
            onDismiss: onDismiss
        ) {
            if let unwrappedItem = item.wrappedValue {
              content(unwrappedItem).disabled(isPresented.wrappedValue)
            } else {
                EmptyView()
            }
        }
    }
}
#endif
