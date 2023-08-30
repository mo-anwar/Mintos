//
//  View.swift
//  Mintos
//
//  Created by Mohamed anwar on 30/08/2023.
//

import SwiftUI

extension View {
    @ViewBuilder func isHidden(_ hidden: Bool, remove: Bool = false) -> some View {
        if hidden {
            if !remove {
                self.hidden()
            }
        } else {
            self
        }
    }
}
