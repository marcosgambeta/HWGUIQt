/*

  HWGUIQt - m�dulo para Qt4xHb/Qt5xHb/Qt6xHb com sintaxe no estilo HWGUI

  Copyright (C) 2021 Marcos Antonio Gambeta <marcosgambeta AT outlook DOT com>

*/

#ifdef __QT4XHB__
#include "qt4xhb.ch"
#endif
#ifdef __QT5XHB__
#include "qt5xhb.ch"
#endif
#include "hbclass.ch"

CLASS HWGEditBox INHERIT HWGControl

   METHOD new
   METHOD activate

ENDCLASS

METHOD New ( oParent, nId, nStyle, nX, nY, nWidth, nHeight, cToolTip, cStatusTip, cWhatsThis, ;
             cStyleSheet, oFont, xForeColor, xBackColor, ;
             cText, ;
             bInit, bSize, bMove, bPaint, bGFocus, bLFocus, bShow, bHide, bEnable, bDisable, ;
             lDisabled, lInvisible ) CLASS HWGEditBox

   IF valtype(oParent) == "O"
      ::oQt := QPlainTextEdit():new(oParent:oQt)
      ::oParent := oParent
   ELSE
      IF valtype(HWGFILO():last()) == "O"
         ::oQt := QPlainTextEdit():new(HWGFILO():last():oQt)
         ::oParent := HWGFILO():last()
      ELSE
         ::oQt := QPlainTextEdit():new()
      ENDIF
   ENDIF

   IF nId == NIL
      ::nId := ::newId()
   ELSE
      ::nId := nId
   ENDIF

   ::configureStyle( nStyle )
   ::configureGeometry( nX, nY, nWidth, nHeight )
   ::configureTips( cToolTip, cStatusTip, cWhatsThis )
   ::configureStyleSheet( cStyleSheet )
   ::configureFont( oFont )
   ::configureColors( ::oQt:foregroundRole(), xForeColor, ::oQt:backgroundRole(), xBackColor )

   IF valtype(cText) == "C"
      ::oQt:setPlainText(cText)
   ENDIF

   IF valtype(bInit) == "B"
      ::bInit := bInit
   ENDIF

   ::configureEvents( bSize, bMove, bPaint, bGFocus, bLFocus, bShow, bHide, bEnable, bDisable )
   ::connectEvents()

   IF valtype(lDisabled) == "L"
      IF lDisabled
         ::oQt:setEnabled(.F.)
      ENDIF
   ENDIF

   IF valtype(lInvisible) == "L"
      IF lInvisible
         ::oQt:setVisible(.F.)
      ENDIF
   ENDIF

   IF ::oParent != NIL
      ::oParent:addControl(self)
   ENDIF

   ::activate()

RETURN self

METHOD activate () CLASS HWGEditBox

   IF valtype(::bInit) == "B"
      eval(::bInit, self)
   ENDIF

RETURN NIL
