//
//  EnrollmentInfoView.swift
//  QLOGA
//
//  Created by Dmitry Mikhailov on 3/4/22.
//

import SwiftUI

struct EnrollmentInfoView: View {
    var body: some View {
        Image("EnrollmentInfoView").resizable().aspectRatio(contentMode: .fit).frame(width: UIScreen.main.bounds.width, alignment: .center)
            .navigationBarTitleDisplayMode(.inline)
    }
}

struct EnrollmentInfoView_Previews: PreviewProvider {
    static var previews: some View {
        EnrollmentInfoView()
            .previewDevice("iPhone 6s")
    }
}
