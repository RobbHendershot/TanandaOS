#!/usr/bin/env python

import npyscreen

# This application class serves as a wrapper for the initialization of curses
# and also manages the actual forms of the application
class MyTestApp(npyscreen.NPSAppManaged):
    def onStart(self):
        self.registerForm("MAIN", MainForm())

# This form class defines the display that will be presented to the user.
class MainForm(npyscreen.ActionFormV2WithMenus):
    def create(self):
        self.add(npyscreen.TitleText, name = "Text:", value= "Hello World!" )

        M = self.new_menu(name = "Main Menu", shortcut=None)
        M.addItem(text = "item 1")
        S = M.addNewSubmenu(name = "sub menu")
        S.addItem(text = "sub item 1")

    def afterEditing(self):
        self.parentApp.setNextForm(None)

if __name__ == '__main__':
    TA = MyTestApp()
    TA.run()