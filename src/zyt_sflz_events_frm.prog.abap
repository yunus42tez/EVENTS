*&---------------------------------------------------------------------*
*&  Include           ZYT_SFLZ_EVENTS_FRM
*&---------------------------------------------------------------------*

FORM prf_p_sip.
  DATA: lv_lines       TYPE i,
        lv_slines(10)  TYPE c,
        lv_tabadet(50) TYPE c.

  SELECT *
   FROM vbak
   INTO CORRESPONDING FIELDS OF TABLE gt_vbak
   WHERE vbak~vbeln IN s_vbelns
   AND   vbak~erdat IN s_erdat.



ENDFORM.

FORM prf_p_tes.
  SELECT vbeln
         erdat
         vkorg
   FROM likp
   INTO CORRESPONDING FIELDS OF TABLE gt_likp
    WHERE likp~vbeln IN s_vbelnt
    AND   likp~erdat IN s_erdat.

ENDFORM.

FORM prf_p_tes_chx.
  SELECT vbeln
         erdat
         vkorg
    FROM likp
    INTO CORRESPONDING FIELDS OF TABLE gt_likp_chx
    WHERE likp~vbeln IN s_vbelnt
    AND   likp~erdat IN s_erdat.


ENDFORM.

FORM prf_p_fat.
  SELECT vbeln
         erdat
         fkart
   FROM vbrk
   INTO CORRESPONDING FIELDS OF TABLE gt_vbrk
    WHERE vbrk~vbeln IN s_vbelnf
    AND   vbrk~erdat IN s_erdat.

ENDFORM.

FORM at_sel_screen_output_frm.

  LOOP AT SCREEN.

    IF screen-name = 'P_DATUM'.
        screen-input = sy-datum.
        MODIFY SCREEN.
      ENDIF.

    IF screen-name = 'P_LOEKZ'.
      IF p_tes EQ ' '.
        screen-active = 1.
        screen-input = 0.
        MODIFY SCREEN.
      ENDIF.


    ELSEIF p_sip EQ 'X' AND screen-group1 = 'ABC'.
      screen-active = 1.
      MODIFY SCREEN.
      CONTINUE.

    ELSEIF p_tes EQ 'X' AND screen-group1 = '123'.
      screen-active = 1.
      MODIFY SCREEN.
      CONTINUE.
    ELSEIF p_fat EQ 'X' AND screen-group1 = 'XYZ'.
      screen-active = 1.
      MODIFY SCREEN.
      CONTINUE.

    ELSEIF p_sip EQ ' ' AND screen-group1 = 'ABC'.
      screen-active = 0.
      MODIFY SCREEN.
      CONTINUE.

    ELSEIF p_tes EQ ' ' AND screen-group1 = '123'.
      screen-active = 0.
      screen-input = 0.
      MODIFY SCREEN.
      CONTINUE.

    ELSEIF p_fat EQ ' ' AND screen-group1 = 'XYZ'.
      screen-active = 0.
      MODIFY SCREEN.
      CONTINUE.

    ENDIF.

  ENDLOOP.

ENDFORM.

****************************  ALV  ***************************

FORM: pf_status_set USING extab TYPE slis_t_extab.

  SET PF-STATUS 'STANDARD'.

ENDFORM.

FORM user_command USING p_ucomm    TYPE sy-ucomm
                        p_selfield TYPE slis_selfield.

*  CASE p_ucomm.
* " uncomment when it's needed.
*  ENDCASE.

ENDFORM.

FORM set_layout.

  ls_layout-zebra    = abap_true.
  ls_layout-colwidth_optimize = abap_true.

ENDFORM.


**************************************************** VBAK
FORM call_merge_vbak.
  CALL FUNCTION 'REUSE_ALV_FIELDCATALOG_MERGE'
    EXPORTING
      i_program_name         = sy-cprog
      i_structure_name       = 'ZYT_EVENTS_STRUC_VBAK'
    CHANGING
      ct_fieldcat            = gt_fieldcat
    EXCEPTIONS
      inconsistent_interface = 1
      program_error          = 2
      OTHERS                 = 3.

ENDFORM.

FORM call_alv_grid_vbak.

  DATA: lv_lines      TYPE i,
        lv_slines(10) TYPE c,
        lv_title      TYPE lvc_title.
*** Total records
  DESCRIBE TABLE gt_vbak LINES lv_lines.
  lv_slines = lv_lines.
  CONDENSE lv_slines.
  CONCATENATE 'Toplam' lv_slines 'kayıt mevcut'
         INTO lv_title SEPARATED BY space.

  IF lv_slines = 0.
    lv_title = 'Uygun veri bulunamadı'.
  ENDIF.

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      i_callback_program       = sy-repid
      i_callback_pf_status_set = 'PF_STATUS_SET'
      i_callback_user_command  = 'USER_COMMAND'
      i_grid_title             = lv_title
      is_layout                = ls_layout
      it_fieldcat              = gt_fieldcat[]
      i_default                = 'X'
    TABLES
      t_outtab                 = gt_vbak[]
    EXCEPTIONS
      program_error            = 1
      OTHERS                   = 2.
  IF sy-subrc = 0.
    "do nothing
  ENDIF.

ENDFORM.
**************************************************** LIKP

FORM call_merge_likp.
  DATA: ls_fieldcat TYPE slis_t_fieldcat_alv WITH HEADER LINE.

  CALL FUNCTION 'REUSE_ALV_FIELDCATALOG_MERGE'
    EXPORTING
      i_program_name         = sy-cprog
      i_structure_name       = 'ZYT_EVENTS_STRUC_LIKP_CHX'
    CHANGING
      ct_fieldcat            = gt_fieldcat
    EXCEPTIONS
      inconsistent_interface = 1
      program_error          = 2
      OTHERS                 = 3.

  LOOP AT gt_fieldcat INTO ls_fieldcat .
    CASE ls_fieldcat-fieldname .
      WHEN 'VBELN'.
        ls_fieldcat-seltext_l    = 'Teslimat'.
        ls_fieldcat-outputlen    = 20.
        ls_fieldcat-col_pos      = 1.
      WHEN 'ERDAT'.
        ls_fieldcat-seltext_l    = 'Kaydın yaratıldığı tarih'.
        ls_fieldcat-outputlen    = 4.
        ls_fieldcat-col_pos      = 2.
      WHEN OTHERS.
        ls_fieldcat-no_out       = 'X'.
    ENDCASE.
    CLEAR ls_fieldcat-key.
    ls_fieldcat-seltext_m    = ls_fieldcat-seltext_l.
    ls_fieldcat-seltext_s    = ls_fieldcat-seltext_l.
    ls_fieldcat-reptext_ddic = ls_fieldcat-seltext_l.
    MODIFY gt_fieldcat FROM ls_fieldcat .
  ENDLOOP.

ENDFORM.

FORM call_alv_grid_likp.

  DATA: lv_lines      TYPE i,
        lv_slines(10) TYPE c,
        lv_title      TYPE lvc_title.
*** Total records
  DESCRIBE TABLE gt_likp LINES lv_lines.
  lv_slines = lv_lines.
  CONDENSE lv_slines.
  CONCATENATE 'Toplam' lv_slines 'kayıt mevcut'
         INTO lv_title SEPARATED BY space.

  IF lv_slines = 0.
    lv_title = 'Uygun veri bulunamadı'.
  ENDIF.

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      i_callback_program       = sy-repid
      i_callback_pf_status_set = 'PF_STATUS_SET'
      i_callback_user_command  = 'USER_COMMAND'
      i_grid_title             = lv_title
      is_layout                = ls_layout
      it_fieldcat              = gt_fieldcat[]
      i_default                = 'X'
    TABLES
      t_outtab                 = gt_likp[]
    EXCEPTIONS
      program_error            = 1
      OTHERS                   = 2.
  IF sy-subrc = 0.
    "do nothing
  ENDIF.

ENDFORM.
************************************************************* likp with checkbox parameter

FORM call_merge_likp_chx.
  CALL FUNCTION 'REUSE_ALV_FIELDCATALOG_MERGE'
    EXPORTING
      i_program_name         = sy-cprog
      i_structure_name       = 'ZYT_EVENTS_STRUC_LIKP_CHX'
    CHANGING
      ct_fieldcat            = gt_fieldcat
    EXCEPTIONS
      inconsistent_interface = 1
      program_error          = 2
      OTHERS                 = 3.

ENDFORM.

FORM call_alv_grid_likp_chx.

  DATA: lv_lines      TYPE i,
        lv_slines(10) TYPE c,
        lv_title      TYPE lvc_title.
*** Total records
  DESCRIBE TABLE gt_likp_chx LINES lv_lines.
  lv_slines = lv_lines.
  CONDENSE lv_slines.
  CONCATENATE 'Toplam' lv_slines 'kayıt mevcut'
         INTO lv_title SEPARATED BY space.

  IF lv_slines = 0.
    lv_title = 'Uygun veri bulunamadı'.
  ENDIF.

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      i_callback_program       = sy-repid
      i_callback_pf_status_set = 'PF_STATUS_SET'
      i_callback_user_command  = 'USER_COMMAND'
      i_grid_title             = lv_title
      is_layout                = ls_layout
      it_fieldcat              = gt_fieldcat[]
      i_default                = 'X'
    TABLES
      t_outtab                 = gt_likp_chx[]
    EXCEPTIONS
      program_error            = 1
      OTHERS                   = 2.
  IF sy-subrc = 0.
    "do nothing
  ENDIF.

ENDFORM.

**************************************************** VBRK

FORM call_merge_vbrk.
  CALL FUNCTION 'REUSE_ALV_FIELDCATALOG_MERGE'
    EXPORTING
      i_program_name         = sy-cprog
      i_structure_name       = 'ZYT_EVENTS_STRUC_VBRK'
    CHANGING
      ct_fieldcat            = gt_fieldcat
    EXCEPTIONS
      inconsistent_interface = 1
      program_error          = 2
      OTHERS                 = 3.

ENDFORM.


FORM call_alv_grid_vbrk.

  DATA: lv_lines      TYPE i,
        lv_slines(10) TYPE c,
        lv_title      TYPE lvc_title.
*** Total records
  DESCRIBE TABLE gt_vbrk LINES lv_lines.
  lv_slines = lv_lines.
  CONDENSE lv_slines.
  CONCATENATE 'Toplam' lv_slines 'kayıt mevcut'
         INTO lv_title SEPARATED BY space.

  IF lv_slines = 0.
    lv_title = 'Uygun veri bulunamadı'.
  ENDIF.

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      i_callback_program       = sy-repid
      i_callback_pf_status_set = 'PF_STATUS_SET'
      i_callback_user_command  = 'USER_COMMAND'
      i_grid_title             = lv_title
      is_layout                = ls_layout
      it_fieldcat              = gt_fieldcat[]
      i_default                = 'X'
    TABLES
      t_outtab                 = gt_vbrk[]
    EXCEPTIONS
      program_error            = 1
      OTHERS                   = 2.
  IF sy-subrc = 0.
    "do nothing
  ENDIF.

ENDFORM.
