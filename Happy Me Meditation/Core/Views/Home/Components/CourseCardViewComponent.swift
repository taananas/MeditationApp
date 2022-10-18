//
//  CardViewComponent.swift
//  Happy Me Meditation
//
//  Created by Bogdan Zykov on 14.08.2022.
//

import SwiftUI


struct CourseCardViewComponent: View {
    var course: Course?
    var isFullSize: Bool = false
    private var isDailyCourse: Bool{
        course?.isDaily ?? false
    }
    private var isNewCourse: Bool{
        course?.isNew ?? false
    }
    var body: some View {
        
        ZStack(alignment: .topLeading){
            image
            textContentSection
        }
        .frame(width:  (isFullSize || isDailyCourse) ? (getRect().width - 32)  : (getRect().width / 1.2))
        .frame(height: (isFullSize || isDailyCourse) ? 133 : 160)
        .cornerRadius(20)
    }
}

struct CourseCardViewComponent_Previews: PreviewProvider {
    static var previews: some View {
        Button {
            
        } label: {
            CourseCardViewComponent(course: MockData.course)
        }
        .padding()
    }
}

extension CourseCardViewComponent{
    private var image: some View{
        ZStack{
            if let image = course?.courseImageUrl{
                CustomLazyImage(strUrl: image)
            }
            LinearGradient(colors: [.black.opacity(0.4), .clear], startPoint: .leading, endPoint: .trailing)
        }
    }
    
    private var textContentSection: some View{

        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(course?.title ?? "")
                    .font(.title3)
                .fontWeight(.bold)
                .hLeading()
                Spacer()
                if isNewCourse{
                    newLabel
                }
            }
            Text(course?.subtitle ?? "")
                .font(.urbMedium(size: 12))
                .multilineTextAlignment(.leading)
                .frame(maxWidth: 200, alignment: .leading)
            Spacer()
            Group{
                if isDailyCourse{
                    Text(course?.date ?? "")
                        .padding(.bottom, 10)
                }else{
                    Text("Duration: \(course?.courseDuration ?? 0) days | ~ \((course?.duration ?? 0).secondsToMin())")
                        .padding(.top, 10)
                        
                }
            }
            .font(.urbMedium(size: 12))
            .foregroundColor(.fontSecondary.opacity(0.6))
            
        }
        .padding(.bottom, isFullSize ? 20 : 0)
        .padding(.top, 20)
        .padding(.leading, 16)
        .foregroundColor(.white)
        .fixedSize(horizontal: false, vertical: true)
    }
    
    private var newLabel: some View{
        Text("New")
            .font(.subheadline)
            .fontWeight(.bold)
            .foregroundColor(.secondaryGreen)
            .padding(5)
            .background(Color.white)
            .cornerRadius(5)
            .padding(.trailing, 16)
    }
}

extension Int {
    func secondsToMin() -> String {
        let min = ((self % 3600) / 60)
        return "\(min) m"
    }
}



