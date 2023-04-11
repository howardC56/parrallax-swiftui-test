//
//  home.swift
//  3d parallax card swiftui
//
//  Created by Howard Chang on 4/10/23.
//

import SwiftUI

struct Home: View {
    @State var offset: CGSize = .zero
    var body: some View {
        GeometryReader{
            let size = $0.size
            let imageSize = size.width * 0.7
            VStack{
                Image("aj1")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: imageSize)
                    .rotationEffect(Angle(degrees: -30))
                    .zIndex(1)
                    .offset(x: -20, y: -20)
                    .offset(x: offset2Angle().degrees * 5, y: offset2Angle(true).degrees * 5)
                Text("NIKE")
                    .font(.system(size: 60))
                    .fontWeight(.bold)
                    .padding(.top, -70)
                    .padding(.bottom, 55)
                    .zIndex(0)
                VStack(alignment: .leading, spacing: 10) {
                    Text("NUMBER")
                        .font(.callout)
                        .fontWeight(.semibold)
                        .fontWidth(.compressed)
                    HStack {
                        BlendedText("9999999999")
                        Spacer(minLength: 0)
                        BlendedText("123")
                    }
                    
                    HStack {
                        BlendedText("01/25")
                        Spacer(minLength: 0)
                        Button {
                            
                        } label: {
                            Text("New Number")
                                .fontWeight(.bold)
                                .foregroundColor(.blue)
                                .padding(.vertical, 12)
                                .padding(.horizontal, 15)
                                .background {
                                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                                        .fill(.white)
                                        .brightness(-0.1)
                                }
                        }
                    }
                    .padding(.top, 14)
                    VStack {
                        BlendedText("Synchrony")
                            .font(.footnote)
                            //.fontWeight(.normal)
                            .fontWidth(.compressed)
                            .frame(height: 35)
                            .frame(maxWidth: .infinity)
                            .padding(.bottom, 10)
                        
                    }
                }
                .frame(maxWidth: .infinity,alignment: .leading)
            }
            .foregroundColor(.white)
            .padding(.top, 65)
            .padding(.horizontal, 15)
            .frame(width: imageSize)
            .background(content: {
                ZStack(alignment: .topTrailing) {
                    Rectangle()
                        .fill(Color(.purple))
                    Circle()
                        .fill(Color(.red))
                        .frame(width: imageSize, height: imageSize)
                        .scaleEffect(1.2, anchor: .leading)
                        .offset(x: imageSize * 0.3, y:  -imageSize * 0.1)
                }
                .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
            })
            .scaleEffect(0.9)
            .rotation3DEffect(offset2Angle(true), axis: (x: -1, y: 0, z: 0))
            .rotation3DEffect(offset2Angle(), axis: (x: 0, y: 1, z: 0))
            .rotation3DEffect(offset2Angle(true) * 0.1, axis: (x: 0, y: 0, z: 1))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .contentShape(Rectangle())
            .gesture(
                DragGesture()
                    .onChanged({ value in
                        offset = value.translation
                    }).onEnded({ _ in
                        withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.32, blendDuration: 0.32)) {
                            offset = .zero
                        }
                    })
            )
        }
    }
    
    func offset2Angle(_ isVertical: Bool = false) -> Angle {
        let progress = (isVertical ? offset.height : offset.width) / (isVertical ? screenSize.height : screenSize.width)
        return .init(degrees: progress * 10)
    }
    
    var screenSize: CGSize = {
        guard let window = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .zero
        }
        return window.screen.bounds.size
    }()
    
    @ViewBuilder
    func BlendedText(_ text: String) -> some View {
        Text(text)
            .font(.title3)
            .fontWeight(.semibold)
            .fontWidth(.condensed)
            .blendMode(.difference)
    }
}

struct home_previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
