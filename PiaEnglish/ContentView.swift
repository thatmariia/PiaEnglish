//
//  ContentView.swift
//  PiaEnglish
//
//  Created by Mariia Turchina on 25/05/2020.
//  Copyright © 2020 Mariia Turchina. All rights reserved.
//

import SwiftUI
import UserNotifications

struct ContentView: View {
    
    init() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                print("All set!")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }

    var body: some View {
        let notificationCenter = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        content.title = "Time to practice English, Pia 💜"
        content.body = "It will only take a couple of minutes"
        
        var dateComponents1 = DateComponents()
        var dateComponents2 = DateComponents()
        var dateComponents3 = DateComponents()
        dateComponents1.calendar = Calendar.current
        dateComponents2.calendar = Calendar.current
        dateComponents3.calendar = Calendar.current

        dateComponents1.hour = 20    // 20:00 hours
           
        // Create the trigger as a repeating event.
        let trigger1 = UNCalendarNotificationTrigger(
                 dateMatching: dateComponents1, repeats: true)
        let request1 = UNNotificationRequest(identifier: UUID().uuidString,
        content: content, trigger: trigger1)
        
        // Schedule the request with the system.
        notificationCenter.add(request1)
        
        dateComponents2.hour = 23
        
        let trigger2 = UNCalendarNotificationTrigger(
        dateMatching: dateComponents2, repeats: true)
        let request2 = UNNotificationRequest(identifier: UUID().uuidString,
        content: content, trigger: trigger2)
        
        notificationCenter.add(request2)
        
        dateComponents3.hour = 12
        
        let trigger3 = UNCalendarNotificationTrigger(
        dateMatching: dateComponents3, repeats: true)
        let request3 = UNNotificationRequest(identifier: UUID().uuidString,
        content: content, trigger: trigger3)
        
        notificationCenter.add(request3)
        
        
        return AppTabView().statusBar(hidden: true)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
