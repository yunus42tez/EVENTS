*&---------------------------------------------------------------------*
*&  Include           ZYT_SFLZ_EVENTS_TOP
*&---------------------------------------------------------------------*
TYPE-POOLS : slis.

TABLES: vbak,
        likp,
        vbrk.

DATA: gt_fieldcat TYPE slis_t_fieldcat_alv,
      gs_fieldcat TYPE slis_fieldcat_alv,
      ls_layout   TYPE slis_layout_alv.

TYPES: BEGIN OF gty_vbak,
         vbeln TYPE vbeln,
         erdat TYPE erdat,
       END OF gty_vbak.

DATA: gt_vbak  TYPE TABLE OF gty_vbak,
      gs_vbak  TYPE gty_vbak.
**************************************************

TYPES: BEGIN OF gty_likp_chx,
         vbeln     TYPE vbeln,
         erdat     TYPE erdat,
         spe_loekz TYPE loekz_bk,
       END OF gty_likp_chx.

DATA: gt_likp_chx  TYPE TABLE OF gty_likp_chx,
      gs_likp_chx  TYPE gty_likp_chx.
**************************************************

TYPES: BEGIN OF gty_likp,
         vbeln     TYPE vbeln,
         erdat     TYPE erdat,
       END OF gty_likp.

DATA: gt_likp TYPE TABLE OF gty_likp,
      gs_likp TYPE gty_likp.
**************************************************

TYPES: BEGIN OF gty_vbrk,
         vbeln TYPE vbeln,
         erdat TYPE erdat,
        " fkart TYPE fkart, " 3.  Radio-3 Seçilmişse, VBRK tablosuna VBELN ve ERDAT verilecek.
       END OF gty_vbrk.

DATA: gt_vbrk  TYPE TABLE OF gty_vbrk,
      gs_vbrk  TYPE gty_vbrk.
**************************************************
