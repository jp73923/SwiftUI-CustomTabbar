//
//  ContentView.swift
//  SwiftUI-CustomTabbar
//
//  Created by macOS on 13/06/23.
//

import SwiftUI

struct Home: View {
    /// View Properties
    @State private var activeTab:Tab = .home
    /// For Smooth Shape Sliding Effect, We're going to use Matched Gematry Effect
    @Namespace private var animation
    @State private var tabShapePostion: CGPoint = .zero
    init() {
        /// Hiding Tab bar due To SwiftUI iOS 16 Bug
        UITabBar.appearance().isHidden = true
    }
    var body: some View {
        VStack {
            TabView(selection: $activeTab) {
                Text("Home")
                    .foregroundColor(.red)
                    .tag(Tab.home)
                
                Text("Collegues")
                    .foregroundColor(.blue)
                    .tag(Tab.collegues)
                
                Text("Favourites")
                    .foregroundColor(.gray)
                    .tag(Tab.favourites)
                
                Text("Notifications")
                    .foregroundColor(.green)
                    .tag(Tab.notifications)
            }
            CustomTabbar()
        }
    }
    
    
    /// Custom Tab Bar
    /// With More Easy Customization
    @ViewBuilder
    func CustomTabbar(_ tint: Color = Color("Blue"), _ inactiveTint: Color = .blue) -> some View {
        HStack(spacing: 0) {
            ForEach(Tab.allCases, id: \.rawValue) {
                TabItem(tint: tint,
                        inactiveTint: inactiveTint,
                        tab: $0,
                        animation: animation,
                        activeTab: $activeTab,
                        position: $tabShapePostion
                )
            }
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 10)
        .background(content: {
            TabShape(midpoint: tabShapePostion.x)
                .fill(.white)
                .ignoresSafeArea()
                /// Adding Blur + Shadow
                /// For Shape Smoothing
                .shadow(color: .blue.opacity(0.2), radius: 5, x: 0, y: -5)
                .blur(radius: 2)
                .padding(.top, 25)
        })
        /// Adding Animation
        .animation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7), value: activeTab)
    }
}

///Tab Bar Item
struct TabItem: View {
    var tint: Color
    var inactiveTint: Color
    var tab:Tab
    var animation: Namespace.ID
    @Binding var activeTab: Tab
    @Binding var position: CGPoint
    
    /// Each Tab Item Postion on the Screen
    @State private var tabPostion:CGPoint = .zero
    var body: some View {
        VStack(spacing: 0) {
            Image(systemName: tab.systemImage)
                .font(.title2)
                .foregroundColor(activeTab == tab ? .white : inactiveTint)
                /// Increasing Size For Active Tab
                .frame(width: activeTab == tab ? 58 : 35,height: activeTab == tab ? 58 : 35)
                .background{
                    if activeTab == tab {
                        Circle()
                            .fill(.tint)
                           // .fill(tint.gradient)
                            .matchedGeometryEffect(id: "ACTIVETAB", in: animation)
                    }
                }
            
            Text(tab.rawValue)
                .font(.caption)
                .foregroundColor(activeTab == tab ? .blue : .gray)
        }
        .frame(maxWidth: .infinity)
        .contentShape(Rectangle())
        .viewPostion(completion: { rect in
            tabPostion.x = rect.midX
            
            /// Updating Active Tab Postion
            if activeTab == tab {
                position.x = rect.midX
            }
        })
        .onTapGesture {
            activeTab = tab
            
            withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)) {
                position.x = tabPostion.x
            }
        }
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
