//
//  widget_podcasts.swift
//  widget podcasts
//
//  Created by ahmed nader on 12/12/2022.
//

import WidgetKit
import SwiftUI
import Intents

let test_podcast_imgae = "k :)"

struct Provider: IntentTimelineProvider {
    
    // A placeholder view displays a generic representation of your widget
    func placeholder(in context: Context) -> SimpleEntry {
        let preview_podcast = podcast(name: "podcast name", imageByteData: test_podcast_imgae)

         return SimpleEntry(date: Date(),current_podcast:preview_podcast)
    }
    
    
    // return a “timeline” entry with dummy data. It is used to render the previews in the widget gallery
    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let preview_podcast = podcast(name: "podcast name", imageByteData: test_podcast_imgae)

         let entry = SimpleEntry(date: Date(),current_podcast:preview_podcast)
         completion(entry)
    }
    
    
    // With this method you can create an array of timeline entries with the current datetime and if needed also entries in the future.
    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []
        
        let sharedDefaults = UserDefaults.init(suiteName: "group.com.nader")
        var flutterData: podcast? = nil

        if(sharedDefaults != nil) {
            do {
              let shared = sharedDefaults?.string(forKey: "widgetData")
              if(shared != nil){
                let decoder = JSONDecoder()
                flutterData = try decoder.decode(podcast.self, from: shared!.data(using: .utf8)!)
              }
            } catch {
              print(error)
            }
        }

        let currentDate = Date()
        let entry = SimpleEntry(date: currentDate,current_podcast: flutterData!)
        entries.append(entry)

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let current_podcast : podcast
}

struct podcast : Decodable{
    let name : String
    let imageByteData : String
}

// is responsible for rendering the Widget with SwiftUI. entry is of type SimpleEntry
struct widget_podcastsEntryView : View {
    var entry: Provider.Entry
    
    private var podcastimage: some UIImage {
        guard let newImage = UIImage(data:Data(base64Encoded: entry.current_podcast.imageByteData)!)
        else {
                return  UIImage(named: "podcast_basic")!
            }
        return newImage
        }

    var body: some View {
        
        VStack{
            Image(uiImage: podcastimage)
        }
    }
}

// allows you to set the kind and some other configurations like display name and description
struct widget_podcasts: Widget {
    let kind: String = "widget_podcasts"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            widget_podcastsEntryView(entry: entry)
        }
        .supportedFamilies([.systemMedium])
        .configurationDisplayName("continue listening")
        .description("pick where you left off")
    }
}

// responsible for the Widget Gallery / Preview Canvas
struct widget_podcasts_Previews: PreviewProvider {
    static var previews: some View {
        let preview_podcast = podcast(name: "podcast name", imageByteData: test_podcast_imgae)
        widget_podcastsEntryView(entry: SimpleEntry(date: Date(),current_podcast:preview_podcast))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
