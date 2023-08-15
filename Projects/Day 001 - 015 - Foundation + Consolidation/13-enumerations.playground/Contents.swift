// MARK: 13. Enumerations

import UIKit

func getHatersStatus(weather: String) -> String? {
    if weather == "sunny" {
        return nil
    } else {
        return "Hate"
    }
}
// if someone types a weather incorrect (i.e Sunny instead of sunny) it would not work.
// This is why we have enums, so we can give swift some possibilities to work with instead of acceting any string:

enum WeatherType {
    case sun, cloud, rain, wind, snow
}

func getHatersStatus2(weather: WeatherType) -> String? { // we have to give a case from enum instead of typing any string
    if weather == WeatherType.sun {  // WeatherType.sun (enum . case)
        return nil
    } else {
        return "Hate"
    }
}

getHatersStatus2(weather: WeatherType.cloud)

// writing the code in a better way:

enum WeatherType2 {
    case sun
    case cloud
    case rain
    case wind
    case snow // one case per line
}

func getHatersStatus3(weather: WeatherType2) -> String? {
    if weather == .sun {  // .sun only
        return nil
    } else {
        return "Hate"
    }
}

// rewrite again using switch cases:

func getHatersStatus4(weather: WeatherType2) -> String? {
    switch weather {
    case .sun:
        return nil
    case .cloud, .wind:
        return "dislike"
    case .rain:
        return "Hate"
    default:
        return "error"
    }
}

getHatersStatus4(weather: WeatherType2.snow)


// MARK: Enums with additional values
// Enums can have values attached

enum WeatherType3 {
    case sun
    case cloud
    case rain
    case wind(speed: Int) // adding a value to the .wind case so that we can say how fast the wind is
    case snow
}

func getHatersStatus4(weather: WeatherType3) -> String? {
    switch weather {
    case .sun:
        return nil
    case .wind(let speed) where speed < 10:
        return "meh"
    case .cloud, .wind: //all other wind values that are not < 10. // it's important the order of the cases, if this is before the speed one, it will execute first and any speed will fall into this case.
        return "dislike"
    case .rain, .snow:
        return "Hate"
    }
}
