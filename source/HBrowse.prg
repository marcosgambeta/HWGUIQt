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

CLASS HBrowse INHERIT HControl

   DATA oModel
   DATA aColumns INIT {}
   DATA aArray INIT {}

   METHOD new
   METHOD activate

ENDCLASS

METHOD new ( oParent, nX, nY, nWidth, nHeight, cToolTip, cStatusTip, cWhatsThis, cStyleSheet, oFont, ;
             bInit, bSize, bPaint, bGFocus, bLFocus, ;
             lArray, lDatabase ) CLASS HBrowse

   IF valtype(oParent) == "O"
      ::oQt := QTableView():new(oParent:oQt)
   ELSE
      IF valtype(HFILO():last()) == "O"
         ::oQt := QTableView():new(HFILO():last():oQt)
      ELSE
         ::oQt := QTableView():new()
      ENDIF
   ENDIF

   IF valtype(nX) == "N" .AND. valtype(nY) == "N"
      ::oQt:move(nX,nY)
   ENDIF

   IF valtype(nWidth) == "N" .AND. valtype(nHeight) == "N"
      ::oQt:resize(nWidth,nHeight)
   ENDIF

   IF valtype(cToolTip) == "C"
      ::oQt:setToolTip(cToolTip)
   ENDIF

   IF valtype(cStatusTip) == "C"
      ::oQt:setStatusTip(cStatusTip)
   ENDIF

   IF valtype(cWhatsThis) == "C"
      ::oQt:setWhatsThis(cWhatsThis)
   ENDIF

   IF valtype(cStyleSheet) == "C"
      ::oQt:setStyleSheet(cStyleSheet)
   ENDIF

   IF valtype(oFont) == "O"
      ::oQt:setFont(oFont:oQt)
   ENDIF

   IF valtype(bInit) == "B"
      ::bInit := bInit
   ENDIF

   IF valtype(bSize) == "B"
      ::bSize := bSize
      ::oQt:onResizeEvent( {|oSender,oEvent| ::onSize(oSender,oEvent) } )
   ENDIF

   IF valtype(bPaint) == "B"
      ::bPaint := bPaint
      ::oQt:onPaintEvent( {|oSender,oEvent| ::onPaint(oSender,oEvent) } )
   ENDIF

   IF valtype(bGFocus) == "B"
      ::bGFocus := bGFocus
      ::oQt:onFocusInEvent( {|oSender,oEvent| ::onGFocus(oSender,oEvent) } )
   ENDIF

   IF valtype(bLFocus) == "B"
      ::bLFocus := bLFocus
      ::oQt:onFocusOutEvent( {|oSender,oEvent| ::onLFocus(oSender,oEvent) } )
   ENDIF

   // atualiza propriedades do objeto

   ::nLeft   := ::oQt:x()
   ::nTop    := ::oQt:y()
   ::nWidth  := ::oQt:width()
   ::nHeight := ::oQt:height()

   // cria o modelo
   ::oModel := HBrowseArrayModel():new()

   // armazena no modelo o objeto browse
   ::oModel:oBrowse := self

   // associa modelo ao visualizador
   ::oQt:setModel(::oModel)

   ::activate()

RETURN self

METHOD activate () CLASS HBrowse

   IF valtype(::bInit) == "B"
      eval(::bInit)
   ENDIF

RETURN NIL

//-----------------------------------------------------------------//

CLASS HBrowseArrayModel INHERIT HAbstractTableModelV2

   DATA oBrowse

   METHOD new
   METHOD rowCount
   METHOD columnCount
   METHOD data
   METHOD headerData
   METHOD flags
   METHOD setData

END CLASS

METHOD new (...) CLASS HBrowseArrayModel

   ::super:new(...)

   ::setRowCountCB( {|...|::rowCount(...)} )
   ::setColumnCountCB( {|...|::columnCount(...)} )
   ::setDataCB( {|...|::data(...)} )
   ::setHeaderDataCB( {|...|::headerData(...)} )
   ::setFlagsCB( {|...|::flags(...)} )
   ::setSetDataCB( {|...|::setData(...)} )

RETURN self

METHOD rowCount () CLASS HBrowseArrayModel
RETURN len( ::oBrowse:aArray )

METHOD columnCount () CLASS HBrowseArrayModel
RETURN iif( len( ::oBrowse:aArray ) > 0, len( ::oBrowse:aArray[1] ), 0 )

METHOD data (pIndex, nRole) CLASS HBrowseArrayModel

   LOCAL oVariant := QVariant():new()
   LOCAL oIndex := QModelIndex():newFrom(pIndex)
   LOCAL nRow := oIndex:row()
   LOCAL nColumn := oIndex:column()

   IF oIndex:isValid()

      IF nRole == Qt_DisplayRole
         oVariant := QVariant():new( ::oBrowse:aArray[ nRow+1 ][ nColumn+1 ] )
      ELSEIF nRole == Qt_EditRole
         oVariant := QVariant():new( ::oBrowse:aArray[ nRow+1 ][ nColumn+1 ] )
      ENDIF

   ENDIF

RETURN oVariant

METHOD headerData (nSection, nOrientation, nRole) CLASS HBrowseArrayModel

   LOCAL oVariant := QVariant():new()

   IF nOrientation == Qt_Horizontal .AND. nRole == Qt_DisplayRole
      oVariant := QVariant():new( "Coluna "+alltrim(str(nSection+1)) )
   ELSEIF nOrientation == Qt_Vertical .AND. nRole == Qt_DisplayRole
      oVariant := QVariant():new( "#"+alltrim(str(nSection+1)) )
   ENDIF

RETURN oVariant

METHOD flags (pIndex) CLASS HBrowseArrayModel

   //LOCAL nFlags := Qt_ItemIsSelectable + Qt_ItemIsEditable + Qt_ItemIsEnabled
   LOCAL nFlags := Qt_ItemIsSelectable + Qt_ItemIsEnabled
   LOCAL oIndex := QModelIndex():newFrom(pIndex)
   LOCAL nRow := oIndex:row()
   LOCAL nColumn := oIndex:column()

RETURN nFlags

METHOD setData (pIndex, pVariant, nRole) CLASS HBrowseArrayModel

   LOCAL lSuccess := .F.
   LOCAL oIndex := QModelIndex():newFrom(pIndex)
   LOCAL oVariant := QVariant():newFrom(pVariant)
   LOCAL nRow := oIndex:row()
   LOCAL nColumn := oIndex:column()
   LOCAL cValue := ""

   IF oIndex:isValid()

      IF nRole == Qt_EditRole

         cValue := oVariant:toString()

         IF !empty(cValue)
            ::oBrowse:aArray[ nRow+1 ][ nColumn+1 ] := oVariant:toString()
            lSuccess := .T.
         ENDIF

      ENDIF

   ENDIF

RETURN lSuccess