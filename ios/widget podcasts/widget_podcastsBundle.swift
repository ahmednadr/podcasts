//
//  widget_podcastsBundle.swift
//  widget podcasts
//
//  Created by ahmed nader on 12/12/2022.
//

import WidgetKit
import SwiftUI

@main
struct widget_podcastsBundle: WidgetBundle {
    var body: some Widget {
        widget_podcasts()
        widget_podcastsLiveActivity()
    }
}
