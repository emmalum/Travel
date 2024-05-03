//
//  DateFormatter.swift
//  Travel
//
//  Created by Emma Lum on 3/5/2024.
//


import Foundation

extension DateFormatter {
    var currentDate: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        return formatter
    }
    
    var currentTime: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "HHmm"
        return formatter
    }
    
    var returnedTime: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return formatter
    }
    
    var displayedDate: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter
    }
    
    var displayTime: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm"
        return formatter
    }
}
