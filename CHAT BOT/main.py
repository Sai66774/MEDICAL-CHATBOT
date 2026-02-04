from io import StringIO

from kivymd.app import MDApp
from kivy.lang import Builder
from kivy.core.window import Window
from kivy.uix.screenmanager import ScreenManager, Screen
from kivy.animation import Animation
from kivy.properties import NumericProperty
from kivymd.uix.screen import MDScreen
from kivy.properties import StringProperty
from firebase import firebase
import speech_recognition as sr
from kivy.clock import Clock
from kivymd.uix.label import MDLabel
import profile
#import emergency

from kivy.core.text import LabelBase
k=1

#`````````````````````````````````````````````````````algo--------------------------------------------------------------

import pandas as pd
from sklearn.linear_model import SGDClassifier
import requests
train_url = 'https://raw.githubusercontent.com/aryanveturekar/Health-Care-Chat-Bot/master/Training.csv'
test_url = 'https://raw.githubusercontent.com/aryanveturekar/Health-Care-Chat-Bot/master/Testing.csv'

response = requests.get(train_url, verify=False)
data1 = response.content.decode('utf-8')
df_train = pd.read_csv(StringIO(data1))

response = requests.get(test_url, verify=False)
data1 = response.content.decode('utf-8')
df_test = pd.read_csv(StringIO(data1))

X = df_train.iloc[:, :-1]
y = df_train['prognosis']

sgd = SGDClassifier(loss='log_loss', penalty='l2', alpha=0.0001, max_iter=1000, random_state=42)
sgd.fit(X, y)

X_test = df_test.iloc[:, :-1]
y_test = df_test.iloc[:, -1]

test_acc = sgd.score(X_test, y_test)
print(f'Test accuracy: {test_acc:.2f}')
#------------------------------------------------------------------end algo-----------------------------------------------


Window.size = (450, 700)
screen_manager = ScreenManager()
firebase = firebase.FirebaseApplication("https://medicalchatbot-cdad3-default-rtdb.firebaseio.com/", None)
Name = ""
Phone = ""
City = ""
State = ""
Pin = ""
Password = ""
Username = ""
disease=""
class DribbleUI(MDScreen):
    animation_constant = NumericProperty(40)

    def __init__(self, **kw):
        super().__init__(**kw)
        anim = Animation(animation_constant=10, duration=.6, t='in_out_quad') + Animation(animation_constant=40, duration =.6, t='in_out_quad')
        anim.repeat = True
        anim.start(self)

class Create(MDScreen):
    def __init__(self, **kwargs):
        super(Create, self).__init__(**kwargs)

    def on_pre_enter(self, *args):
        self.ids.password.error = False
        self.ids.name.error = False
        self.ids.phone.error = False
        self.ids.city.error = False
        self.ids.state.error = False
        self.ids.pin.error = False
        self.ids.confirm_password.error = False
        self.ids.name.text = ""
        self.ids.phone.text = ""
        self.ids.city.text = ""
        self.ids.state.text = ""
        self.ids.pin.text = ""
        self.ids.password.text = ""
        self.ids.confirm_password.text = ""

    def validate_password(self, text):
        if self.ids.password.text != self.ids.confirm_password.text:
            self.ids.confirm_password.error = True
        else:
            self.ids.confirm_password.error = False

    def SendData(self, name, phone, city, state, pin, password):
        if name == '' or phone == '' or city == '' or state == '' or pin == '' or password == '':
            self.ids.password.error = True
            self.ids.name.error = True
            self.ids.phone.error = True
            self.ids.city.error = True
            self.ids.state.error = True
            self.ids.pin.error = True
            self.ids.confirm_password.error = True
        else:
            if len(phone) == 10:
                if len(password)>=8:
                    if name != '' and phone != '' and city != '' and state != '' and pin != '' and password != '':
                        data = {
                            'name': name,
                            'phone': phone,
                            'city': city,
                            'state': state,
                            'pin': pin,
                            'password': password
                        }
                        firebase.post('https://medicalchatbot-cdad3-default-rtdb.firebaseio.com/Users',data)
                        screen_manager.current = "login"
                else:
                    self.ids.password.error = True
                    self.ids.confirm_password.error = True
            else:
              #  self.ids.invisible.text = "Phone no length must be 10"
                self.ids.phone.error=True

class LogIn(MDScreen):
    def __init__(self, **kwargs):
        super(LogIn, self).__init__(**kwargs)

    def on_pre_enter(self, *args):
        self.ids.invisible.text = ""
        self.ids.text_field.error = False
        self.ids.phone.error = False

    def verify(self, phone, password):
        result = firebase.get('https://medicalchatbot-cdad3-default-rtdb.firebaseio.com/Users', '')
        print(result)
        for i in result.keys():
            if result[i]['phone'] == phone:
                if result[i]['password'] == password:
                    global Name, Phone, City, State, Pin, Password, Username
                    Name = result[i]['name']
                    Phone = result[i]['phone']
                    City = result[i]['city']
                    State = result[i]['state']
                    Pin = result[i]['pin']
                    Password = result[i]['password']
                    Username = i
                    screen_manager.current = "home"
                else:
                    self.ids.invisible.text = "password wrong"
                    self.ids.text_field.error = True
                    break;
            else:
                self.ids.invisible.text = "phone no not found or create a account"
                self.ids.phone.text = ""
                self.ids.text_field.text = ""
                self.ids.phone.error = True
                self.ids.text_field.error = True
class EditDetails(MDScreen):
    def __init__(self, **kwargs):
        super(EditDetails, self).__init__(**kwargs)

    def on_pre_enter(self, *args):
        self.ids.name.text = Name
        self.ids.phone.text = Phone
        self.ids.city.text = City
        self.ids.state.text = State
        self.ids.pin.text = Pin
        self.ids.password.text = Password
        self.ids.confirm_password.text = Password

    def validate_password(self, text):
        if self.ids.password.text != self.ids.confirm_password.text:
            self.ids.confirm_password.error = True
        else:
            self.ids.confirm_password.error = False

    def UpdateData(self, name, phone, city, state, pin, password):
        if password != '':
            global Name, Phone, City, State, Pin, Password, Username
            firebase.put('https://medicalchatbot-cdad3-default-rtdb.firebaseio.com/Users/' + Username, 'name', name)
            firebase.put('https://medicalchatbot-cdad3-default-rtdb.firebaseio.com/Users/' + Username, 'phone', phone)
            firebase.put('https://medicalchatbot-cdad3-default-rtdb.firebaseio.com/Users/' + Username, 'city', city)
            firebase.put('https://medicalchatbot-cdad3-default-rtdb.firebaseio.com/Users/' + Username, 'state', state)
            firebase.put('https://medicalchatbot-cdad3-default-rtdb.firebaseio.com/Users/' + Username, 'pin', pin)
            firebase.put('https://medicalchatbot-cdad3-default-rtdb.firebaseio.com/Users/' + Username, 'password', password)
            Name = name
            Phone = phone
            City = city
            State = state
            Pin = pin
            Password = password
            screen_manager.current = "home"

class HomePage(MDScreen):
    def __init__(self, **kwargs):
        super(HomePage, self).__init__(**kwargs)

    def on_pre_enter(self, *args):
        self.ids.name.text = Name.upper()
        self.ids.pin.text = Pin
        self.ids.phone.text = Phone

class ChatBotCommand(MDLabel):
    text = StringProperty()
    size_hint_x = NumericProperty()
    halign = StringProperty
    font_size = 17

    def __init__(self, **kwargs):
        super(ChatBotCommand, self).__init__(**kwargs)


class ChatBotResponse(MDLabel):
    text = StringProperty()
    size_hint_x = NumericProperty()
    halign = StringProperty
    font_size = 17
    def __init__(self, **kwargs):
        super(ChatBotResponse, self).__init__(**kwargs)


class CHATBOT(MDApp):
    @staticmethod
    def change_screen(name):
        screen_manager.current = name

    def build(self):
        global screen_manager
        screen_manager = ScreenManager()
        screen_manager.add_widget(Builder.load_file("appointment_home.kv"))
       # screen_manager.add_widget(Builder.load_file("emergency.kv"))
        screen_manager.add_widget(Builder.load_file("start_page.kv"))
        screen_manager.add_widget(Builder.load_file("home.kv"))
        screen_manager.add_widget(Builder.load_file("create_account.kv"))
        screen_manager.add_widget(Builder.load_file("login.kv"))
        screen_manager.add_widget(Builder.load_file("edit_details.kv"))
        screen_manager.add_widget(Builder.load_file("doctor_profile.kv"))

        screen_manager.add_widget(Builder.load_file("chatbot.kv"))
        return screen_manager

    def translate(self,*args):
        print("running")
        self.r = sr.Recognizer()
        with sr.Microphone() as source:
            self.r.adjust_for_ambient_noise(source, duration=0.1)
            try:
                audio = self.r.listen(source)
                value = self.r.recognize_google(audio)
                print(value)
                if len(value) < 6:
                    size = .22
                    halign = "center"
                elif len(value) < 11:
                    size = .32
                    halign = "center"
                elif len(value) < 16:
                    size = .45
                    halign = "center"
                elif len(value) < 21:
                    size = .58
                    halign = "center"
                elif len(value) < 26:
                    size = .71
                    halign = "center"
                else:
                    size = .77
                    halign = "left"
                screen_manager.get_screen('chatbot').chat_list.add_widget(ChatBotCommand(text=value, size_hint_x=size, halign= halign, font_size=40))
            except:
                print("error")

    def response(self,*args):
        response = ""
        global disease
        print(value)
        if value == 'hello' or value == 'hi':
            response = f"Hello. I Am Your Personal Assistant {Name}"
            screen_manager.get_screen('chatbot').chat_list.add_widget(ChatBotResponse(text=response, size_hint_x=.75, font_size=40))
            screen_manager.get_screen('chatbot').chat_list.add_widget(ChatBotResponse(text="please specify min 3 symptoms", size_hint_x=.75, font_size=40))
            return ""
        elif value == "how are you":
            response = "I'm doing well. Thanks!"
            screen_manager.get_screen('chatbot').chat_list.add_widget(ChatBotResponse(text=response, size_hint_x=.75, font_size=40))
        elif(len(value)<=1):
            response= "sorry try again"
            screen_manager.get_screen('chatbot').chat_list.add_widget(ChatBotResponse(text=response, size_hint_x=.75, font_size=40))
        elif value == "go to home":
            screen_manager.current = "home"
        elif value.lower() =="yes":
            prec = pd.read_csv("final_precaution.csv")
            disease2 = list(prec["Disease"])
            for j in range(len(disease2)):
                if disease2[j] == disease:
                    break
            response="Precautions to be taken:\n"+str(prec.iloc[j][1:])
            p=prec.iloc[j][1:]
            pr=[]
            m="Precautions to be taken:\n"
            for i in range(len(p)):
                if str(p[i])!="nan":
                    pr.append(p[i])
                    m+=str(i+1)+". "+p[i]+"\n"
            print(pr)
            screen_manager.get_screen('chatbot').chat_list.add_widget(ChatBotResponse(text=m, size_hint_x=.75, font_size=30))

        else:
            sympt=['itching', 'skin_rash', 'nodal_skin_eruptions', 'continuous_sneezing', 'shivering', 'chills', 'joint_pain', 'stomach_pain', 'acidity', 'ulcers_on_tongue', 'muscle_wasting', 'vomiting', 'burning_micturition', 'spotting_ urination', 'fatigue', 'weight_gain', 'anxiety', 'cold_hands_and_feets', 'mood_swings', 'weight_loss', 'restlessness', 'lethargy', 'patches_in_throat', 'irregular_sugar_level', 'cough', 'high_fever', 'sunken_eyes', 'breathlessness', 'sweating', 'dehydration', 'indigestion', 'headache', 'yellowish_skin', 'dark_urine', 'nausea', 'loss_of_appetite', 'pain_behind_the_eyes', 'back_pain', 'constipation', 'abdominal_pain', 'diarrhoea', 'mild_fever', 'yellow_urine', 'yellowing_of_eyes', 'acute_liver_failure', 'fluid_overload', 'swelling_of_stomach', 'swelled_lymph_nodes', 'malaise', 'blurred_and_distorted_vision', 'phlegm', 'throat_irritation', 'redness_of_eyes', 'sinus_pressure', 'runny_nose', 'congestion', 'chest_pain', 'weakness_in_limbs', 'fast_heart_rate', 'pain_during_bowel_movements', 'pain_in_anal_region', 'bloody_stool', 'irritation_in_anus', 'neck_pain', 'dizziness', 'cramps', 'bruising', 'obesity', 'swollen_legs', 'swollen_blood_vessels', 'puffy_face_and_eyes', 'enlarged_thyroid', 'brittle_nails', 'swollen_extremeties', 'excessive_hunger', 'extra_marital_contacts', 'drying_and_tingling_lips', 'slurred_speech', 'knee_pain', 'hip_joint_pain', 'muscle_weakness', 'stiff_neck', 'swelling_joints', 'movement_stiffness', 'spinning_movements', 'loss_of_balance', 'unsteadiness', 'weakness_of_one_body_side', 'loss_of_smell', 'bladder_discomfort', 'foul_smell_of urine', 'continuous_feel_of_urine', 'passage_of_gases', 'internal_itching', 'toxic_look_(typhos)', 'depression', 'irritability', 'muscle_pain', 'altered_sensorium', 'red_spots_over_body', 'belly_pain', 'abnormal_menstruation', 'dischromic _patches', 'watering_from_eyes', 'increased_appetite', 'polyuria', 'family_history', 'mucoid_sputum', 'rusty_sputum', 'lack_of_concentration', 'visual_disturbances', 'receiving_blood_transfusion', 'receiving_unsterile_injections', 'coma', 'stomach_bleeding', 'distention_of_abdomen', 'history_of_alcohol_consumption', 'fluid_overload', 'blood_in_sputum', 'prominent_veins_on_calf', 'palpitations', 'painful_walking', 'pus_filled_pimples', 'blackheads', 'scurring', 'skin_peeling', 'silver_like_dusting', 'small_dents_in_nails', 'inflammatory_nails', 'blister', 'red_sore_around_nose', 'yellow_crust_ooze', 'prognosis']
            symptoms=[]
            for i in list(value.split(" ")):
                print(i)
                if i in sympt:
                    symptoms.append(i)
            print(symptoms)
            df_input = pd.DataFrame(columns=X.columns)
            df_input.loc[0] = 0
            for symptom in symptoms:
                df_input.loc[0][symptom] = 1
            response = sgd.predict(df_input)[0]
            disease=sgd.predict(df_input)[0]
            screen_manager.get_screen('chatbot').chat_list.add_widget(ChatBotResponse(text=response, size_hint_x=.75, font_size=40))
            screen_manager.get_screen('chatbot').chat_list.add_widget(ChatBotResponse(text="Do you precaution ?", size_hint_x=.75, font_size=40))
    def send(self):
        global size,halign, value
        if screen_manager.get_screen('chatbot').text_input != "":
            value= screen_manager.get_screen('chatbot').text_input.text
            value = value.lower()
            if len(value)<6:
                size = .22
                halign = "center"
            elif len(value)<11:
                size = .32
                halign = "center"
            elif len(value)<16:
                size = .45
                halign = "center"
            elif len(value)<21:
                size = .58
                halign = "center"
            elif len(value)<26:
                size = .71
                halign = "center"
            else:
                size = .77
                halign= "left"
            screen_manager.get_screen('chatbot').chat_list.add_widget(ChatBotCommand(text=value, size_hint_x=size, halign= halign, font_size=40))
            Clock.schedule_once(self.response, 2)
            screen_manager.get_screen('chatbot').text_input.text = ""
    def move_to_profile(self,pro):
        from profile import profile_name
        profile.changename(pro)
        screen_manager.current = "profile"
if __name__ == '__main__':
    LabelBase.register(name="MPoppins", fn_regular="Poppins/Poppins-Medium.ttf")
    LabelBase.register(name="BPoppins", fn_regular="Poppins/Poppins-Bold.ttf")
    C = CHATBOT()
    C.run()