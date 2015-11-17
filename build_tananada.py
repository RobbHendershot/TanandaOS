#!/usr/bin/env python

import npyscreen

class App(npyscreen.NPSAppManaged):
    def onStart(self):
        self.registerForm("MAIN", MainForm())

# This form class defines the display that will be presented to the user.

class MainForm(npyscreen.FormMuttActiveWithMenus):
    def create(self):
        self.add(npyscreen.TitleText, name = "Text:", value= "Hellow World!" )

    def afterEditing(self):
        self.parentApp.setNextForm(None)

if __name__ == '__main__':
    TA = App()
    TA.run()