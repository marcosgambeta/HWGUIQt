/*

  HWGUIQt - m�dulo para Qt4xHb/Qt5xHb com sintaxe no estilo HWGUI

  Copyright (C) 2018 Marcos Antonio Gambeta <marcosgambeta AT outlook DOT com>

*/

#xcommand @ <nX>,<nY> RADIOBUTTON [ <oObj> CAPTION ] <cText> ;
            [ OF <oParent> ] ;
            [ SIZE <nWidth>,<nHeight> ] ;
            [ TOOLTIP <cToolTip> ] ;
            [ STATUSTIP <cStatusTip> ] ;
            [ WHATSTHIS <cWhatsThis> ] ;
            [ STYLESHEET <cStyleSheet> ] ;
            [ FONT <oFont> ] ;
            [ ON INIT <bOnInit> ] ;
            [ <lDisabled:DISABLED> ] ;
            [ <class:CLASS> <className> ] ;
            => ;
            [ <oObj> := ] __IIF(<.class.>,<className>,HWGRadioButton)():new( <oParent>, ;
                                                <nX>, ;
                                                <nY>, ;
                                                <nWidth>, ;
                                                <nHeight>, ;
                                                <cToolTip>, ;
                                                <cStatusTip>, ;
                                                <cWhatsThis>, ;
                                                <cStyleSheet>, ;
                                                <oFont>, ;
                                                <cText>, ;
                                                <bOnInit>, ;
                                                <.lDisabled.> )
