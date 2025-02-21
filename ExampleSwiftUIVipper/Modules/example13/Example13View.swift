//
//  Example13View.swift
//  ExampleSwiftUIVipper
//
//  Created by raditsan on 18/02/25.
//

import SwiftUI
class Example13ViewState: ObservableObject {
    @Published var expand = false
    @Published var headerHight: CGFloat = 0.0
    @Published var parentHeight: CGFloat = 0.0
    @Published var headerHeight: CGFloat = 0.0
    @Published var subHeaderHeight: CGFloat = 0.0
    @Published var tabHeight: CGFloat = 0.0
}
struct Example13View: View {
    @StateObject var state = Example13ViewState()

    var body: some View {
        GeometryReader { proxy in
            VStack {
                ContainerHeader()
                ContainerSubHeader()
                ContainerContent()
                ContaineBottomTab()
            }
            .background(
                GeometryReader { proxy in
                    Color.red
                        .onAppear {
                            state.parentHeight = proxy.size.height
                        }
                }
            )
            .edgesIgnoringSafeArea(.bottom)
            .environmentObject(state)
            .onAppear {
//                state.parentHeight = proxy.size.height
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        
    }
}

struct ContainerHeader: View {
    @EnvironmentObject var state: Example13ViewState
    
    var body: some View {
        if !state.expand {
            Text("Header")
                .font(.largeTitle)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 20)
                .padding(.trailing, 20)
                .background(
                    GeometryReader { proxy in
                        Color.clear // Invisible background
                            .onAppear {
                                state.headerHight = proxy.size.height
                            }
                    }
                )
        } else {
            EmptyView()
        }
        Spacer()
    }
}

struct ContainerSubHeader: View {
    @EnvironmentObject var state: Example13ViewState
    
    var body: some View {
        Text("Sub Header")
            .font(state.expand ? .title3 : .title)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 20)
            .padding(.trailing, 20)
            .background(
                GeometryReader { proxy in
                    Color.clear // Invisible background
                        .onAppear {
                            state.subHeaderHeight = proxy.size.height
                        }
                        .onChange(of: proxy.size.height) { newValue in
                            state.subHeaderHeight = proxy.size.height
                        }
                }
            )
    }
}

struct ContainerContent: View {
    @EnvironmentObject var state: Example13ViewState
    @Namespace var shapeTransition
    
    @State private var viewPadding: CGFloat = 20
    @State private var viewHeight: CGFloat = 250
    @State private var maxHeight: CGFloat = 250
    @State private var bottomTabOpacity: Double = 1.0
    @State private var isDrag: Bool = false
    private let minHeight: CGFloat = 250
    private let minPadding: CGFloat = 0
    private let maxPadding: CGFloat = 20
    private let maxVelocity: CGFloat = 1800

    func doAnimate() {
        withAnimation(.bouncy(duration: 0.7)) {
            state.expand.toggle()
            viewHeight = state.expand ? maxHeight : minHeight
            viewPadding = state.expand ? minPadding : maxPadding
        }
    }
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .matchedGeometryEffect(id: "idcontent", in: shapeTransition)
            .foregroundColor(Color(.orange))
            .overlay(
                GeometryReader { geometry in
                    
                    VStack {
                        VStack {
                            Divider()
                                .frame(height: 5)
                                .frame(maxWidth: 40)
                                .background(Color(.white))
                                .cornerRadius(3)
                        }
                        .frame(height: 30)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .gesture(
                                DragGesture()
                                    .onChanged { value in
                                        isDrag = true
                                        let newHeight = viewHeight - value.translation.height
                                        if newHeight < minHeight {
                                            viewHeight = minHeight
                                        } else if newHeight > maxHeight {
                                            viewHeight = maxHeight
                                        } else {
                                            viewHeight = newHeight
                                            
                                            // Perubahan width bertahap saat drag
                                            let heightRatio = (viewHeight - minHeight) / (maxHeight - minHeight)
                                            viewPadding = minPadding + (maxPadding - minPadding) * (1 - heightRatio)
                                            print("viewPadding", viewPadding, heightRatio)
                                        }
                                    }
                                    .onEnded { value in
                                        isDrag = false
                                        doAnimate()
                                    }
                            )
                        VStack {
                            Text("Parent size: \(state.parentHeight)")
                            Text("VStack size: \(geometry.size.height)")
                                .padding(.horizontal)
                                .transition(.opacity)
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                        .matchedGeometryEffect(id: "textsize", in: shapeTransition)
                        .id(state.expand ? "expandedText" : "collapsedText") // Force re-render
                        
                        
                                            
                        List(1..<10) { item in
                            Text("Item \(item)")
                                .listRowBackground(Color.clear)
                        }
                        .listStyle(PlainListStyle())
                        
                        Rectangle().fill(Color.red).frame(height: 20).padding(.horizontal, 20)
                    }.onAppear {
                        maxHeight = state.parentHeight
                        maxHeight -= state.headerHeight
                        maxHeight -= state.subHeaderHeight
                        maxHeight -= state.tabHeight
                    }
                }
            )
            .padding(.horizontal, viewPadding)
            .frame(height: viewHeight)
            .onTapGesture {
                doAnimate()
            }
    }
}

struct ContaineBottomTab: View {
    @EnvironmentObject var state: Example13ViewState
    
    var tabContent: some View {
        VStack {
            RoundedRectangle(cornerRadius: 20)
                .frame(width: 200, height: 50)
                .foregroundColor(Color(.orange))
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                .overlay {
                    HStack(alignment: .center, spacing: 20) {
                        Button(action: {}) {
                            Image(systemName: "house.fill")
                                .foregroundColor(.white)
                                .font(.headline)
                        }
                        Button(action: {}) {
                            Image(systemName: "document.fill")
                                .foregroundColor(.white)
                                .font(.headline)
                        }
                    }
                }
            Rectangle().frame(height: 10).foregroundStyle(Color(.clear))
        }
        .background(
            GeometryReader { proxy in
                Color.clear // Invisible background
                    .onAppear {
                        state.tabHeight = proxy.size.height
                    }
                    .onChange(of: proxy.size.height) { newValue in
                        state.tabHeight = newValue
                    }
            }
        )
    }
    
    var body: some View {
        if state.expand {
            EmptyView()
        } else {
            tabContent
        }
    }
}

struct Example13View5: View {
    @Namespace private var shapeTransition
    @State private var expand = false
    var body: some View {
        VStack(alignment: .leading) {
            if !expand {
                HeaderLabel(shapeTransition: shapeTransition)
                Spacer()
            }
            
            if expand {
                RoundedBody(expand: $expand, shapeTransition: shapeTransition)
            } else {
                RoundedBody(expand: $expand, shapeTransition: shapeTransition)
                BottomTabView(shapeTransition: shapeTransition)
            }
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct ContentBody: View {
    var shapeTransition: Namespace.ID
    var body: some View {
        VStack {
            List(1..<10) { item in
                Text("Item \(item)")
                    .listRowBackground(Color.clear)
            }
            .listStyle(PlainListStyle())
        }
        .matchedGeometryEffect(id: "content2", in: shapeTransition)
    }
}

struct RoundedBody: View {
    @Binding var expand: Bool
    @State private var lastDragValue: CGFloat = 0
    var shapeTransition: Namespace.ID
    
    var paddingContent: EdgeInsets {
        return expand ? EdgeInsets.init() : EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
    }
    
    var body: some View {
        SubHeaderLabel(expand: $expand, shapeTransition: shapeTransition)
            .matchedGeometryEffect(id: "subheaderchild1", in: shapeTransition)
        RoundedRectangle(cornerRadius: 30)
            .frame(height: expand ? nil : 250)
            .matchedGeometryEffect(id: "shape2", in: shapeTransition)
            .foregroundColor(Color(.orange))
            .padding(paddingContent)
            .overlay(
                VStack {
                    VStack {
                        Divider()
                            .frame(height: 5)
                            .frame(maxWidth: 40)
                            .matchedGeometryEffect(id: "divider", in: shapeTransition)
                            .background(Color(.white).matchedGeometryEffect(id: "colordivider2", in: shapeTransition))
                            .cornerRadius(3)
                            
                    }
                    .frame(height: 50)
                    .matchedGeometryEffect(id: "divider2", in: shapeTransition)
                    .background(Color(.red).matchedGeometryEffect(id: "colordivider3", in: shapeTransition))
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                // Track the drag translation
                                let dragTranslation = value.translation.height
                                
                                // If dragging up (negative translation), prepare to expand
                                if dragTranslation < -50 && !expand {
                                    withAnimation(.bouncy(duration: 0.4)) {
                                        expand = true
                                    }
                                }
                                
                                // If dragging down (positive translation), prepare to collapse
                                if dragTranslation > 50 && expand {
                                    withAnimation(.bouncy(duration: 0.4)) {
                                        expand = false
                                    }
                                }
                            }
                    )
                    
                    
                    ContentBody(shapeTransition: shapeTransition)
                        .matchedGeometryEffect(id: "content", in: shapeTransition)
                        .padding(paddingContent)
                }
                .matchedGeometryEffect(id: "shape3", in: shapeTransition)
            )
            .onTapGesture {
                withAnimation(.bouncy(duration: 0.8)) {
                    expand.toggle()
                }
            }
    }
}

#Preview {
    Example13View()
}

struct HeaderLabel: View {
    var shapeTransition: Namespace.ID
    var body: some View {
        Text("Header")
            .font(.largeTitle)
            .fontWeight(.bold)
            .matchedGeometryEffect(id: "header", in: shapeTransition)
            .padding(.leading, 20)
            .padding(.trailing, 20)
    }
}

struct SubHeaderLabel: View {
    @Binding var expand: Bool
    var shapeTransition: Namespace.ID
    var body: some View {
        Text("Sub Header")
            .font(expand ? .title3 : .title)
            .fontWeight(.bold)
            .frame(maxWidth: .infinity, alignment: .leading)
            .animation(.bouncy(duration: 0.6), value: expand)
            .matchedGeometryEffect(id: "subheaderchild2", in: shapeTransition)
            .padding(.leading, 20)
            .padding(.trailing, 20)
    }
}

struct BottomTabView: View {
    var shapeTransition: Namespace.ID
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 20)
                .frame(width: 200, height: 50)
                .foregroundColor(Color(.orange))
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                .overlay {
                    HStack(alignment: .center, spacing: 20) {
                        Button(action: {}) {
                            Image(systemName: "house.fill")
                                .foregroundColor(.white)
                                .font(.headline)
                        }
                        Button(action: {}) {
                            Image(systemName: "document.fill")
                                .foregroundColor(.white)
                                .font(.headline)
                        }
                    }
                    .matchedGeometryEffect(id: "BottomTabView_inner2", in: shapeTransition)
                }
            Rectangle().frame(height: 10).foregroundStyle(Color(.clear))
        }
        .matchedGeometryEffect(id: "BottomTabView_inner1", in: shapeTransition)
    }
}

struct Example13View4: View {
    @State private var viewHeight: CGFloat = 250
    @State private var viewWidth: CGFloat = UIScreen.main.bounds.width - 40
    @State private var isExpanded: Bool = false
    @State private var bottomTabOpacity: Double = 1.0
    @State private var isDrag: Bool = false
    private let minHeight: CGFloat = 250
    private let minWidth: CGFloat = UIScreen.main.bounds.width - 40
    private let maxWidth: CGFloat = UIScreen.main.bounds.width
    private let maxVelocity: CGFloat = 1800
    private let threshold: CGFloat = 1

    var body: some View {
        GeometryReader { geometry in
            let maxHeight = geometry.size.height // Dapatkan tinggi layar secara dinamis
            
            VStack {
                Spacer()
                Text("Subtitle")
                VStack {
                    Rectangle()
                        .frame(height: 50)
                        .overlay(
                            Divider()
                                .frame(width: 40, height: 4)
                                .background(Color.gray)
                                .cornerRadius(2)
                        )
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    isDrag = true
                                    let newHeight = viewHeight - value.translation.height
                                                                       
                                    // Ubah opacity BottomTabView saat drag ke atas/bawah
                                    let progress = (newHeight - minHeight) / (maxHeight - minHeight)
                                    bottomTabOpacity = max(0, 1 - progress)
                                    
                                    // **Batasi agar tidak lebih dari minHeight dan maxHeight**
                                    if newHeight < minHeight {
                                        viewHeight = minHeight
                                    } else if newHeight > maxHeight {
                                        viewHeight = maxHeight
                                    } else {
                                        viewHeight = newHeight
                                        
                                        // Perubahan width bertahap saat drag
                                        let heightRatio = (viewHeight - minHeight) / (maxHeight - minHeight)
                                        viewWidth = minWidth + (maxWidth - minWidth) * heightRatio
                                    }
                                }
                                .onEnded { value in
                                    isDrag = false
                                    if abs(value.velocity.height) > maxVelocity {
                                        isExpanded.toggle()
                                        viewHeight = isExpanded ? .infinity : minHeight
                                        viewWidth = isExpanded ? maxWidth : minWidth
                                        bottomTabOpacity = isExpanded ? 0 : 1
                                        return // **Abaikan flick cepat**
                                    }
                                    withAnimation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0)) {
//                                    withAnimation(.bouncy(duration: 0.5, extraBounce: 0)) {
                                        if value.translation.height < 0 {
                                            isExpanded = true  // Drag ke atas → Expand
                                        } else if value.translation.height > 0 {
                                            isExpanded = false // Drag ke bawah → Minimize
                                        }
                                        viewHeight = isExpanded ? maxHeight : minHeight
                                        viewWidth = isExpanded ? maxWidth : minWidth
                                        bottomTabOpacity = isExpanded ? 0 : 1
                                    }
                                }
                        )

                    Text("Expandable Content")
                        .frame(maxWidth: .infinity)
                        .padding()
                    Spacer()
                }
                .frame(width: viewWidth, height: viewHeight)
                .background(Color.blue.opacity(0.3))
                .cornerRadius(16)
                .onTapGesture {
                    withAnimation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0)) {
                        isExpanded.toggle()
                        viewHeight = isExpanded ? maxHeight : minHeight
                        viewWidth = isExpanded ? maxWidth : minWidth
                        bottomTabOpacity = isExpanded ? 0 : 1
                    }
                }
                .frame(maxWidth: .infinity, alignment: .center) // Pastikan tetap di tengah

                if !isExpanded {
//                    BottomTabView()
//                        .opacity(bottomTabOpacity)
//                        .animation(.easeInOut(duration: 0.3), value: bottomTabOpacity)
                }
            }
            .frame(maxWidth: .infinity, alignment: .center) // Pastikan tetap di tengah
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}

struct Example13View3: View {
    @State private var viewHeight: CGFloat = 250
    @State private var isExpanded: Bool = false
    private let minHeight: CGFloat = 250
    private let maxHeight: CGFloat = UIScreen.main.bounds.height * 0.8
    private let threshold: CGFloat = 0

    var body: some View {
        VStack {
            Spacer()
            
            VStack {
                Rectangle()
                    .fill()
                    .frame(height: 40)
                    .overlay(
                        Divider()
                            .frame(height: 4)
                            .background(Color.gray)
                            .cornerRadius(2)
                    )
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                let newHeight = ( viewHeight - value.translation.height) + 10
                                if newHeight >= minHeight && newHeight <= maxHeight {
                                    viewHeight = newHeight
                                }
                            }
                            .onEnded { value in
                                let dragAmount = abs(value.translation.height)
                                if dragAmount > threshold {
                                    withAnimation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0)) {
                                        isExpanded.toggle()
                                        viewHeight = isExpanded ? maxHeight : minHeight
                                    }
                                }
                            }
                    )
                
                Text("Expandable Content")
                    .frame(maxWidth: .infinity)
                    .padding()
                Spacer()
            }
            .frame(height: viewHeight)
            .frame(maxWidth: .infinity)
            .background(Color.blue.opacity(0.3))
            .cornerRadius(16)
            .onTapGesture {
                withAnimation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0)) {
                    isExpanded.toggle()
                    viewHeight = isExpanded ? maxHeight : minHeight
                }
            }
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}
