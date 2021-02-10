from chatterbot import ChatBot
from chatterbot.trainers import ListTrainer
from tkinter import *
import pyttsx3 as pp
import speech_recognition as s
import threading

engine = pp.init()

voices = engine.getProperty('voices')
print(voices)
engine.setProperty('voice', voices[0].id)


def speak(word):
    engine.say(word)
    engine.runAndWait()


bot = ChatBot("My bot")
convo=[
     "Hi",
    "Hello what can i do for you?",
    "Can you tell your name?",
    "My name is bot and i made by Ananya in 2020   what is your name?",
    "Okay",
    "How are you?",
    "I am doing great these days",
 ]

trainer = ListTrainer(bot)

# now training the bot with the help of trainer
trainer.train(convo)
# answer=bot.get_response("what is your name?")
# print(answer)

# print("Talk to Bot")
# while True:
#    query=input()
#   if query=='exit':
# break
#    answer=bot.get_response(query)
#   print("Bot : ",answer)

main = Tk()
main.geometry("500x630")
main.title("My Chat Bot")
img = PhotoImage(file='bot1.png')
photoL = Label(main, image=img)
photoL.pack(pady=5)

# take query : it take audio as input from user and convert it to string


def takequery():
    sr = s.Recognizer()
    sr.pause_threshold = 1
    print("your bot is listening try to speak")
    with s.Microphone() as m:
        try:
            audio = sr.listen(m)
            query = sr.recognize_google(audio, language='eng-in')
            print(query)
            textF.delete(0, END)
            textF.insert(0, query)
            ask_from_bot()
        except Exception as e:
            print(e)
            print("not recorgnized")

def ask_from_bot():
    query = textF.get()
    answer_from_bot = bot.get_response(query)
    message.insert(END, "You : " + query)
    print(type(answer_from_bot))
    message.insert(END, "Bot : " + str(answer_from_bot))
    speak(answer_from_bot)
    textF.delete(0, END)
    message.yview(END)


frame = Frame(main)

sc = Scrollbar(frame)
message = Listbox(frame, width=220, height=20, bg='black', fg='white', yscrollcommand=sc.set)
sc.pack(side=RIGHT, fill=Y)
message.pack(side=LEFT, fill=BOTH, pady=5)


frame.pack()

# creating text field

textF = Entry(main, font=("Verdana", 20), bg='black', fg='white')
textF.pack(fill=X, pady=10)
btn = Button(main, text="Ask from Bot", font=("Verdana", 20), command=ask_from_bot)
btn.pack()

# creating a function
def enter_function(event):
    btn.invoke()
# going to bind main window with enter key...
main.bind('<Return>', enter_function)

def repeat():
    while True:
        takequery()

t = threading.Thread(target=repeat)
t.start()


main.mainloop()
