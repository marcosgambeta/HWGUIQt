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
   LOCAL oDialog
   LOCAL oButton1
   LOCAL oButton2
   LOCAL oButton3

   oApp := QApplication():new()

   INIT DIALOG oDialog TITLE "Teste da classe HButton" SIZE 320,240

   @ 10,10 BUTTON oButton1 CAPTION "Bot�o 1" SIZE 120,40 ;
      ON INIT {||hwg_MsgInfo("Bot�o 1 - ON INIT")} ;
      ON CLICK {||hwg_MsgInfo("Bot�o 1 - ON CLICK")} ;
      OF oDialog

   @ 10,70 BUTTON oButton2 CAPTION "Bot�o 2" SIZE 120,40 ;
      ON INIT {||hwg_MsgInfo("Bot�o 2 - ON INIT")} ;
      ON CLICK {||hwg_MsgInfo("Bot�o 2 - ON CLICK")} ;
      OF oDialog

   @ 10,140 BUTTON oButton3 CAPTION "Bot�o 3" SIZE 120,40 ;
      ON INIT {||hwg_MsgInfo("Bot�o 3 - ON INIT")} ;
      ON CLICK {||hwg_MsgInfo("Bot�o 3 - ON CLICK")} ;
      OF oDialog

   ACTIVATE DIALOG oDialog

   oDialog:delete()

   oApp:delete()

RETURN