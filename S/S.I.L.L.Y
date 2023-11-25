import pyttsx3
import speech_recognition as sr
import datetime
import pywhatkit
import wikipedia
import pyautogui
import pyjokes

engine = pyttsx3.init('sapi5')
voices = engine.getProperty('voices')
engine.setProperty('voices', voices[0].id)


def speak(audio):
    engine.say(audio)
    engine.runAndWait()


def command():
    r = sr.Recognizer()
    with sr.Microphone() as source:
        print("Listening...")
        r.pause_threshold = 1
        r.adjust_for_ambient_noise(source, duration=1)
        audio = r.listen(source)

    try:
        print("Recognizing...")
        query = r.recognize_google(audio, language="en-in")
        print(f"You Just Said: {query}\n")
    except Exception as e:
        print(e)
        speak("Please speak again...")
        query = "none"
    return query

#creating a function to wish you    
def wishing():
    hour = int(datetime.datetime.now().hour)
    if hour >= 0 and hour < 12:
        print("Good Morning Sir, How can I help you!")
        speak("Good Morning Sir, How can I help you!")
    elif hour >= 12 and hour < 17:
        print("Good Afternoon Sir, How can I help you!")
        speak("Good Afternoon Sir, How can I help you!")
    elif hour >= 17 and hour < 21:
        print("Good Evening Sir, How can I help you!")
        speak("Good Evening Sir, How can I help you!")
    else:
        print("Good Night Sir, How can I help you!")
        speak("Good Night Sir, How can I help you!")


wishing()
query = command().lower()

#speak the keyword to activate the assistant 
if 'time' in query:
    strTime = datetime.datetime.now().strftime("%H:%M")
    print(strTime)
    speak(f"Sir the time is {strTime}")

elif 'play' in query:
    song = query.replace('play', '')
    speak("playing" + song)
    pywhatkit.playonyt(song)

elif 'wikipedia' in query:
    speak("Searching in WikiPedia...")
    try:
        query = query.replace("wikipedia", "")
        results = wikipedia.summary(query, sentences=4)
        speak("According to Wikipedia...")
        print(results)
        speak(results)
    except:
        speak("No results found..")
        print("No results found..")
elif 'type' in query:
    speak("writing sir")
    while True:
        writeInNotepad = command()
        if writeInNotepad == 'exit typing':
            speak('Done sir')
        else:
            pyautogui.write(writeInNotepad)
elif 'joke' in query:
    joke = pyjokes.get_joke()
    print(joke)
    speak(joke)

elif 'exit program' in query:
    speak("I am leaving Sir, Bye!")
    quit()
   



