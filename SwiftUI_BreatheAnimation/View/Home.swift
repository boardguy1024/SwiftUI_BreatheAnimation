//
//  Home.swift
//  SwiftUI_BreatheAnimation
//
//  Created by パク on 2023/03/15.
//

import SwiftUI

struct Home: View {

    @State var currentType: BreatheType = sampleTypes[0]

    @Namespace var animation

    var body: some View {
        ZStack {
            Background()
            Content()
        }
    }

    // Main Content
    @ViewBuilder
    func Content() -> some View {
        VStack {

            // Header..
            HStack {
                Text("Breathe")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)

                Button {

                } label: {
                    Image(systemName: "suit.heart")
                        .font(.title2)
                        .foregroundColor(.white)
                        .frame(width: 42, height: 42)
                        .background {
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(.ultraThinMaterial)
                        }
                }

            }
            .padding()


            GeometryReader { proxy in
                let size = proxy.size

                VStack {
                    BreatheView(size: size)

                    Text("Breathe to reduce")
                        .font(.title3)
                        .foregroundColor(.white)


                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            ForEach(sampleTypes) { type in
                                Text(type.title)
                                    .foregroundColor(currentType.id == type.id ? .black : .white)
                                    .padding(.vertical)
                                    .padding(.horizontal, 15)
                                    .background {
                                        // MARK: Matched Geometry Effect
                                        ZStack {
                                            if currentType.id == type.id {
                                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                                    .fill(.white)
                                                    .matchedGeometryEffect(id: "TAB", in: animation)
                                            } else {
                                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                                    .stroke(.white.opacity(0.5))
                                            }
                                        }
                                    }
                                    .onTapGesture {
                                        withAnimation {
                                            currentType = type
                                        }
                                    }
                            }
                        }
                        .frame(width: size.width, height: 60)
                    }
                }
                .frame(width: size.width, height: size.height, alignment: .bottom)
            }
        }
        .frame(maxHeight: .infinity, alignment: .top)
    }

    @ViewBuilder
    func BreatheView(size: CGSize) -> some View {

        ZStack {
            ForEach(1...8, id: \.self) { index in
                Circle()
                    .fill(currentType.color.gradient.opacity(0.5))
                    .frame(width: 150, height: 150)
                    // 150 / 2 = 75 （真ん中より75ずらすことで Circleの左が原点となる
                    .offset(x: 75)
                    // Circleのtangentを基準に 45角度で 8個を回す
                    .rotationEffect(.init(degrees: Double(index) * 45))
            }
        }
        .frame(height: size.width - 40)
    }


    @ViewBuilder
    func Background() -> some View {
        GeometryReader { proxy in
            let size = proxy.size
            Image("BG")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: size.width, height: size.height)
                .clipped()
                .offset(y: -50)
                .overlay {
                    ZStack {
                        // 上 2/3の色グラデー
                        // typeごとにテーマカラーのグラーションをかける
                        Rectangle()
                            .fill(.linearGradient(colors: [
                                currentType.color.opacity(0.9), .clear, .clear],
                                                  startPoint: .top, endPoint: .bottom))
                            .frame(height: size.height / 1.5) // グラデー高さを 2/3にして
                            .frame(maxHeight: .infinity, alignment: .top) // 上に位置させる

                        // 下の黒色
                        Rectangle()
                            .fill(.linearGradient(colors: [
                                .clear, .clear, .black, .black, .black],
                                                  startPoint: .top, endPoint: .bottom))
                            .frame(height: size.height / 1)
                            .frame(maxHeight: .infinity, alignment: .bottom) // 下に位置させる

                    }
                }
        }
        .ignoresSafeArea()
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
