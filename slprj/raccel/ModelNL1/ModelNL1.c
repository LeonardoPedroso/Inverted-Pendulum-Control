#include "__cf_ModelNL1.h"
#include "rt_logging_mmi.h"
#include "ModelNL1_capi.h"
#include <math.h>
#include "ModelNL1.h"
#include "ModelNL1_private.h"
#include "ModelNL1_dt.h"
extern void * CreateDiagnosticAsVoidPtr_wrapper ( const char * id , int nargs
, ... ) ; RTWExtModeInfo * gblRTWExtModeInfo = NULL ; extern boolean_T
gblExtModeStartPktReceived ; void raccelForceExtModeShutdown ( ) { if ( !
gblExtModeStartPktReceived ) { boolean_T stopRequested = false ;
rtExtModeWaitForStartPkt ( gblRTWExtModeInfo , 2 , & stopRequested ) ; }
rtExtModeShutdown ( 2 ) ; }
#include "slsv_diagnostic_codegen_c_api.h"
const int_T gblNumToFiles = 0 ; const int_T gblNumFrFiles = 0 ; const int_T
gblNumFrWksBlocks = 0 ;
#ifdef RSIM_WITH_SOLVER_MULTITASKING
boolean_T gbl_raccel_isMultitasking = 1 ;
#else
boolean_T gbl_raccel_isMultitasking = 0 ;
#endif
boolean_T gbl_raccel_tid01eq = 0 ; int_T gbl_raccel_NumST = 2 ; const char_T
* gbl_raccel_Version = "8.14 (R2018a) 06-Feb-2018" ; void
raccel_setup_MMIStateLog ( SimStruct * S ) {
#ifdef UseMMIDataLogging
rt_FillStateSigInfoFromMMI ( ssGetRTWLogInfo ( S ) , & ssGetErrorStatus ( S )
) ;
#else
UNUSED_PARAMETER ( S ) ;
#endif
} static DataMapInfo rt_dataMapInfo ; DataMapInfo * rt_dataMapInfoPtr = &
rt_dataMapInfo ; rtwCAPI_ModelMappingInfo * rt_modelMapInfoPtr = & (
rt_dataMapInfo . mmi ) ; const char * gblSlvrJacPatternFileName =
"slprj//raccel//ModelNL1//ModelNL1_Jpattern.mat" ; const int_T
gblNumRootInportBlks = 0 ; const int_T gblNumModelInputs = 0 ; extern
rtInportTUtable * gblInportTUtables ; extern const char * gblInportFileName ;
const int_T gblInportDataTypeIdx [ ] = { - 1 } ; const int_T gblInportDims [
] = { - 1 } ; const int_T gblInportComplex [ ] = { - 1 } ; const int_T
gblInportInterpoFlag [ ] = { - 1 } ; const int_T gblInportContinuous [ ] = {
- 1 } ;
#include "simstruc.h"
#include "fixedpoint.h"
B rtB ; X rtX ; DW rtDW ; static SimStruct model_S ; SimStruct * const rtS =
& model_S ; real_T rt_urand_Upu32_Yd_f_pw_snf ( uint32_T * u ) { uint32_T lo
; uint32_T hi ; lo = * u % 127773U * 16807U ; hi = * u / 127773U * 2836U ; if
( lo < hi ) { * u = 2147483647U - ( hi - lo ) ; } else { * u = lo - hi ; }
return ( real_T ) * u * 4.6566128752457969E-10 ; } real_T
rt_nrand_Upu32_Yd_f_pw_snf ( uint32_T * u ) { real_T y ; real_T sr ; real_T
si ; do { sr = 2.0 * rt_urand_Upu32_Yd_f_pw_snf ( u ) - 1.0 ; si = 2.0 *
rt_urand_Upu32_Yd_f_pw_snf ( u ) - 1.0 ; si = sr * sr + si * si ; } while (
si > 1.0 ) ; y = muDoubleScalarSqrt ( - 2.0 * muDoubleScalarLog ( si ) / si )
* sr ; return y ; } void MdlInitialize ( void ) { uint32_T tseed ; int32_T t
; int32_T i ; real_T tmp ; for ( i = 0 ; i < 5 ; i ++ ) { rtX . c4x4tqbsqk [
i ] = rtP . FilterController_InitialCondition ; } tmp = muDoubleScalarFloor (
rtP . Sensornoise_seed ) ; if ( muDoubleScalarIsNaN ( tmp ) ||
muDoubleScalarIsInf ( tmp ) ) { tmp = 0.0 ; } else { tmp = muDoubleScalarRem
( tmp , 4.294967296E+9 ) ; } tseed = tmp < 0.0 ? ( uint32_T ) - ( int32_T ) (
uint32_T ) - tmp : ( uint32_T ) tmp ; i = ( int32_T ) ( tseed >> 16U ) ; t =
( int32_T ) ( tseed & 32768U ) ; tseed = ( ( ( ( tseed - ( ( uint32_T ) i <<
16U ) ) + t ) << 16U ) + t ) + i ; if ( tseed < 1U ) { tseed = 1144108930U ;
} else { if ( tseed > 2147483646U ) { tseed = 2147483646U ; } } rtDW .
adzig2ij22 = tseed ; rtDW . dkn4fg52aj = rt_nrand_Upu32_Yd_f_pw_snf ( & rtDW
. adzig2ij22 ) * rtP . WhiteNoise_StdDev + rtP . WhiteNoise_Mean ; for ( i =
0 ; i < 5 ; i ++ ) { rtX . hfyhsjwpyb [ i ] = rtP . x0 [ i ] ; } tmp =
muDoubleScalarFloor ( rtP . Processnoise_seed ) ; if ( muDoubleScalarIsNaN (
tmp ) || muDoubleScalarIsInf ( tmp ) ) { tmp = 0.0 ; } else { tmp =
muDoubleScalarRem ( tmp , 4.294967296E+9 ) ; } tseed = tmp < 0.0 ? ( uint32_T
) - ( int32_T ) ( uint32_T ) - tmp : ( uint32_T ) tmp ; i = ( int32_T ) (
tseed >> 16U ) ; t = ( int32_T ) ( tseed & 32768U ) ; tseed = ( ( ( ( tseed -
( ( uint32_T ) i << 16U ) ) + t ) << 16U ) + t ) + i ; if ( tseed < 1U ) {
tseed = 1144108930U ; } else { if ( tseed > 2147483646U ) { tseed =
2147483646U ; } } rtDW . o12rynloaq = tseed ; rtDW . cmwdnci4fp =
rt_nrand_Upu32_Yd_f_pw_snf ( & rtDW . o12rynloaq ) * rtP .
WhiteNoise_StdDev_gil0pjs1r0 + rtP . WhiteNoise_Mean_jbwmptnndg ; } void
MdlStart ( void ) { { void * * slioCatalogueAddr = rt_slioCatalogueAddr ( ) ;
void * r2 = ( NULL ) ; void * * pOSigstreamManagerAddr = ( NULL ) ; const int
maxErrorBufferSize = 16384 ; char errMsgCreatingOSigstreamManager [ 16384 ] ;
bool errorCreatingOSigstreamManager = false ; const char *
errorAddingR2SharedResource = ( NULL ) ; * slioCatalogueAddr =
rtwGetNewSlioCatalogue ( rt_GetMatSigLogSelectorFileName ( ) ) ;
errorAddingR2SharedResource = rtwAddR2SharedResource (
rtwGetPointerFromUniquePtr ( rt_slioCatalogue ( ) ) , 1 ) ; if (
errorAddingR2SharedResource != ( NULL ) ) { rtwTerminateSlioCatalogue (
slioCatalogueAddr ) ; * slioCatalogueAddr = ( NULL ) ; ssSetErrorStatus ( rtS
, errorAddingR2SharedResource ) ; return ; } r2 = rtwGetR2SharedResource (
rtwGetPointerFromUniquePtr ( rt_slioCatalogue ( ) ) ) ;
pOSigstreamManagerAddr = rt_GetOSigstreamManagerAddr ( ) ;
errorCreatingOSigstreamManager = rtwOSigstreamManagerCreateInstance (
rt_GetMatSigLogSelectorFileName ( ) , r2 , pOSigstreamManagerAddr ,
errMsgCreatingOSigstreamManager , maxErrorBufferSize ) ; if (
errorCreatingOSigstreamManager ) { * pOSigstreamManagerAddr = ( NULL ) ;
ssSetErrorStatus ( rtS , errMsgCreatingOSigstreamManager ) ; return ; } } {
bool externalInputIsInDatasetFormat = false ; void * pISigstreamManager =
rt_GetISigstreamManager ( ) ; rtwISigstreamManagerGetInputIsInDatasetFormat (
pISigstreamManager , & externalInputIsInDatasetFormat ) ; if (
externalInputIsInDatasetFormat ) { } } { int_T dimensions [ 1 ] = { 1 } ;
rtDW . e53ltkhquw . LoggedData = rt_CreateLogVar ( ssGetRTWLogInfo ( rtS ) ,
ssGetTStart ( rtS ) , ssGetTFinal ( rtS ) , 0.0 , ( & ssGetErrorStatus ( rtS
) ) , "t" , SS_DOUBLE , 0 , 0 , 0 , 1 , 1 , dimensions , NO_LOGVALDIMS , (
NULL ) , ( NULL ) , 0 , 1 , 0.0 , 1 ) ; if ( rtDW . e53ltkhquw . LoggedData
== ( NULL ) ) return ; } { int_T dimensions [ 1 ] = { 2 } ; rtDW . kblfnc4axa
. LoggedData = rt_CreateLogVar ( ssGetRTWLogInfo ( rtS ) , ssGetTStart ( rtS
) , ssGetTFinal ( rtS ) , 0.0 , ( & ssGetErrorStatus ( rtS ) ) , "y" ,
SS_DOUBLE , 0 , 0 , 0 , 2 , 1 , dimensions , NO_LOGVALDIMS , ( NULL ) , (
NULL ) , 0 , 1 , 0.0 , 1 ) ; if ( rtDW . kblfnc4axa . LoggedData == ( NULL )
) return ; } { int_T dimensions [ 1 ] = { 1 } ; rtDW . a2qe00s2c4 .
LoggedData = rt_CreateLogVar ( ssGetRTWLogInfo ( rtS ) , ssGetTStart ( rtS )
, ssGetTFinal ( rtS ) , 0.0 , ( & ssGetErrorStatus ( rtS ) ) , "u" ,
SS_DOUBLE , 0 , 0 , 0 , 1 , 1 , dimensions , NO_LOGVALDIMS , ( NULL ) , (
NULL ) , 0 , 1 , 0.0 , 1 ) ; if ( rtDW . a2qe00s2c4 . LoggedData == ( NULL )
) return ; } { int_T dimensions [ 1 ] = { 5 } ; rtDW . grbgwcl0c1 .
LoggedData = rt_CreateLogVar ( ssGetRTWLogInfo ( rtS ) , ssGetTStart ( rtS )
, ssGetTFinal ( rtS ) , 0.0 , ( & ssGetErrorStatus ( rtS ) ) , "x_hat" ,
SS_DOUBLE , 0 , 0 , 0 , 5 , 1 , dimensions , NO_LOGVALDIMS , ( NULL ) , (
NULL ) , 0 , 1 , 0.0 , 1 ) ; if ( rtDW . grbgwcl0c1 . LoggedData == ( NULL )
) return ; } { int_T dimensions [ 1 ] = { 5 } ; rtDW . a4xqeoyrdf .
LoggedData = rt_CreateLogVar ( ssGetRTWLogInfo ( rtS ) , ssGetTStart ( rtS )
, ssGetTFinal ( rtS ) , 0.0 , ( & ssGetErrorStatus ( rtS ) ) , "x" ,
SS_DOUBLE , 0 , 0 , 0 , 5 , 1 , dimensions , NO_LOGVALDIMS , ( NULL ) , (
NULL ) , 0 , 1 , 0.0 , 1 ) ; if ( rtDW . a4xqeoyrdf . LoggedData == ( NULL )
) return ; } MdlInitialize ( ) ; } void MdlOutputs ( int_T tid ) { int_T ci ;
real_T x ; real_T b_x ; real_T e_x ; real_T jlok54d30a [ 5 ] ; int32_T i ;
rtB . hf03wwvg4y = ssGetT ( rtS ) ; if ( ssGetLogOutput ( rtS ) ) { { double
locTime = ssGetTaskTime ( rtS , 0 ) ; ; if ( rtwTimeInLoggingInterval (
rtliGetLoggingInterval ( ssGetRootSS ( rtS ) -> mdlInfo -> rtwLogInfo ) ,
locTime ) ) { rt_UpdateLogVar ( ( LogVar * ) ( LogVar * ) ( rtDW . e53ltkhquw
. LoggedData ) , & rtB . hf03wwvg4y , 0 ) ; } } } for ( i = 0 ; i < 6 ; i ++
) { rtB . fj1kgzlwxo [ i ] = 0.0 ; for ( ci = 0 ; ci < 5 ; ci ++ ) { rtB .
fj1kgzlwxo [ i ] += rtP . FilterController_C [ ci * 6 + i ] * rtX .
c4x4tqbsqk [ ci ] ; } } if ( ssIsMajorTimeStep ( rtS ) ) { rtDW . jeegs1ty2y
= rtB . fj1kgzlwxo [ 0 ] >= rtP . saturation_u ? 1 : rtB . fj1kgzlwxo [ 0 ] >
- rtP . saturation_u ? 0 : - 1 ; } rtB . llt4m2mj32 = rtDW . jeegs1ty2y == 1
? rtP . saturation_u : rtDW . jeegs1ty2y == - 1 ? - rtP . saturation_u : rtB
. fj1kgzlwxo [ 0 ] ; if ( ssIsMajorTimeStep ( rtS ) ) { if ( rtB . llt4m2mj32
> rtP . deadzone_u ) { rtDW . ms0qcgqyqt = 1 ; } else if ( rtB . llt4m2mj32
>= - rtP . deadzone_u ) { rtDW . ms0qcgqyqt = 0 ; } else { rtDW . ms0qcgqyqt
= - 1 ; } } if ( rtDW . ms0qcgqyqt == 1 ) { rtB . aqt01x2wia = rtB .
llt4m2mj32 - rtP . deadzone_u ; } else if ( rtDW . ms0qcgqyqt == - 1 ) { rtB
. aqt01x2wia = rtB . llt4m2mj32 - ( - rtP . deadzone_u ) ; } else { rtB .
aqt01x2wia = 0.0 ; } if ( ssIsSampleHit ( rtS , 1 , 0 ) ) { rtB . mc4nvtgkuz
[ 0 ] = muDoubleScalarSqrt ( 0.00032399999999999996 * rtP . tc ) /
0.0092332839219554375 * rtDW . dkn4fg52aj ; rtB . mc4nvtgkuz [ 1 ] =
muDoubleScalarSqrt ( 0.00032399999999999996 * rtP . tc ) /
0.0092332839219554375 * rtDW . dkn4fg52aj ; } for ( i = 0 ; i < 5 ; i ++ ) {
rtB . pymeihwtkd [ i ] = rtX . hfyhsjwpyb [ i ] ; } for ( i = 0 ; i < 2 ; i
++ ) { rtB . g0pxyhjufo [ i ] = 0.0 ; for ( ci = 0 ; ci < 5 ; ci ++ ) { rtB .
g0pxyhjufo [ i ] += rtP . C [ ( ci << 1 ) + i ] * rtB . pymeihwtkd [ ci ] ; }
rtB . lj23mto5sg [ i ] = rtB . mc4nvtgkuz [ i ] + rtB . g0pxyhjufo [ i ] ; }
if ( ssGetLogOutput ( rtS ) ) { { double locTime = ssGetTaskTime ( rtS , 0 )
; ; if ( rtwTimeInLoggingInterval ( rtliGetLoggingInterval ( ssGetRootSS (
rtS ) -> mdlInfo -> rtwLogInfo ) , locTime ) ) { rt_UpdateLogVar ( ( LogVar *
) ( LogVar * ) ( rtDW . kblfnc4axa . LoggedData ) , & rtB . lj23mto5sg [ 0 ]
, 0 ) ; } } } if ( ssGetLogOutput ( rtS ) ) { { double locTime =
ssGetTaskTime ( rtS , 0 ) ; ; if ( rtwTimeInLoggingInterval (
rtliGetLoggingInterval ( ssGetRootSS ( rtS ) -> mdlInfo -> rtwLogInfo ) ,
locTime ) ) { rt_UpdateLogVar ( ( LogVar * ) ( LogVar * ) ( rtDW . a2qe00s2c4
. LoggedData ) , & rtB . aqt01x2wia , 0 ) ; } } } if ( ssGetLogOutput ( rtS )
) { { double locTime = ssGetTaskTime ( rtS , 0 ) ; ; if (
rtwTimeInLoggingInterval ( rtliGetLoggingInterval ( ssGetRootSS ( rtS ) ->
mdlInfo -> rtwLogInfo ) , locTime ) ) { rt_UpdateLogVar ( ( LogVar * ) (
LogVar * ) ( rtDW . grbgwcl0c1 . LoggedData ) , & rtB . fj1kgzlwxo [ 1 ] , 0
) ; } } } if ( ssGetLogOutput ( rtS ) ) { { double locTime = ssGetTaskTime (
rtS , 0 ) ; ; if ( rtwTimeInLoggingInterval ( rtliGetLoggingInterval (
ssGetRootSS ( rtS ) -> mdlInfo -> rtwLogInfo ) , locTime ) ) {
rt_UpdateLogVar ( ( LogVar * ) ( LogVar * ) ( rtDW . a4xqeoyrdf . LoggedData
) , & rtB . pymeihwtkd [ 0 ] , 0 ) ; } } } if ( ssIsSampleHit ( rtS , 1 , 0 )
) { for ( i = 0 ; i < 5 ; i ++ ) { rtB . kdi2evssze [ i ] =
muDoubleScalarSqrt ( rtConstP . eawrrtojai [ i ] * rtP . tc ) /
0.0092332839219554375 * rtDW . cmwdnci4fp ; } } jlok54d30a [ 0 ] = rtB .
pymeihwtkd [ 1 ] ; x = muDoubleScalarCos ( rtB . pymeihwtkd [ 2 ] ) ; b_x =
muDoubleScalarSin ( rtB . pymeihwtkd [ 2 ] ) ; jlok54d30a [ 1 ] = ( ( (
0.056740000000000006 * rtB . pymeihwtkd [ 1 ] * muDoubleScalarCos ( rtB .
pymeihwtkd [ 2 ] ) + 0.028337772000000004 * rtB . pymeihwtkd [ 3 ] ) * rtB .
pymeihwtkd [ 3 ] * muDoubleScalarSin ( rtB . pymeihwtkd [ 2 ] ) + ( 0.001 *
rtB . pymeihwtkd [ 1 ] - 3.377 * rtB . pymeihwtkd [ 4 ] ) ) * -
0.028370000000000003 + ( ( rtB . pymeihwtkd [ 1 ] * rtB . pymeihwtkd [ 1 ] *
0.028370000000000003 * muDoubleScalarCos ( rtB . pymeihwtkd [ 2 ] ) +
1.22464116 ) * muDoubleScalarSin ( rtB . pymeihwtkd [ 2 ] ) + -
0.00013600000000000003 * rtB . pymeihwtkd [ 3 ] ) * ( 0.028337772000000004 *
muDoubleScalarCos ( rtB . pymeihwtkd [ 2 ] ) ) ) / ( ( b_x * b_x *
0.028370000000000003 + 0.08698 ) * 0.028370000000000003 + x * x * -
0.00080302932192398424 ) ; jlok54d30a [ 2 ] = rtB . pymeihwtkd [ 3 ] ; x =
muDoubleScalarSin ( rtB . pymeihwtkd [ 2 ] ) ; b_x = muDoubleScalarCos ( rtB
. pymeihwtkd [ 2 ] ) ; e_x = muDoubleScalarSin ( rtB . pymeihwtkd [ 2 ] ) ;
jlok54d30a [ 3 ] = ( ( ( ( rtB . pymeihwtkd [ 1 ] * rtB . pymeihwtkd [ 1 ] *
- 0.0024676226000000002 + rtB . pymeihwtkd [ 3 ] * rtB . pymeihwtkd [ 3 ] *
0.00080302932192398424 ) * muDoubleScalarSin ( rtB . pymeihwtkd [ 2 ] ) - rtB
. pymeihwtkd [ 1 ] * rtB . pymeihwtkd [ 1 ] * 0.00080485690000000015 *
muDoubleScalarPower ( muDoubleScalarSin ( rtB . pymeihwtkd [ 2 ] ) , 3.0 ) )
+ ( 0.028370000000000003 * rtB . pymeihwtkd [ 1 ] * rtB . pymeihwtkd [ 3 ] *
muDoubleScalarSin ( 2.0 * rtB . pymeihwtkd [ 2 ] ) + ( 0.001 * rtB .
pymeihwtkd [ 1 ] - 3.377 * rtB . pymeihwtkd [ 4 ] ) ) * 0.028337772000000004
) * muDoubleScalarCos ( rtB . pymeihwtkd [ 2 ] ) + ( 1.1829280000000002E-5 *
rtB . pymeihwtkd [ 3 ] - ( x * x * 0.028370000000000003 + 0.08698 ) * (
1.22464116 * muDoubleScalarSin ( rtB . pymeihwtkd [ 2 ] ) ) ) ) / ( b_x * b_x
* 0.00080302932192398424 - ( e_x * e_x * 0.028370000000000003 + 0.08698 ) *
0.028370000000000003 ) ; jlok54d30a [ 4 ] = ( ( - 0.696 * rtB . pymeihwtkd [
1 ] - 2.266 * rtB . pymeihwtkd [ 4 ] ) + rtB . aqt01x2wia ) / 0.003 ; for ( i
= 0 ; i < 5 ; i ++ ) { rtB . c2etqfm0d3 [ i ] = rtB . kdi2evssze [ i ] +
jlok54d30a [ i ] ; } UNUSED_PARAMETER ( tid ) ; } void MdlUpdate ( int_T tid
) { if ( ssIsSampleHit ( rtS , 1 , 0 ) ) { rtDW . dkn4fg52aj =
rt_nrand_Upu32_Yd_f_pw_snf ( & rtDW . adzig2ij22 ) * rtP . WhiteNoise_StdDev
+ rtP . WhiteNoise_Mean ; rtDW . cmwdnci4fp = rt_nrand_Upu32_Yd_f_pw_snf ( &
rtDW . o12rynloaq ) * rtP . WhiteNoise_StdDev_gil0pjs1r0 + rtP .
WhiteNoise_Mean_jbwmptnndg ; } UNUSED_PARAMETER ( tid ) ; } void
MdlDerivatives ( void ) { int_T is ; int_T ci ; XDot * _rtXdot ; _rtXdot = (
( XDot * ) ssGetdX ( rtS ) ) ; for ( is = 0 ; is < 5 ; is ++ ) { _rtXdot ->
c4x4tqbsqk [ is ] = 0.0 ; for ( ci = 0 ; ci < 5 ; ci ++ ) { _rtXdot ->
c4x4tqbsqk [ is ] += rtP . V [ ci * 5 + is ] * rtX . c4x4tqbsqk [ ci ] ; }
_rtXdot -> c4x4tqbsqk [ is ] += rtP . L [ is ] * rtB . lj23mto5sg [ 0 ] ;
_rtXdot -> c4x4tqbsqk [ is ] += rtP . L [ 5 + is ] * rtB . lj23mto5sg [ 1 ] ;
_rtXdot -> hfyhsjwpyb [ is ] = rtB . c2etqfm0d3 [ is ] ; } } void
MdlProjection ( void ) { } void MdlZeroCrossings ( void ) { ZCV * _rtZCSV ;
_rtZCSV = ( ( ZCV * ) ssGetSolverZcSignalVector ( rtS ) ) ; _rtZCSV ->
eypjjfh2kj = rtB . fj1kgzlwxo [ 0 ] - rtP . saturation_u ; _rtZCSV ->
bq32l0uslm = rtB . fj1kgzlwxo [ 0 ] - ( - rtP . saturation_u ) ; _rtZCSV ->
aqzzwpjzn0 = rtB . llt4m2mj32 - ( - rtP . deadzone_u ) ; _rtZCSV ->
kyggoqmkvl = rtB . llt4m2mj32 - rtP . deadzone_u ; } void MdlTerminate ( void
) { if ( rt_slioCatalogue ( ) != ( NULL ) ) { void * * slioCatalogueAddr =
rt_slioCatalogueAddr ( ) ; rtwSaveDatasetsToMatFile (
rtwGetPointerFromUniquePtr ( rt_slioCatalogue ( ) ) ,
rt_GetMatSigstreamLoggingFileName ( ) ) ; rtwTerminateSlioCatalogue (
slioCatalogueAddr ) ; * slioCatalogueAddr = NULL ; } } void
MdlInitializeSizes ( void ) { ssSetNumContStates ( rtS , 10 ) ;
ssSetNumPeriodicContStates ( rtS , 0 ) ; ssSetNumY ( rtS , 0 ) ; ssSetNumU (
rtS , 0 ) ; ssSetDirectFeedThrough ( rtS , 0 ) ; ssSetNumSampleTimes ( rtS ,
2 ) ; ssSetNumBlocks ( rtS , 21 ) ; ssSetNumBlockIO ( rtS , 10 ) ;
ssSetNumBlockParams ( rtS , 90 ) ; } void MdlInitializeSampleTimes ( void ) {
ssSetSampleTime ( rtS , 0 , 0.0 ) ; ssSetSampleTime ( rtS , 1 ,
8.52535319834408E-5 ) ; ssSetOffsetTime ( rtS , 0 , 0.0 ) ; ssSetOffsetTime (
rtS , 1 , 0.0 ) ; } void raccel_set_checksum ( ) { ssSetChecksumVal ( rtS , 0
, 4012338573U ) ; ssSetChecksumVal ( rtS , 1 , 4251839847U ) ;
ssSetChecksumVal ( rtS , 2 , 452829803U ) ; ssSetChecksumVal ( rtS , 3 ,
1755867169U ) ; }
#if defined(_MSC_VER)
#pragma optimize( "", off )
#endif
SimStruct * raccel_register_model ( void ) { static struct _ssMdlInfo mdlInfo
; ( void ) memset ( ( char * ) rtS , 0 , sizeof ( SimStruct ) ) ; ( void )
memset ( ( char * ) & mdlInfo , 0 , sizeof ( struct _ssMdlInfo ) ) ;
ssSetMdlInfoPtr ( rtS , & mdlInfo ) ; { static time_T mdlPeriod [
NSAMPLE_TIMES ] ; static time_T mdlOffset [ NSAMPLE_TIMES ] ; static time_T
mdlTaskTimes [ NSAMPLE_TIMES ] ; static int_T mdlTsMap [ NSAMPLE_TIMES ] ;
static int_T mdlSampleHits [ NSAMPLE_TIMES ] ; static boolean_T
mdlTNextWasAdjustedPtr [ NSAMPLE_TIMES ] ; static int_T mdlPerTaskSampleHits
[ NSAMPLE_TIMES * NSAMPLE_TIMES ] ; static time_T mdlTimeOfNextSampleHit [
NSAMPLE_TIMES ] ; { int_T i ; for ( i = 0 ; i < NSAMPLE_TIMES ; i ++ ) {
mdlPeriod [ i ] = 0.0 ; mdlOffset [ i ] = 0.0 ; mdlTaskTimes [ i ] = 0.0 ;
mdlTsMap [ i ] = i ; mdlSampleHits [ i ] = 1 ; } } ssSetSampleTimePtr ( rtS ,
& mdlPeriod [ 0 ] ) ; ssSetOffsetTimePtr ( rtS , & mdlOffset [ 0 ] ) ;
ssSetSampleTimeTaskIDPtr ( rtS , & mdlTsMap [ 0 ] ) ; ssSetTPtr ( rtS , &
mdlTaskTimes [ 0 ] ) ; ssSetSampleHitPtr ( rtS , & mdlSampleHits [ 0 ] ) ;
ssSetTNextWasAdjustedPtr ( rtS , & mdlTNextWasAdjustedPtr [ 0 ] ) ;
ssSetPerTaskSampleHitsPtr ( rtS , & mdlPerTaskSampleHits [ 0 ] ) ;
ssSetTimeOfNextSampleHitPtr ( rtS , & mdlTimeOfNextSampleHit [ 0 ] ) ; }
ssSetSolverMode ( rtS , SOLVER_MODE_SINGLETASKING ) ; { ssSetBlockIO ( rtS ,
( ( void * ) & rtB ) ) ; ( void ) memset ( ( ( void * ) & rtB ) , 0 , sizeof
( B ) ) ; } ssSetDefaultParam ( rtS , ( real_T * ) & rtP ) ; { real_T * x = (
real_T * ) & rtX ; ssSetContStates ( rtS , x ) ; ( void ) memset ( ( void * )
x , 0 , sizeof ( X ) ) ; } { void * dwork = ( void * ) & rtDW ;
ssSetRootDWork ( rtS , dwork ) ; ( void ) memset ( dwork , 0 , sizeof ( DW )
) ; } { static DataTypeTransInfo dtInfo ; ( void ) memset ( ( char_T * ) &
dtInfo , 0 , sizeof ( dtInfo ) ) ; ssSetModelMappingInfo ( rtS , & dtInfo ) ;
dtInfo . numDataTypes = 15 ; dtInfo . dataTypeSizes = & rtDataTypeSizes [ 0 ]
; dtInfo . dataTypeNames = & rtDataTypeNames [ 0 ] ; dtInfo . BTransTable = &
rtBTransTable ; dtInfo . PTransTable = & rtPTransTable ; }
ModelNL1_InitializeDataMapInfo ( ) ; ssSetIsRapidAcceleratorActive ( rtS ,
true ) ; ssSetRootSS ( rtS , rtS ) ; ssSetVersion ( rtS ,
SIMSTRUCT_VERSION_LEVEL2 ) ; ssSetModelName ( rtS , "ModelNL1" ) ; ssSetPath
( rtS , "ModelNL1" ) ; ssSetTStart ( rtS , 0.0 ) ; ssSetTFinal ( rtS , 10.0 )
; { static RTWLogInfo rt_DataLoggingInfo ; rt_DataLoggingInfo .
loggingInterval = NULL ; ssSetRTWLogInfo ( rtS , & rt_DataLoggingInfo ) ; } {
rtliSetLogXSignalInfo ( ssGetRTWLogInfo ( rtS ) , ( NULL ) ) ;
rtliSetLogXSignalPtrs ( ssGetRTWLogInfo ( rtS ) , ( NULL ) ) ; rtliSetLogT (
ssGetRTWLogInfo ( rtS ) , "tout" ) ; rtliSetLogX ( ssGetRTWLogInfo ( rtS ) ,
"" ) ; rtliSetLogXFinal ( ssGetRTWLogInfo ( rtS ) , "" ) ;
rtliSetLogVarNameModifier ( ssGetRTWLogInfo ( rtS ) , "none" ) ;
rtliSetLogFormat ( ssGetRTWLogInfo ( rtS ) , 4 ) ; rtliSetLogMaxRows (
ssGetRTWLogInfo ( rtS ) , 0 ) ; rtliSetLogDecimation ( ssGetRTWLogInfo ( rtS
) , 1 ) ; rtliSetLogY ( ssGetRTWLogInfo ( rtS ) , "" ) ;
rtliSetLogYSignalInfo ( ssGetRTWLogInfo ( rtS ) , ( NULL ) ) ;
rtliSetLogYSignalPtrs ( ssGetRTWLogInfo ( rtS ) , ( NULL ) ) ; } { static
struct _ssStatesInfo2 statesInfo2 ; ssSetStatesInfo2 ( rtS , & statesInfo2 )
; } { static ssPeriodicStatesInfo periodicStatesInfo ;
ssSetPeriodicStatesInfo ( rtS , & periodicStatesInfo ) ; } { static
ssSolverInfo slvrInfo ; static boolean_T contStatesDisabled [ 10 ] ; static
real_T absTol [ 10 ] = { 1.0E-6 , 1.0E-6 , 1.0E-6 , 1.0E-6 , 1.0E-6 , 1.0E-6
, 1.0E-6 , 1.0E-6 , 1.0E-6 , 1.0E-6 } ; static uint8_T absTolControl [ 10 ] =
{ 0U , 0U , 0U , 0U , 0U , 0U , 0U , 0U , 0U , 0U } ; static uint8_T
zcAttributes [ 4 ] = { ( ZC_EVENT_ALL ) , ( ZC_EVENT_ALL ) , ( ZC_EVENT_ALL )
, ( ZC_EVENT_ALL ) } ; static ssNonContDerivSigInfo nonContDerivSigInfo [ 2 ]
= { { 5 * sizeof ( real_T ) , ( char * ) ( & rtB . kdi2evssze [ 0 ] ) , (
NULL ) } , { 2 * sizeof ( real_T ) , ( char * ) ( & rtB . mc4nvtgkuz [ 0 ] )
, ( NULL ) } } ; ssSetSolverRelTol ( rtS , 0.001 ) ; ssSetStepSize ( rtS ,
0.0 ) ; ssSetMinStepSize ( rtS , 0.0 ) ; ssSetMaxNumMinSteps ( rtS , - 1 ) ;
ssSetMinStepViolatedError ( rtS , 0 ) ; ssSetMaxStepSize ( rtS ,
8.52535319834408E-5 ) ; ssSetSolverMaxOrder ( rtS , - 1 ) ;
ssSetSolverRefineFactor ( rtS , 1 ) ; ssSetOutputTimes ( rtS , ( NULL ) ) ;
ssSetNumOutputTimes ( rtS , 0 ) ; ssSetOutputTimesOnly ( rtS , 0 ) ;
ssSetOutputTimesIndex ( rtS , 0 ) ; ssSetZCCacheNeedsReset ( rtS , 0 ) ;
ssSetDerivCacheNeedsReset ( rtS , 0 ) ; ssSetNumNonContDerivSigInfos ( rtS ,
2 ) ; ssSetNonContDerivSigInfos ( rtS , nonContDerivSigInfo ) ;
ssSetSolverInfo ( rtS , & slvrInfo ) ; ssSetSolverName ( rtS ,
"VariableStepAuto" ) ; ssSetVariableStepSolver ( rtS , 1 ) ;
ssSetSolverConsistencyChecking ( rtS , 0 ) ; ssSetSolverAdaptiveZcDetection (
rtS , 0 ) ; ssSetSolverRobustResetMethod ( rtS , 0 ) ; ssSetAbsTolVector (
rtS , absTol ) ; ssSetAbsTolControlVector ( rtS , absTolControl ) ;
ssSetSolverAbsTol_Obsolete ( rtS , absTol ) ;
ssSetSolverAbsTolControl_Obsolete ( rtS , absTolControl ) ;
ssSetSolverStateProjection ( rtS , 0 ) ; ssSetSolverMassMatrixType ( rtS , (
ssMatrixType ) 0 ) ; ssSetSolverMassMatrixNzMax ( rtS , 0 ) ;
ssSetModelOutputs ( rtS , MdlOutputs ) ; ssSetModelLogData ( rtS ,
rt_UpdateTXYLogVars ) ; ssSetModelLogDataIfInInterval ( rtS ,
rt_UpdateTXXFYLogVars ) ; ssSetModelUpdate ( rtS , MdlUpdate ) ;
ssSetModelDerivatives ( rtS , MdlDerivatives ) ; ssSetSolverZcSignalAttrib (
rtS , zcAttributes ) ; ssSetSolverNumZcSignals ( rtS , 4 ) ;
ssSetModelZeroCrossings ( rtS , MdlZeroCrossings ) ;
ssSetSolverConsecutiveZCsStepRelTol ( rtS , 2.8421709430404007E-13 ) ;
ssSetSolverMaxConsecutiveZCs ( rtS , 1000 ) ; ssSetSolverConsecutiveZCsError
( rtS , 2 ) ; ssSetSolverMaskedZcDiagnostic ( rtS , 1 ) ;
ssSetSolverIgnoredZcDiagnostic ( rtS , 1 ) ; ssSetSolverMaxConsecutiveMinStep
( rtS , 1 ) ; ssSetSolverShapePreserveControl ( rtS , 2 ) ; ssSetTNextTid (
rtS , INT_MIN ) ; ssSetTNext ( rtS , rtMinusInf ) ; ssSetSolverNeedsReset (
rtS ) ; ssSetNumNonsampledZCs ( rtS , 4 ) ; ssSetContStateDisabled ( rtS ,
contStatesDisabled ) ; ssSetSolverMaxConsecutiveMinStep ( rtS , 1 ) ; }
ssSetChecksumVal ( rtS , 0 , 4012338573U ) ; ssSetChecksumVal ( rtS , 1 ,
4251839847U ) ; ssSetChecksumVal ( rtS , 2 , 452829803U ) ; ssSetChecksumVal
( rtS , 3 , 1755867169U ) ; { static const sysRanDType rtAlwaysEnabled =
SUBSYS_RAN_BC_ENABLE ; static RTWExtModeInfo rt_ExtModeInfo ; static const
sysRanDType * systemRan [ 2 ] ; gblRTWExtModeInfo = & rt_ExtModeInfo ;
ssSetRTWExtModeInfo ( rtS , & rt_ExtModeInfo ) ;
rteiSetSubSystemActiveVectorAddresses ( & rt_ExtModeInfo , systemRan ) ;
systemRan [ 0 ] = & rtAlwaysEnabled ; systemRan [ 1 ] = & rtAlwaysEnabled ;
rteiSetModelMappingInfoPtr ( ssGetRTWExtModeInfo ( rtS ) , &
ssGetModelMappingInfo ( rtS ) ) ; rteiSetChecksumsPtr ( ssGetRTWExtModeInfo (
rtS ) , ssGetChecksums ( rtS ) ) ; rteiSetTPtr ( ssGetRTWExtModeInfo ( rtS )
, ssGetTPtr ( rtS ) ) ; } return rtS ; }
#if defined(_MSC_VER)
#pragma optimize( "", on )
#endif
const int_T gblParameterTuningTid = - 1 ; void MdlOutputsParameterSampleTime
( int_T tid ) { UNUSED_PARAMETER ( tid ) ; }
