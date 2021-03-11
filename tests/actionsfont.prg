/*

  HWGUIQt Project - Test Program

  Copyright (C) 2021 Marcos Antonio Gambeta

  E-mail:
  marcosgambeta AT outlook DOT com

  Website:
  https://github.com/marcosgambeta/HWGUIQt

*/

/*
  Teste das classes HWGToolBar e HWGToolBarItem usando a��es
*/

#include "hwguiqt.ch"

PROCEDURE Main ()

   LOCAL oApp
   LOCAL aFont := array(6)
   LOCAL oMainWindow
   LOCAL oMenuBar
   LOCAL oMenuA
   LOCAL oMenuB
   LOCAL oToolBar
   LOCAL oActionA1
   LOCAL oActionA2
   LOCAL oActionA3
   LOCAL oActionB1
   LOCAL oActionB2
   LOCAL oActionB3

   INIT APPLICATION oApp

   PREPARE FONT aFont[1] NAME "Arial" WIDTH 14
   PREPARE FONT aFont[2] NAME "Courier New" WIDTH 14
   PREPARE FONT aFont[3] NAME "Verdana" WIDTH 14
   PREPARE FONT aFont[4] NAME "Times New Roman" WIDTH 14
   PREPARE FONT aFont[5] NAME "Lucida Console" WIDTH 14
   PREPARE FONT aFont[6] NAME "Georgia" WIDTH 14

   // cria a janela principal
   INIT WINDOW oMainWindow TITLE "Janela principal" SIZE 800,600 MAIN

   // cria as a��es que ser�o usadas nos menus e na barra de ferramentas
   PREPARE ACTION oActionA1 TEXT "Op��o A1" ICON "images/new.png"   TOOLTIP "Executa a op��o A1" FONT aFont[1] ON TRIGGERED hwgqt_msginfo("A1") OF oMainWindow
   PREPARE ACTION oActionA2 TEXT "Op��o A2" ICON "images/open.png"  TOOLTIP "Executa a op��o A2" FONT aFont[2] ON TRIGGERED hwgqt_msginfo("A2") OF oMainWindow
   PREPARE ACTION oActionA3 TEXT "Op��o A3" ICON "images/save.png"  TOOLTIP "Executa a op��o A3" FONT aFont[3] ON TRIGGERED hwgqt_msginfo("A3") OF oMainWindow
   PREPARE ACTION oActionB1 TEXT "Op��o B1" ICON "images/cut.png"   TOOLTIP "Executa a op��o B1" FONT aFont[4] ON TRIGGERED hwgqt_msginfo("B1") OF oMainWindow
   PREPARE ACTION oActionB2 TEXT "Op��o B2" ICON "images/copy.png"  TOOLTIP "Executa a op��o B2" FONT aFont[5] ON TRIGGERED hwgqt_msginfo("B2") OF oMainWindow
   PREPARE ACTION oActionB3 TEXT "Op��o B3" ICON "images/paste.png" TOOLTIP "Executa a op��o B3" FONT aFont[6] ON TRIGGERED hwgqt_msginfo("B3") OF oMainWindow

   // cria a barra de menus
   BEGIN MENUBAR oMenuBar OF oMainWindow
      // cria o primeiro menu
      BEGIN MENU oMenuA TITLE "Menu &A"
         MENUITEM USING ACTION oActionA1
         MENUITEM USING ACTION oActionA2
         MENUITEM USING ACTION oActionA3
      END MENU
      // cria o segundo menu
      BEGIN MENU oMenuB TITLE "Menu &B"
         MENUITEM USING ACTION oActionB1
         MENUITEM USING ACTION oActionB2
         MENUITEM USING ACTION oActionB3
      END MENU
   END MENUBAR

   // cria a barra de ferramentas
   BEGIN TOOLBAR oToolBar OF oMainWindow
      TOOLBARITEM USING ACTION oActionA1
      TOOLBARITEM USING ACTION oActionA2
      TOOLBARITEM USING ACTION oActionA3
      SEPARATOR OF oToolBar
      TOOLBARITEM USING ACTION oActionB1
      TOOLBARITEM USING ACTION oActionB2
      TOOLBARITEM USING ACTION oActionB3
   END TOOLBAR

   // ativa a janela
   ACTIVATE WINDOW oMainWindow

   EXECUTE APPLICATION oApp

   RELEASE WINDOW oMainWindow

   RELEASE APPLICATION oApp

RETURN
