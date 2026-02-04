from kivy.core.text import LabelBase
from kivy.properties import StringProperty
from kivy.uix.recycleview import RecycleView
from kivymd.app import MDApp
from kivy.lang import Builder
from kivy.core.window import Window
from kivymd.uix.behaviors import FakeRectangularElevationBehavior
from kivymd.uix.card import MDCard
from kivymd.uix.floatlayout import MDFloatLayout
from kivy.uix.screenmanager import Screen, ScreenManager
from kivymd.uix.list import ImageLeftWidget, ThreeLineAvatarListItem
from ambulancelist import Services
from contacts import contact

# import appointment

Window.size = (400, 700)

# ---------------------------------------------Emergency Screen--------------------------------------------------------
# class MDBoxLayout(MDFloatLayout):
#     pass
#
#
class EmergencyScreen(Screen):
    pass
#
#
# class MDCard(Screen):
#     pass


# -----------------------------------------------Ambulance_screen---------------------------------------------------------------------
# class AmbulanceScreen(Screen):
#     pass


class AmbulanceScreen(Screen):
    def search(self):
        self.ids.recycleview.data = [{'icon_to_display': str(i)} for i in Services.keys() if
                                     self.ids.textfield.text in i]


class CustomRecycleView(RecycleView):
    def __init__(self, **kwargs):
        super().__init__(**kwargs)
        self.data = [{'icon_to_display': str(i)} for i in Services.keys()]


class ElementCard10(MDCard):
    icon_to_display = StringProperty()


# -----------------------------------



class ContactScreen(Screen):
    def searching(self):
        self.ids.recycleview1.data = [{'icon_to_display1': str(i)} for i in contact.keys() if self.ids.textfield.text in i]


class CustomRecycleView1(RecycleView):
    def __init__(self, **kwargs):
        super().__init__(**kwargs)
        self.data = [{'icon_to_display1': str(i)} for i in contact.keys()]



class ElementCard1(MDCard):
    icon_to_display1 = StringProperty()


