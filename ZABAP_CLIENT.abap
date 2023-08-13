*&---------------------------------------------------------------------*
*& Report ZABAP_CLIENT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zabap_client.

*CONSTANTS c_url TYPE string VALUE 'http://127.0.0.1:50001/sap/opu/odata/SAP/ZOD_TOTP_GENERATOR2_SRV/getTotpSet'.
DATA(l_url) = |https://vhcala4hci:50001/sap/opu/odata/SAP/ZOD_TOTP_GENERATOR2_SRV/getTotpSet(SecurityKey=| &&
           |'JBSWY3DPEHPK3PXP',otplLen=10,tokenExpirey=30)|.
cl_http_client=>create_by_url(
  EXPORTING
    url                        = l_url "'https://services.odata.org/northwind/northwind.svc/Products?$format=json'      " URL
*    ssl_id                     = 'DEFAULT'
  IMPORTING
    client                     =  DATA(lo_client)                " HTTP Client Abstraction
  EXCEPTIONS
    argument_not_found         = 1                " Communication parameter (host or service) not available
    plugin_not_active          = 2                " HTTP/HTTPS communication not available
    internal_error             = 3                " Internal error (e.g. name too long)
    pse_not_found              = 4                " PSE not found
    pse_not_distrib            = 5                " PSE not distributed
    pse_errors                 = 6                " General PSE error
    oa2c_set_token_error       = 7                " General error when setting the OAuth token
    oa2c_missing_authorization = 8
    oa2c_invalid_config        = 9
    oa2c_invalid_parameters    = 10
    oa2c_invalid_scope         = 11
    oa2c_invalid_grant         = 12
    OTHERS                     = 13
).
IF sy-subrc EQ 0 AND lo_client IS BOUND.

*---Authenticating with BASIC Authentication process
  lo_client->authenticate(
    EXPORTING
      username             = 'DEVELOPER'                 " ABAP System, User Logon Name
      password             = 'Htods70334'               " Logon ID
      language             =  sy-langu             " SAP System, Current Language
  ).

*---Prepare the Data payload
  CONSTANTS c_data TYPE string VALUE '{ "SecurityKey": "JBSWY3DPEHPK3PXP",otplLen": 10, tokenExpirey": 30 }'.

*--Set HTTP Method as POST
  lo_client->request->set_method(
      method = if_http_request=>co_request_method_get
  ).

*  lo_client->request->set_cdata(
*    EXPORTING
*      data   =    c_data              " Character data
**      offset = 0                " Offset into character data
**      length = -1               " Length of character data
*  ).

  lo_client->request->set_header_field(
    EXPORTING
      name  =  'accept'                " Name of the header field
      value =   'application/json'               " HTTP header field value
  ).
  lo_client->send(
*  EXPORTING
*    timeout                    = co_timeout_default " Timeout of Answer Waiting Time
    EXCEPTIONS
      http_communication_failure = 1                  " Communication Error
      http_invalid_state         = 2                  " Invalid state
      http_processing_failed     = 3                  " Error when processing method
      http_invalid_timeout       = 4                  " Invalid Time Entry
      OTHERS                     = 5
  ).
  IF sy-subrc <> 0.
* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*   WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
  ENDIF.

*---Cache the result
  lo_client->receive(
    EXCEPTIONS
      http_communication_failure = 1                " Communication Error
      http_invalid_state         = 2                " Invalid state
      http_processing_failed     = 3                " Error when processing method
      OTHERS                     = 4
  ).
  IF sy-subrc <> 0.
*   MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*     WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
  ENDIF.

  DATA(l_stream) = lo_client->response->get_cdata( ).
  lo_client->close( ).
ENDIF.
