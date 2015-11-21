#!/usr/bin/env python

import npyscreen

class MyApp(npyscreen.NPSAppManaged):
	def onStart(self):
		#npyscreen.setTheme(npyscreen.Themes.ColorfulTheme)
		self.registerForm("MAIN", MainForm())
		#MAIN.wStatus1.relx = MAIN.wStatus1.width/2 - len(MAIN.wStatus1.value)/2

class MainForm(npyscreen.FormBaseNew):
	BUTTON_WIDTH = 16
	BUTTON_HEIGHT = 5

	def create(self):
		self.bn_create = self.add(npyscreen.ButtonPress, 
			name = "Create", 
			width = self.BUTTON_WIDTH,
			height = self.BUTTON_HEIGHT
		)

		self.bn_test = self.add(npyscreen.ButtonPress, 
			name = "Test", 
			width = self.BUTTON_WIDTH,
			height = self.BUTTON_HEIGHT
		)

		self.bn_write = self.add(npyscreen.ButtonPress, 
			name = "Write", 
			width = self.BUTTON_WIDTH,
			height = self.BUTTON_HEIGHT
		)

		self.bn_quit = self.add(npyscreen.ButtonPress, 
			name = "Quit", 
			width = self.BUTTON_WIDTH,
			height = self.BUTTON_HEIGHT,
			when_pressed_function = self.exit_application
		)

		self.add(npyscreen.BoxBasic,
 			relx = self.BUTTON_WIDTH + 1, 
 			rely = 1,
 			name = "TanandaOS Build App"
		)

	def exit_application(self):
		self.parentApp.setNextForm(None)
		self.editing = False
		self.parentApp.switchFormNow()


if __name__ == '__main__':
    BuildApp = MyApp().run()
