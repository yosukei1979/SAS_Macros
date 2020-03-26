/*****************************************************************************

   SBC No： NA
     Name： m_sigdigit.sas
    Title： Convert to significant digits (Standard macro)
  Product： SAS Ver 9.2, 9.3, 9.4
   Author： Kunie Fukimbara
     Date： 2017/08/23
  In Data： NA
   Output： NA
     Misc： NONE
     Note： 

*****************************************************************************/

%macro m_sigdigit
         (num=   /* significant digit */,
          ivar=  /* input variable name (numeric) */,
          ovarn= /* output variable name (numeric) */,
          ovarc= /* output variable name (character) */,
          missc=./* missing values */);

  /*** numeric ***/
  if      &ivar eq . then &ovarn=.;                                        /* Missing */
  else if &ivar eq 0 then &ovarn=0;                                        /* 0 */
  else if int(&ivar) ne 0 then 
        &ovarn=round(&ivar,10**(int(log10(abs(&ivar)))-&num+1));           /* 1<= */
  else  &ovarn=round(&ivar,10**(-1*(abs(int(log10(abs(&ivar))))+&num)));   /* 1> */


  /*** character ***/
  if      &ovarn eq . then &ovarc="&missc";                                 /* Missing */
  else if &ovarn eq 0 then &ovarc="0";                                      /* 0 */
  else if abs(&ovarn) ge 10**(&num-1) then 
                           &ovarc=compress(put(&ovarn,best.));              /* Integer */
  else if abs(&ovarn) lt 10 then do;
    __num=ceil(-1*log10(abs(&ovarn)))+&num+1;
    if      &ovarn gt 0 then &ovarc=substr(put(&ovarn,32.15-l),1,__num);   /* 0<-<10  */
    else if &ovarn lt 0 then &ovarc=substr(put(&ovarn,32.15-l),1,__num+1); /* -10<-<0 */
  end;
  else if &ovarn gt 0 then &ovarc=substr(put(&ovarn,32.15-l),1,&num+1);    /* Other positve */
  else if &ovarn lt 0 then &ovarc=substr(put(&ovarn,32.15-l),1,&num+2);    /* Other negative */
  else;

  drop __:;

%mend m_sigdigit;

/********** End of Macro Program *******************************************/

/*****************************************************************************
  Example:

  data class2;
    set sashelp.class;
    length s_wgtc s_hgt $32.;

    %m_sigdigit(num=3, ivar=weight, ovarn=s_wgtn, ovarc=s_wgtc, missc=NC)
    %m_sigdigit(num=2, ivar=height, ovarn=s_hgtn, ovarc=s_hgtc)
  run;
*****************************************************************************/
