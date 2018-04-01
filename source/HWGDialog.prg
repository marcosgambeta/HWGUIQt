/*

  HWGUIQt - m�dulo para Qt4xHb/Qt5xHb com sintaxe no estilo HWGUI

  Copyright (C) 2018 Marcos Antonio Gambeta <marcosgambeta AT outlook DOT com>

*/

#ifdef __QT4XHB__
#include "qt4xhb.ch"
#endif
#ifdef __QT5XHB__
#include "qt5xhb.ch"
#endif
#include "hbclass.ch"

CLASS HWGDialog INHERIT HWGCustomWindow

   DATA lOnActivated INIT .F.
   DATA bOnActivate
   DATA lModal INIT .T.
   DATA oEventLoop

   METHOD new
   METHOD activate
   METHOD close
   METHOD accept
   METHOD reject

   METHOD onSize
   METHOD onMove
   METHOD onPaint
   METHOD onGetFocus
   METHOD onLostFocus

ENDCLASS

METHOD new ( oParent, nX, nY, nWidth, nHeight, cToolTip, cStyleSheet, oFont, ;
             xForeColor, xBackColor, cTitle, cIcon, ;
             bInit, bSize, bMove, bPaint, bGFocus, bLFocus, bExit ) CLASS HWGDialog

   IF valtype(oParent) == "O"
      ::oQt := QDialog():new(oParent:oQt)
      ::oParent := oParent
   ELSE
      ::oQt := QDialog():new(QApplication():activeWindow())
   ENDIF

   ::configureGeometry( nX, nY, nWidth, nHeight )
   ::configureTips( cToolTip )
   ::configureStyleSheet( cStyleSheet )
   ::configureFont( oFont )
   ::configureColors( ::oQt:foregroundRole(), xForeColor, ::oQt:backgroundRole(), xBackColor )

   IF valtype(cTitle) == "C"
      ::oQt:setWindowTitle(cTitle)
   ENDIF

   IF valtype(cIcon) == "C"
      ::oQt:setWindowIcon( QIcon():new(cIcon) )
   ENDIF

   IF valtype(bInit) == "B"
      ::bInit := bInit
   ENDIF

   IF valtype(bSize) == "B"
      ::bSize := bSize
      ::oQt:onResizeEvent( {|oSender,oEvent| ::onSize(oSender,oEvent) } )
   ENDIF

   IF valtype(bMove) == "B"
      ::bMove := bMove
      ::oQt:onMoveEvent( {|oSender,oEvent| ::onMove(oSender,oEvent) } )
   ENDIF

   IF valtype(bPaint) == "B"
      ::bPaint := bPaint
      ::oQt:onPaintEvent( {|oSender,oEvent| ::onPaint(oSender,oEvent) } )
   ENDIF

   IF valtype(bGFocus) == "B"
      ::bGFocus := bGFocus
      ::oQt:onWindowActivateEvent( {|oSender,oEvent| ::onGetFocus(oSender,oEvent) } )
   ENDIF

   IF valtype(bLFocus) == "B"
      ::bLFocus := bLFocus
      ::oQt:onWindowDeactivateEvent( {|oSender,oEvent| ::onLostFocus(oSender,oEvent) } )
   ENDIF

   IF valtype(bExit) == "B"
      ::bExit := bExit
   ENDIF

   HWGFILO():add(self)

RETURN self

METHOD activate ( lNoModal, bOnActivate, nShow ) CLASS HWGDialog

   IF valtype(::bInit) == "B"
      eval(::bInit, self)
   ENDIF

   IF valtype(lNoModal) == "L"
      IF lNoModal
         ::lModal := .F.
      ENDIF
   ENDIF

   IF ::lModal
      ::oQt:exec()
   ELSE
      ::oQt:show()
      ::oEventLoop := QEventLoop():new()
      ::oEventLoop:exec()
      ::oEventLoop:delete()
   ENDIF

RETURN NIL

METHOD close () CLASS HWGDialog

   ::oQt:done() // TODO: requer parametro numerico

RETURN NIL

METHOD accept () CLASS HWGDialog

   ::oQt:accept()

RETURN NIL

METHOD reject () CLASS HWGDialog

   ::oQt:reject()

RETURN NIL

METHOD onSize (oSender,oEvent) CLASS HWGDialog

   IF valtype(::bSize) == "B"
      eval(::bSize)
   ENDIF

RETURN NIL

METHOD onMove (oSender,oEvent) CLASS HWGDialog

   IF valtype(::bMove) == "B"
      eval(::bMove)
   ENDIF

RETURN NIL

METHOD onPaint (oSender,oEvent) CLASS HWGDialog

   IF valtype(::bPaint) == "B"
      eval(::bPaint)
   ENDIF

RETURN NIL

METHOD onGetFocus (oSender,oEvent) CLASS HWGDialog

   IF valtype(::bGFocus) == "B"
      eval(::bGFocus)
   ENDIF

RETURN NIL

METHOD onLostFocus (oSender,oEvent) CLASS HWGDialog

   IF valtype(::bLFocus) == "B"
      eval(::bLFocus)
   ENDIF

RETURN NIL
