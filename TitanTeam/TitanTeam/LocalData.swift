//
//  LocalData.swift
//  SaraP1
//
//  Created by Sara Ali Alahmadi on 02/04/1446 AH.
//

import SwiftUI


struct Intrist {
    static let SelfConfident = [
        "Believe in yourself and all that you are.",
        "Confidence is not ‘they will like me’, confidence is ‘I’ll be fine if they don’t’.",
        "The most beautiful thing you can wear is confidence.","believing in your abilities without needing validation from others","Don’t let inner doubts stop you from reaching your dreams","Remember, every day is a new opportunity to be better; seize every moment to achieve your goals","You deserve success and happiness; don’t let anything hold you back","Your abilities are unique; use them to pursue your dreams", "Mistakes are part of the journey; learn from them and grow", "You believe in yourself, and you know you can achieve what you want"
    ]
    
    static let Study = [
        "Education is the most powerful weapon you can use to change the world.",
        "The more that you read, the more things you will know.",
        "Success is no accident. It is hard work, perseverance, learning, studying, sacrifice, and most of all, love of what you are doing.", "Knowledge is the key that opens the doors to your future; invest in your studies today", "Every hour you study brings you one step closer to achieving your dreams, so don’t hesitate!", "Every hour you study brings you one step closer to achieving your dreams, so don’t hesitate!", "Learning is the best investment you can make; it benefits you today and opens new horizons for tomorrow", "Don’t focus on the difficulties; think about the accomplishments that will follow your success", "Every effort you put in today is a step toward a better tomorrow; keep pushing forward", "Never underestimate any study session; even small details can make a big difference", "Be passionate about what you learn; that passion will lead you to success",
    ]
    
    static let Success = [
        "Success is not final, failure is not fatal: It is the courage to continue that counts.",
        "Success is not the key to happiness. Happiness is the key to success.",
        "Don’t be afraid to give up the good to go for the great.", "Success is the result of perseverance and dedication; never give up", "Every small step toward your goal is a step in the right direction; keep moving forward","Remember that failure is part of success; don’t be afraid to try again","If you believe in yourself, you can achieve anything; just set your goal and work toward it","Challenges are opportunities in disguise; use them to become stronger and more experienced","Don’t compare yourself to others; success is your personal journey—create your own path","Successful people don’t just dream; they work hard to make their dreams come true"
    ]
    
    static let Proverbs = [
        "Actions speak louder than words.",
        "A journey of a thousand miles begins with a single step.",
        "The early bird catches the worm.", "Whoever seeks greatness must stay up late", "A believer is not stung twice from the same hole", "He who works hard will find success, and he who plants will harvest", "Opportunities come to those who seek them, not to those who wait", "Don’t be afraid of change; it’s the first step toward success", "Be like the palm tree, elevated and capable of giving fruit", "Dreams don’t come true by waiting; they come true by working"
    ]
    
    static let Funny = [
        "I’m on a seafood diet. I see food and I eat it.",
        "Why don’t skeletons fight each other? They don’t have the guts.",
        "I told my wife she was drawing her eyebrows too high. She looked surprised."
    ]
    
    static let Life = [
        "Life is 10% what happens to us and 90% how we react to it.",
        "To live is the rarest thing in the world. Most people exist, that is all.",
        "In the end, we only regret the chances we didn’t take.", "Every day is a new opportunity for change and improvement", "Embrace change, as life is always changing, and adaptability is the key to success", "Learn to be happy with what you have while you strive for what you want", "Smile at life, and it will smile back at you", "Don’t wait for opportunities; create them yourself", "Life isn’t always perfect, but it requires us to accept it as it is", "The little things in life are what bring true happiness"
    ]
}


func getRandomSentence(from topic: String) -> String {
    switch topic {
    case "SelfConfident":
        return Intrist.SelfConfident.randomElement() ?? ""
    case "Study":
        return Intrist.Study.randomElement() ?? ""
    case "Success":
        return Intrist.Success.randomElement() ?? ""
    case "Proverbs":
        return Intrist.Proverbs.randomElement() ?? ""
    case "Funny":
        return Intrist.Funny.randomElement() ?? ""
    case "Life":
        return Intrist.Life.randomElement() ?? ""
    default:
        return "No sentence found."
    }
}



//"You don’t need others' approval to be successful; your confidence comes from within", "Accept yourself as you are, and work on improving yourself every day", "Every small step you take brings you closer to your dreams; be proud of every accomplishment

//Remember that every challenge you face in your studies is an opportunity for growth and development
//You are capable of achieving your academic goals; just believe in yourself and start working!
//Don’t hesitate to ask for help when you need it; collaborating with others can be the key to your success


//Be determined to succeed, and you will find the path to achieving your dreams
//You have the power to change your life; start today!
//Trust your abilities and don’t let any obstacle stop you; you are capable of achieving success


//Success comes to those who don’t wait but take action.
//If you never make mistakes, you’ll never learn anything new
//The time you invest today shapes your tomorrow


//فيه مصنع قهوة انفجر قال بوننن
//فيه نملة رافعه حواجبها ليه؟ امها شادتلها شعرها
//فيه نقطة زرقاء ع الجدار ايش؟ نملة لابسة جينز
//فيه نمل متجمعين على غطاء مويا ليه؟ مستأجرين شاليه
//فيه وحش اكل تونا صار وحشتونا
//فيه بطاطس وبرجر يجرون ليه؟ وجبات سريعة

