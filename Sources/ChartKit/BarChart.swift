//
//  File.swift
//  
//
//  Created by Atulya Weise on 1/11/22.
//

import Foundation
import SwiftUI

@available(iOS 14.0, *)
public struct BarChart<ItemType: BarVisualizable>: View {
    public init(data: [ItemType], xLabel: String? = nil, yLabel: String? = nil, xScale: Scale, accentColor: Color? = nil) {
        self.data = data
        self.xLabel = xLabel
        self.yLabel = yLabel
        self.xRange = (data.max{$0.numericX() < $1.numericX()}?.numericX() ?? 0) - (data.min{$0.numericX() < $1.numericX()}?.numericX() ?? 0)
//        self.xRange = 1
        self.yRange = (data.max{$0.numericY() < $1.numericY()}?.numericY() ?? 0) - (data.min{$0.numericY() < $1.numericY()}?.numericY() ?? 0)
        self.xScale = xScale
        self.barWidth = 0
        self.data = self.data.sorted(by: {$0.numericX() < $1.numericX()})
        self.accentColor = accentColor
    }
    
    var data: [ItemType]
    @State var barWidth: CGFloat
    var xLabel: String?
    var yLabel: String?
    var accentColor: Color?
    
    private var xRange: Double
    private var yRange: Double
    private var xScale: Scale
    
    public var body: some View {
        VStack {
            HStack {
                if let yLabel = yLabel {
                    VStack {
                        Text(yLabel)
                            .rotationEffect(.degrees(-90))
                            .fixedSize()
                            .frame(width: 20)
                    }
                }
                GeometryReader { g in
                    ZStack {
                        ForEach(Array(data.enumerated()), id: \.1.id) { (index, point) in
                            VStack(spacing: 0) {
                                Color.clear
                                    .frame(width: barWidth,
                                           height: (g.size.height-(point.numericY()-(data.min{$0.numericY() < $1.numericY()}!.numericY()))*(g.size.height)/yRange)-20)
    //                                .border(Color.black)
                                Spacer()
                                    .frame(width: barWidth)
                                    .background(accentColor ?? Color.yellow)
                                    .cornerRadius(10)
                                    .contextMenu {
                                        Text(point.label())
                                    }
                            }
                            .offset(x: computeHorizontalOffset(nx: point.numericX(), size: g.size, index: index))
                        }
                    }
                    .onAppear {
                        self.barWidth = computeIdealBarWidth(size: g.size)
                    }
                }
            }

            HStack {
                Spacer()
                if let xLabel = xLabel {
                    Text(xLabel)
                }
                Spacer()
            }
        }
    }
    
    func computeSpacing(size: CGSize) -> Int {
        var spacing = 10
        switch Int(size.width)/data.count {
        case 0...35:
            spacing = 3
        case 36...80:
            spacing = 10
        default:
            spacing = 20
        }
        return spacing
    }
    
    func computeHorizontalOffset(nx: Double, size: CGSize, index: Int) -> CGFloat {
        switch xScale {
        case .real:
            return (nx-(data.first!.numericX()))*(size.width-50)/xRange
        case .pretty:
            return CGFloat(index*Int(size.width+CGFloat(computeSpacing(size: size)))/(data.count))
        }
    }
    
    func computeIdealBarWidth(size: CGSize) -> CGFloat {
        let spacing = computeSpacing(size: size)
        switch xScale {
        case .real:
            let offsets = Array(data
                                    .enumerated()
                                    .map{computeHorizontalOffset(nx: $1.numericX(), size: size, index: $0)}
            )
            
            var smallestDifferencePx = size.width
            
            if offsets.count >= 2 {
                for i in 1...offsets.count-1 {
                    if offsets[i] - offsets[i-1] < smallestDifferencePx {
                        smallestDifferencePx = offsets[i] - offsets[i-1]
                    }
                }
            }
                        
            return smallestDifferencePx-CGFloat(spacing)/2
        case .pretty:
            return CGFloat((Int(size.width)-(data.count-1)*spacing))/CGFloat(Float(data.count))
        }
    }
}
