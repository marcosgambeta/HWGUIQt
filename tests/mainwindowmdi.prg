/*

  HWGUIQt Project - Test Program

  Copyright (C) 2018 Marcos Antonio Gambeta

  E-mail:
  marcosgambeta AT outlook DOT com

  Website:
  https://github.com/marcosgambeta/HWGUIQt

*/

#include "hwgui.ch"

PROCEDURE Main ()

   LOCAL oApp
   LOCAL oMainWindow

   oApp := QApplication():new()

   INIT WINDOW oMainWindow TITLE "Janela principal" SIZE 800,600 MAIN MDI

   ACTIVATE WINDOW oMainWindow

   oApp:exec()

   oMainWindow:delete()

   oApp:delete()

RETURN