from firebase import firebase
from kivy.core.image import Image
from kivy.core.text import LabelBase, Label
from kivy.properties import StringProperty
from kivy.uix.boxlayout import BoxLayout
from kivy.uix.recycleview import RecycleView
from kivymd.app import MDApp
from kivy.lang import Builder
from kivy.core.window import Window
from kivymd.uix.behaviors import FakeRectangularElevationBehavior
from kivymd.uix.card import MDCard
from doctors import doctors_list
from kivymd.uix.floatlayout import MDFloatLayout
from kivy.uix.screenmanager import Screen, ScreenManager
from difflib import SequenceMatcher
Window.size = (450, 700)
profile_name=""

def changename(profile):
    global profile_name
    profile_name=profile

firebase = firebase.FirebaseApplication("https://doctor-73985-default-rtdb.firebaseio.com/",None)
# -----------------------------------------------------Filtering------------------------------------------------------------------


class MainInterface(Screen):
    def search(self):
        ten=self.ids.textfield.text
        result = firebase.get('https://doctor-73985-default-rtdb.firebaseio.com/doctor', '')
        self.ids.recycleview.data = [{'icon_to_display': str(result[i].get('Name')),'id_specialist':str(result[i].get("Specialist")), 'id_hospital':str(result[i].get("Hospital")),
                                        'id_name':str(str(result[i].get('Name'))), "img":"images/"+str(result[i].get("Name"))+".jpg"}
                                        for i in result.keys() if (self.ids.textfield.text in str(result[i].get('Name'))) or (self.ids.textfield.text in str(result[i].get("Specialist")) or (SequenceMatcher(None,ten,str(result[i].get("Name"))).ratio())>0.5)]


class CustomRecycleView(RecycleView):
    def __init__(self, **kwargs):
        super().__init__(**kwargs)
        result = firebase.get('https://doctor-73985-default-rtdb.firebaseio.com/doctor', '')
        print(result)
        self.data = [{'icon_to_display': str(result[i].get('Name')),'id_specialist':str(result[i].get("Specialist")), 'id_hospital':str(result[i].get("Hospital")),
                      'id_name':str(str(result[i].get('Name'))), "img":"images/"+str(result[i].get("Name"))+".jpg"}
                     for i in result.keys()]


class ElementCard1(MDCard):
    icon_to_display = StringProperty()
    hi= StringProperty()
    id_name= StringProperty()
    img= StringProperty()
    id_specialist= StringProperty()
    id_hospital= StringProperty()





class AppointmentScreen(Screen):
    def _init_(self, **kwargs):
        super(AppointmentScreen, self)._init_(**kwargs)

    def on_pre_enter(self, *args):
        result = firebase.get('https://doctor-73985-default-rtdb.firebaseio.com/doctor', '')
        # list1=[]
        for i in result.keys():
            global profile_name
            # list1.append( result[i].get('Name'))
            if result[i].get('Name') == profile_name:
                self.ids.name.text=result[i].get("Name")
                self.ids.study.text=result[i].get("Degree")
                self.ids.specialist.text=result[i].get("Specialist")
                self.ids.experience.text=result[i].get("Experience")
                self.ids.availability.text=result[i].get("Availability")
                self.ids.location.text=result[i].get("Location")
                self.ids.hospital.text=result[i].get("Hospital")
                self.ids.phone.text=result[i].get("Phno")
                self.ids.address.text=result[i].get("Address")[:30]+"\n"+result[i].get("Address")[30:]
                self.ids.img.source = "images/"+result[i].get("Name")+".jpg"

        # print(list1)

