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

    // MARK: Animation Properties
    @State var showBreatheView: Bool = false
    @State var startAnimating: Bool = false

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
            .opacity(showBreatheView ? 0 : 1)

            GeometryReader { proxy in
                let size = proxy.size

                VStack {
                    BreatheView(size: size)

                    Text("Breathe to reduce")
                        .font(.title3)
                        .foregroundColor(.white)
                        .opacity(showBreatheView ? 0 : 1)


                    // 3つのoptionボタンエリア
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
                    .opacity(showBreatheView ? 0 : 1)

                    // STARTボタン
                    Button(action: startBreathing) {
                        Text(showBreatheView ? "Finish Breathe" : "START")
                            .fontWeight(.semibold)
                            .foregroundColor(showBreatheView ? Color.white.opacity(0.6) : Color.black)
                            .padding(.vertical, 15)
                            .frame(maxWidth: .infinity)
                            .background {
                                if showBreatheView {
                                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                                        .stroke(Color.white.opacity(0.6))
                                } else {
                                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                                        .fill(currentType.color.gradient)
                                }

                            }
                    }
                    .padding()

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
                    // startAnimationの場合、
                    // offset = 0にすることで、75ずつずらした丸がみんな真ん中に集まってピッタリかなさる
                    .offset(x: startAnimating ? 0 : 75)
                    // Circleのtangentを基準に 45角度で 8個を回す
                    .rotationEffect(.init(degrees: Double(index) * 45))
                    // startingAnimationの場合
                    // degree -45にすることで 反時計回りの 45度移動（３時 -> 12時）
                    .rotationEffect(.init(degrees: startAnimating ? -45 : 0))
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

    // MARK: Breathing Action
    func startBreathing() {
        withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)) {
            showBreatheView.toggle()
        }

        if showBreatheView {
            // delay 0.1後、3秒間 startAnimating を参照しているところは animationされる
            withAnimation(.easeInOut(duration: 3).delay(0.1)) {
                startAnimating = true
            }
        } else {

        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
