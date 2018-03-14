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

   INIT WINDOW oMainWindow TITLE "Janela principal" SIZE 800,600 MAIN ;
      ON INIT {||qout("oMainWindow-init")} ;
      ON SIZE {||qout("oMainWindow-size")} ;
      ON PAINT {||qout("oMainWindow-paint")} ;
      ON GETFOCUS {||qout("oMainWindow-getfocus")} ;
      ON LOSTFOCUS {||qout("oMainWindow-lostfocus")}

   ACTIVATE WINDOW oMainWindow

   oApp:exec()

   oMainWindow:delete()

   oApp:delete()

RETURN
